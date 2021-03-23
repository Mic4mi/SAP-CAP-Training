const cds = require("@sap/cds");
const { Tecnologias } = cds.entities;
const axios = require('axios');
const schedule = require('node-schedule');
const https = require('https');
const agent = new https.Agent({ rejectUnauthorized: false });


const job = schedule.scheduleJob('1 * * * * *', function () {
    axios.get('https://discovery-center.cloud.sap/platformx/Services',
        {
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            },
            httpsAgent: agent,
            rejectUnauthorized: false
        })
        .then(async function (response) {
            // handle success  
            try {
                const tecnologias = response.data.d.results;
                let modelo = [];
                for (let tecnologia of tecnologias) { //Hacer un solo insert;
                    //await cds.run(INSERT.into(Tecnologias).columns('shortName', 'shortDesc').values(tecnologia.ShortName, tecnologia.ShortDesc));
                    modelo.push({
                        shortName: tecnologia.ShortName,
                        shortDesc: tecnologia.ShortDesc
                    });
                }
                await cds.run(DELETE.from(Tecnologias));
                await cds.run(INSERT.into(Tecnologias).entries(modelo));
                console.log("Ha salido todo correctamente.");

            } catch (err) {
                console.log("Ha ocurrido un error");
                console.log(err);
                return "Ha ocurrido un error";
            }

        })
        .catch(function (error) {
            // handle error
            console.log(error);
            console.log("Hay Error/es: ");
        })
        .then(function () {
            // always executed
        });
});

