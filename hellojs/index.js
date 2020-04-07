exports.handler = async (event) => {
    // TODO implement
    
    const STAGE = process.env.STAGE;
    
    const response = {
        statusCode: 200,
        body: JSON.stringify({
            'message': `Hello from Javascript Lambda! (env: ${STAGE})`
        }),
    };
    return response;
};