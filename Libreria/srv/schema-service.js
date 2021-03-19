const cds = require("@sap/cds");
const { Books, Authors, Log } = cds.entities;

module.exports = cds.service.impl(async (srv) => {

    //Antes y despues de crear un 'Books'
    /*   srv.before('CREATE', 'Books', async req => {
           try {
               // console.log(req._.req.query); // Para capturar una query de la url
               console.log("Antes de crear (Before)");
               //console.log(req.data);
               //console.log(req.body);
               //console.log(req);
           } catch (err) {
               console.log(err);
               console.log("Ha ocurrido un error al intentar crear (Before)");
           }
       }); */

    srv.after('CREATE', 'Books', async (data, req) => {
        try {
            console.log(data);

            try {
                if (cargarLog(req.method, data.ID, data.name)) {
                    console.log("El Log se ha cargado correctamente!");
                }
            } catch (err) {
                console.log("Ha ocurrido un error en el log: ");
                console.log(err);
            }

            console.log("Despues de crear (After)");

        } catch (err) {
            console.log(err);
            console.log("Ha ocurrido un error al intentar crear (After)");
        }
    });

    let objetoBorrado;
    //Antes y despues de borrar un 'Books'
    srv.before('DELETE', 'Books', async req => {
        try {

            //const bookID = req.data.ID;
            //objetoBorrado = await cds.run(SELECT.from(Books).where({ ID: req.data.ID }));
            //console.log("Antes de borrar (Before)");
            //console.log(req.data);

        } catch (err) {
            console.log(err);
            console.log("Ha ocurrido un error al intentar borrar");
        }
    });

    srv.after('DELETE', 'Books', async (data, req) => {
        try {

            try {
                if (cargarLog(req.method, req.data.ID, "holhola")) {
                    console.log("El Log de borrado se ha cargado correctamente!");
                }
            } catch (err) {
                console.log("Ha ocurrido un error en el log de borrado: ");
                console.log(err);
            }

            console.log("Despues de borrar (After)");

        } catch (err) {
            console.log(err);
            console.log("Ha ocurrido un error al intentar borrar");
        }
    });

    //Antes y despues de editar un 'Books'
    srv.before('UPDATE', 'Books', async req => {
        try {
            console.log("Antes de editar (Before)");
            console.log(req.data);
        } catch (err) {
            console.log(err);
            console.log("Ha ocurrido un error al intentar editar");
        }
    });

    srv.after('UPDATE', 'Books', async (data, req) => {
        try {

            try {
                if (cargarLog(req.method, data.ID, data.name)) {
                    console.log("El Log de editado se ha cargado correctamente!");
                }
            } catch (err) {
                console.log("Ha ocurrido un error en el log: ");
                console.log(err);
            }

            console.log("Despues de editar (After)");
        } catch (err) {
            console.log(err);
            console.log("Ha ocurrido un error al intentar editar");
        }
    });

    //Antes y despues de crear un 'Books'
    srv.before('CREATE', 'Authors', async req => {
        try {
            console.log("Antes de crear un Autor (Before)");
            console.log(req.data);
            //console.log(req);
        } catch (err) {
            console.log(err);
            console.log("Ha ocurrido un error al intentar crear");
        }
    });

    srv.after('CREATE', 'Authors', async req => {
        try {
            console.log("Despues de crear un Autor (After)");
        } catch (err) {
            console.log(err);
            console.log("Ha ocurrido un error al intentar crear");
        }
    });

    //Antes y despues de borrar un 'Authors'
    srv.before('DELETE', 'Authors', async req => {
        try {
            console.log("Antes de borrar un Autor(Before)");
            console.log(req.data);
        } catch (err) {
            console.log(err);
            console.log("Ha ocurrido un error al intentar borrar");
        }
    });

    srv.after('DELETE', 'Authors', async req => {
        try {
            console.log("Despues de borrar un Autor(After)");
        } catch (err) {
            console.log(err);
            console.log("Ha ocurrido un error al intentar borrar");
        }
    });

    //Antes y despues de editar un 'Books'
    srv.before('UPDATE', 'Authors', async req => {
        try {
            console.log("Antes de editar un Autor(Before)");
            console.log(req.data);
        } catch (err) {
            console.log(err);
            console.log("Ha ocurrido un error al intentar editar");
        }
    });

    srv.after('UPDATE', 'Authors', async req => {
        try {
            console.log("Despues de editar un Autor(After)");
        } catch (err) {
            console.log(err);
            console.log("Ha ocurrido un error al intentar editar");
        }
    });

});


//Cargar el log;
async function cargarLog(metodo, id, name) {
    const log = {
        metodo: metodo,
        libroId: id,
        libroNombre: name
    }

    await cds.run(INSERT.into(Log).entries(log));
}

