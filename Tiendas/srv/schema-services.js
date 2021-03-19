const cds = require("@sap/cds");
const { Productos, Duenos, Duenos_Tiendas, Tiendas_Productos } = cds.entities;

module.exports = cds.service.impl(async (srv) => {

    /*
    Control de stock de productos: action q retira cantidades 
    de productos y agrega cantidad, con id y cantidad. Los 
    productos tendrán un min y máximo q disparara alerta al 
    llegar a los mismos.
    */

    srv.on('controlDeStock', async (req) => {

        console.log("Antes de modificar el stock xd!");

        try {
            let mensaje = "Perfecto, el stock esta en buenas condiciones";
            const { producto_tienda_ID, cantidad } = req.data;
            let tiendasProductos = await cds.run(SELECT.from(Tiendas_Productos).where({ ID: producto_tienda_ID }));

            if (tiendasProductos.length > 0) {
                let minimo = tiendasProductos[0].minStock;
                let maximo = tiendasProductos[0].maxStock;
                let stock = tiendasProductos[0].stock;
                let stockActualizable = stock + cantidad;

                if (stockActualizable < 0) {
                    mensaje = "El minimo no puede ser menor que cero";
                    return mensaje;
                }

                if (stockActualizable < minimo) {
                    mensaje = "Tienes pocos articulos, debes realizar un pedido pronto";
                } else if (stockActualizable > maximo) {
                    mensaje = "Tienes demasiados articulos";
                }

                await cds.run(UPDATE(Tiendas_Productos).with({ stock: { '+=': cantidad } }).where({ ID: producto_tienda_ID }));

                return mensaje;
            } else {
                console.log("No se ha encontrado informacion.");
            }

        } catch (err) {
            console.log("Ha ocurrido un error: ");
            console.log(err);
            return "Algo salió mal";
        }

    });

    /*
    Cuando hago un POST de un Dueno nuevo, ya le paso por url 
    los IDS de Tienda e inserto en Duenos_Tienda la relacion
    */

    srv.after('CREATE', 'Duenos', async (data, req) => { //Arreglar el foreach, primero hacer un array
        try {
            const duenoID = req.data.ID;
            const { Tiendas } = req._.req.query;
            if (Tiendas) {
                const arrTiendas = Tiendas.split(',');

                for (let tiendaID of arrTiendas) {
                    await cds.run(INSERT.into(Duenos_Tiendas).columns('duenos_ID', 'tiendas_ID').values(duenoID, tiendaID));
                }

                console.log("Salió todo bien!");
            } else {
                console.log("No se hallaron tiendas");
            }
        } catch (err) {
            console.log("Ha ocurrido un error: ");
            console.log(err);
            return "Algo salió mal";
        }

    });


    /*
    Action para actualizar precios por conjunto de productos
    */
    srv.on('modificarPrecio', async req => {
        try {
            console.log("Antes de actualizar!");
            const { productoID, precio } = req.data
            const arrProductos = await cds.run(SELECT.from(Productos).where({ ID: productoID }));

            if (arrProductos.length > 0) {
                await cds.run(UPDATE(Productos).with({ valor: precio }).where({ ID: productoID }));
                return "Se actualizó el precio correctamente";
            } else {
                return "No se produjo el cambio porque no hay un producto registrado";
            }

        } catch (err) {
            console.log("Ha ocurrido un error al intentar modificar el precio del producto");
            console.log(err);
            return "Algo salió mal";
        }

    });

});


