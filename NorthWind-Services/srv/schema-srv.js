const cds = require("@sap/cds");
const { Productos, Ordenes, Order_Details } = cds.entities;
const axios = require('axios');


module.exports = cds.service.impl(async (srv) => {

    srv.on('DELETE', 'Productos', async (req) => {
        req.reject(405, "Method not allowed");
    });

    srv.before('CREATE', 'Order_Details', async (req) => {
        const { producto_ID, orden_ID, cantidad } = req.data;
        const producto = await cds.run(SELECT.one(Productos).where({ ID: producto_ID }));
        if (producto) {
            let unidadesEnUnaOrden = producto.unidadesEnUnaOrden += cantidad;
            let unidadesEnStock = producto.unidadesEnStock -= cantidad;

            if (unidadesEnStock < 0) {
                /* Si la Orden no tiene otras order_details, y no se puede generar una order_details por
                falta de stock, deberia poder borrarse la orden en sí, pero no estaria funcionando.*/
                try {
                    let detalles = await cds.run(SELECT.from(Order_Details).where({ orden_ID: orden_ID }));
                    if (detalles.length === 0) {
                        await cds.run(DELETE.from('Ordenes').where({ ID: orden_ID })); // Esto no está andando. 
                    }

                } catch (err) {
                    console.log("no se ha ejecutado el borado");
                    console.log(err);
                }

                throw new Error("No se ha podido generar la orden porque no hay stock suficiente.");
            } else {
                await cds.run(UPDATE(Productos).set({unidadesEnStock : unidadesEnStock, unidadesEnUnaOrden: unidadesEnUnaOrden}).where({ID: producto_ID}));
                console.log("Se modificó el stock con exito.");
            }

        } else {
            console.log("no existe el producto");
        }

    });


    srv.on('calcVenta', async (req) => {
        try {
            console.log("Por procesar la venta")
            const { orderDetailID } = req.data,
                orderDetail = await cds.run(SELECT.one(Order_Details).where({ ID: orderDetailID })),
                cantidad = orderDetail.cantidad,
                precioUnitario = orderDetail.precioUnitario,
                porcentajeDeDescuento = orderDetail.descuento;
            let venta = cantidad * precioUnitario,
                descuento = (venta * porcentajeDeDescuento) / 100,
                ingresoTotal = venta - descuento,
                resultadoObj = {
                    precioPorUnidad: precioUnitario,
                    cantidad: cantidad,
                    porcentajeDeDescuento: porcentajeDeDescuento.toFixed(2),
                    descuento: descuento.toFixed(2),
                    total: venta.toFixed(2),
                    totalFinal: ingresoTotal.toFixed(2)
                }

            return resultadoObj;
        } catch (err) {
            console.log(err);
            return "Ha ocurrido un error."
        }
    });

    srv.on('buscarProductos', async (req) => {
        try {
            const { criterio } = req.data,
                criterios = criterio.split(" ");
            let producto,
                productosFiltrados = [],
                expresionLike = "";

            for (let i = 0; i < criterios.length; i++) {
                expresionLike += `nombre like '%${criterios[i]}%'`;

                if (i < criterios.length - 1) {
                    expresionLike += " or ";
                }
            }

            const productos = await cds.run(SELECT.from(Productos).where(expresionLike));

            for (producto of productos) {
                productosFiltrados.push({
                    ID: producto.ID,
                    nombre: producto.nombre
                });
            }

            return productosFiltrados;

        } catch (err) {
            console.log("Ha ocurrido un error");
            console.log(err);
        }
    });
    
});