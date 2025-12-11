exports.handler = async (event) => {
    const response = {
        statusCode: 200,
        body: JSON.stringify({
            message: '¡Hola! Desplegado automáticamente para el equipo de DevOps',
            timestamp: new Date().toISOString(),
            version: '1.1.0'
        })
    };
    return response;
};
