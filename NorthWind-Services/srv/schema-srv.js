const cds = require("@sap/cds");
const { Productos, Ordenes, Order_Details } = cds.entities;
const axios = require('axios');


module.exports = cds.service.impl(async (srv) => {

    srv.before('READ', 'Productos', async (req) => {
        await axios.get('https://services.odata.org/Experimental/Northwind/Northwind.svc/Products')
            .then(async function (response) {
                try {
                    const todosLosProductos = response.data.value;
                    let productos = [];
                    for (let producto of todosLosProductos) { //Hacer un solo insert;
                        productos.push({
                            ID: producto.ProductID,
                            nombre: producto.ProductName,
                            cantidadxunidad: producto.QuantityPerUnit,
                            precioUnitario: producto.UnitPrice,
                            unidadesEnStock: producto.UnitsInStock,
                            unidadesEnUnaOrden: producto.UnitsOnOrder,
                            reordenarNivel: producto.ReorderLevel,
                            decontinuado: producto.Discontinued
                        });
                    }
                    await cds.run(INSERT.into(Productos).entries(productos));
                    console.log("Se han insertado los productos correctamente.");

                } catch (err) {
                    console.log("Ha ocurrido un error");
                    console.log(err);
                    return "Ha ocurrido un error al insertar los datos de los productos";
                }
            })
            .catch(function (err) {
                console.log(err);
                console.log("Hay errores");
                return "Ha ocurrido un error al intendar dar con la url Productos";
            });
    });

    srv.before('READ', 'Ordenes', async (req) => {
        await axios.get('https://services.odata.org/Experimental/Northwind/Northwind.svc/Orders')
            .then(async function (response) {

                try {
                    const todasLasOrdenes = response.data.value;
                    let ordenes = [];
                    for (let orden of todasLasOrdenes) { //Hacer un solo insert;
                        ordenes.push({
                            ID: orden.OrderID,
                            fechaDeLaOrden: orden.OrderDate,
                            fechaRequerida: orden.RequiredDate,
                            fechaDeEnvio: orden.ShippedDate,
                            codigoShipVia: orden.ShipVia,
                            transporte: orden.Freight,
                            nombreDelTransporte: orden.ShipName,
                            direccionDeEnvio: orden.ShipAddress,
                            ciudadDeEnvio: orden.ShipCity,
                            regionDeEnvio: orden.ShipRegion,
                            codigoPortalDeEnvio: orden.ShipPostalCode,
                            paisDeEnvio: orden.ShipCountry
                        });
                    }
                    await cds.run(INSERT.into(Ordenes).entries(ordenes));
                    console.log("Se han insertado las ordenes correctamente.");
                } catch (err) {
                    console.log("Ha ocurrido un error");
                    console.log(err);
                    return "Ha ocurrido un error al insertar los datos de las ordenes";
                }
            })
            .catch(function (error) {
                console.log(err);
                console.log("Hay errores");
                return "Ha ocurrido un error al intendar dar con la url Ordenes";
            });
    });

    srv.before('READ', 'Order_Details', async (req) => {
        axios.get('https://services.odata.org/Experimental/Northwind/Northwind.svc/Order_Details')
            .then(function (response) {
                try {
                    const todasLasAsociaciones = response.data.value;
                    let asociaciones = [];
                    for (let asociacion of todasLasAsociaciones) { //Hacer un solo insert;
                        asociaciones.push({
                    
                        });
                    }
                    await cds.run(INSERT.into(Order_Details).entries(asociaciones));
                    console.log("Se han insertado las asociaciones 'order_details' correctamente.");
                } catch (err) {
                    console.log("Ha ocurrido un error");
                    console.log(err);
                    return "Ha ocurrido un error al insertar los datos de las ordenes";
                }
                
            })
            .catch(function (err) {
                console.log(err);
                console.log("Hay errores");
                return "Ha ocurrido un error al intendar dar con la url Order_Details";
            })

    });

});






