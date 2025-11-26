exports.handler = async (event) => {
    const response = {
        statusCode: 200,
        body: JSON.stringify({
            message: '¡Hola! Desplegado automáticamente desde GitHub',
            timestamp: new Date().toISOString(),
            version: '1.0.0'
        })
    };
    return response;
};
