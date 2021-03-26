const cds = require('@sap/cds');

const axios = require('axios');

cds.on('served', async () => {

    const { Productos, Ordenes, Order_Details } = cds.entities;

    await getProducts('Products');
    await getOrders('Orders');
    await getAsociations('Order_Details');

    async function getAsociations(url) {
        await axios.get(`https://services.odata.org/Experimental/Northwind/Northwind.svc/${url}`)
            .then(async function (response) {
                try {
                    const todasLasAsociaciones = response.data.value;
                    let asociaciones = [];
                    for (let asociacion of todasLasAsociaciones) {
                        asociaciones.push({
                            orden_ID: asociacion.OrderID,
                            producto_ID: asociacion.ProductID,
                            precioUnitario: asociacion.UnitPrice,
                            cantidad: asociacion.Quantity,
                            descuento: asociacion.Discount,
                        });
                    }
                    await cds.run(INSERT.into(Order_Details).entries(asociaciones));
                    console.log("Se han insertado las asociaciones 'order_details' correctamente.");
                    let nextLink = response.data['@odata.nextLink'];
                    if (nextLink) {
                        await getAsociations(nextLink);
                    }

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

    }

    async function getOrders(url) {
        await axios.get(`https://services.odata.org/Experimental/Northwind/Northwind.svc/${url}`)
            .then(async function (response) {
                try {
                    const todasLasOrdenes = response.data.value;
                    let ordenes = [];
                    for (let orden of todasLasOrdenes) {
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
                            paisDeEnvio: orden.ShipCountry,
                            informacionAdicionalID: orden.ShipRegion ? `${orden.ShipRegion}-${orden.OrderDate}` : orden.OrderDate
                        });
                    }
                    await cds.run(INSERT.into(Ordenes).entries(ordenes));
                    console.log("Se han insertado las ordenes correctamente.");

                    let nextLink = response.data['@odata.nextLink'];
                    if (nextLink) {
                        await getOrders(nextLink);
                    }

                } catch (err) {
                    console.log("Ha ocurrido un error");
                    console.log(err);
                    return "Ha ocurrido un error al insertar los datos de las ordenes";
                }
            })
            .catch(function (err) {
                console.log(err);
                console.log("Hay errores");
                return "Ha ocurrido un error al intendar dar con la url Ordenes";
            });
    }

    async function getProducts(url) {
        await axios.get(`https://services.odata.org/Experimental/Northwind/Northwind.svc/${url}`)
            .then(async function (response) {
                try {
                    const todosLosProductos = response.data.value;
                    let productos = [];
                    for (let producto of todosLosProductos) {
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

                    let nextLink = response.data['@odata.nextLink'];
                    if (nextLink) {
                        await getProducts(nextLink);
                    }

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
    }

});

module.exports = cds.server;