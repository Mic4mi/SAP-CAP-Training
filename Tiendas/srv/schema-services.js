const cds = require("@sap/cds");
const { Productos, Duenos, Duenos_Tiendas } = cds.entities;

module.exports = cds.service.impl(async (srv) => {

    /*
    Cuando hago un POST de un Dueno nuevo, ya le paso por url 
    los IDS de Tienda e inserto en Duenos_Tienda la relacion
    */

    srv.after('CREATE', 'Duenos', async (data, req) => {
        try {
            const duenoID = req.data.ID;
            const { Tiendas } = req._.req.query;
            if (Tiendas) {
                const arrTiendas = Tiendas.split(',');

                arrTiendas.forEach(element => {
                    cds.run(INSERT.into(Duenos_Tiendas).columns('duenos_ID', 'tiendas_ID').values(duenoID, element));
                });

                console.log("Salió todo bien!");
            } else {
                console.log("No se hallaron tiendas");
            }
        } catch (err) {
            console.log("Ha ocurrido un error: ");
            console.log(err);
        }

    });


    /*
    Action para actualizar precios por conjunto de productos
    */
    srv.on("modificarPrecio", async req => {
        try {
            console.log("Antes de actualizar!");
            const { producto, precio } = req.data
            const arrProductos = await cds.run(SELECT.from(Productos).where({ ID: producto }));
            if (arrProductos.length > 0) {
                await cds.run(UPDATE(Productos).with({ valor: precio }).where({ ID: producto }));
                return "Se actualizó el precio correctamente";
            } else {
                return ("No se produjo el cambio porque no hay un producto registrado");
            }

        } catch (err) {
            console.log("Ha ocurrido un error al intentar modificar el precio del producto");
            console.log(err);
        }

    });

});


