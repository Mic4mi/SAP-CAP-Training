const cds = require("@sap/cds");
const { Proyectos, Tecnologias } = cds.entities;


module.exports = cds.service.impl(async (srv) => {

    srv.on('calcularCosto', async (req) => {

        try {
            const { proyectoID } = req.data;
            // Primero seleccionamos el proyecto que nos coincida con el ID recbido
            let proyecto = await cds.run(SELECT.one.from(Proyectos).where({ ID: proyectoID }));

            if (proyecto) {
                let total = 0;
                let mensaje;
                /* Para obtener la sumatoria de los salarios por x tecnologia, nos tenemos que traer
                aquellas tecnologias que coincidan con las tecnologias que estan dentro del array 
                de tecnologias del proyecto*/
                let tecnologias = await cds.run(SELECT.from(Tecnologias).where({ ID: proyecto.tecnologias }));
                for (let tecnologia of tecnologias) {
                    total += tecnologia.salario;
                }

                switch (proyecto.dificultad) {
                    case 1:
                        total *= 1;
                        mensaje = `El proyecto tiene una estimación de 1 mes a $${total}`;
                        break;
                    case 3:
                        total *= 6;
                        mensaje = `El proyecto tiene una estimación de 6 meses a $${total}`;
                        break;
                    case 5:
                        total *= 12;
                        mensaje = `El proyecto tiene una estimación de 1 año a $${total}`;
                        break;
                    default:
                        mensaje = `No hay una evaluación para este caso.`;
                        break;
                }

                return mensaje;

            } else {
                return "No se ha encontrado esa información.";
            }
        } catch (err) {
            console.log(err);
            return "Ha ocurrido un error durante la ejecución"
        }

    });

});