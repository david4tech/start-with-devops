exports.handler = async (event) => {
    const response = {
        statusCode: 200,
        body: JSON.stringify({
            message: '¡Hola! Desplegado automáticamente desde GitHub hoy miércoles para evitar problemas el viernes',
            timestamp: new Date().toISOString(),
            version: '1.1.0'
        })
    };
    return response;
};
