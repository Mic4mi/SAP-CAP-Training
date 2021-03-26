const cds = require("@sap/cds");
const { Productos, Ordenes, Order_Details } = cds.entities;
const axios = require('axios');


module.exports = cds.service.impl(async (srv) => {

    srv.before('CREATE', 'Order_Details', async (req) => {
        const { producto_ID, orden_ID, cantidad } = req.data;
        const producto = await cds.run(SELECT.one.from(Productos).where({ ID: producto_ID }));
        if (producto) {
            producto.unidadesEnUnaOrden += cantidad;
            producto.unidadesEnStock -= cantidad;

            if (producto.unidadesEnStock < 0) {

                /* Si la Orden no tiene otras order_details, y no se puede generar una order_details por
                falta de stock, deberia poder borrarse la orden en sí, pero no estaria funcionando.*/
                try {
                    let detalles = await cds.run(SELECT.from(Order_Details).where({ orden_ID: orden_ID }));
                    if (detalles.lenght === 0) {
                        await cds.run(DELETE.from(Ordenes).where({ ID: orden_ID })); // Esto no está andando. 
                    }

                } catch (err) {
                    console.log("no se ha ejecutado el borado");
                    console.log(err);
                }

                throw new Error("No se ha podido generar la orden porque no hay stock suficiente.");
            } else {
                console.log("Se modificó el stock con exito.");
            }

        } else {
            console.log("no existe el producto");
        }

    });
});