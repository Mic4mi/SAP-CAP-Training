const cds = require("@sap/cds");
const { Productos, Ordenes, Order_Details } = cds.entities;
const axios = require('axios');


module.exports = cds.service.impl(async (srv) => {

    srv.on('modificarStock', async (req) => {
        try {
            console.log("Antes de actualizar!");
            const { productoID, stock } = req.data
            const producto = await cds.run(SELECT.one.from(Productos).where({ ID: productoID }));

            if (producto) {
                await cds.run(UPDATE(Productos).with({ unidadesEnStock: stock }).where({ ID: productoID }));
                return "Se actualizó la cantidad correctamente";
            } else {
                return "No se produjo el cambio porque no existe ese producto";
            }

        } catch (err) {
            console.log("Ha ocurrido un error al intentar modificar la cantidad del producto");
            console.log(err);
            return "Algo salió mal";
        }
    });

    /*    7*srv.on('POST', 'Ordenes', async (req) => {
            
            - El usuario puede cargar ordenes nuevas en la que tenga q especificar 
            
        });*/


});







