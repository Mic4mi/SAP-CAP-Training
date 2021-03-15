const cds = require("@sap/cds");
const { modInven, Inventory, Books } = cds.entities;

module.exports = cds.service.impl(async (srv) => {

    srv.on("modInven", async req => {
        try {
            console.log("Por modificar el almacen...");
            //Hacemos un request data de los parametros de la action y lo guardamos en una constante
            const { book, amount } = req.data
            /*Hacemos un select del inventario donde book_ID sea igual al libro del inventario
            Empleamos await para asegurarnos de que se complete la ejecusion del cds run*/
            const arrBooks = await cds.run(SELECT.from(Inventory).where({ book_ID: book }));

            if (arrBooks.length > 0) {
                console.log("Antes de actualizar!");
                /*Acá le decimos que le vamos a hace un update a inventorio en el campo quantity 
                donde el libro id sea el libro que le pasamos*/
                await cds.run(UPDATE(Inventory).with({ quantity: { '+=': amount } }).where({ book_ID: book }));
                console.log(`Se actualizó correctamente ${book}`);
                return "Todo salió bien";
            } else {
                console.log("No esta registrado en el almacén");
                return ("No se produjo el cambio porque no hay libro registrado en el almacén");
            }

        } catch (err) {
            console.log("Ha ocurrido un error al intentar modificar el almacen");
            console.log(err);
        }

    });

    srv.on("insertOrder", async req => {
        try {
            console.log("Entrando a insertar en almacen....");
            //Hacemos un request data de los parametros de la action y lo guardamos en una constante
            const { book } = req.data;

            //Insertamos en inventario un libro
            if (await cds.run(INSERT.into(Inventory).entries(req.data.book))) {
                return "La inserción ha salido bien!";
            }

        } catch (err) {
            console.log(err);
            return "Error al intentar procesar la inserción"
        }
    });

});

