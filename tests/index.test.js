const { handler } = require('../src/index');

test('Lambda returns 200', async () => {
    const result = await handler({});
    expect(result.statusCode).toBe(200);
});

test('Lambda returns message', async () => {
    const result = await handler({});
    const body = JSON.parse(result.body);
    expect(body.message).toContain('DevOps');
});
