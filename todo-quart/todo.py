from quart import Quart, jsonify, request
from quart.helpers import make_response

app = Quart(__name__)

@app.route('/todos')
async def todos():
    resp = await make_response(jsonify({
        'todos': [
            { 'item': 'first' },
            { 'item': 'secondpy' }
        ]
    }))

    resp.headers['Access-Control-Allow-Origin'] = '*'
    return resp

TODO_CORS_HEADERS = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'POST',
    'Access-Control-Allow-Headers': 'content-type'
}

@app.route('/todo/item', methods=['POST'], provide_automatic_options=False)
async def todo():
    item = await request.get_json()
    resp = await make_response(jsonify(item=item['item']))
    resp.headers.update(TODO_CORS_HEADERS)
    return resp

@app.route('/todo/item', methods=['OPTIONS'], provide_automatic_options=False)
async def todo_options():
    return '', TODO_CORS_HEADERS

if __name__ == '__main__':
    app.run(host='0.0.0.0')
