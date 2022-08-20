from flask import Flask, jsonify, request,json
import redis



app = Flask(__name__)

client = redis.StrictRedis(host="redis", port=6379,db=0, password=None)

def metrics_redis():
    memory = client.config_get(('maxmemory',{'maxmemory': '0'}))
    info_general = client.info()
    print({'Maxmemory': memory},{'Info':info_general})

def health():
    if client.ping():
        print("PONG")
    else:
        print("Connection failed!")


@app.route('/apis/queue/push', methods=['POST'])
def push():
    if request.method == 'POST':
        body = request.get_json()
        client.rpush("queu",json.dumps(body))
        return jsonify({'status': 'ok'})


@app.route("/apis/queue/pop", methods=['POST'])
def pop():
    Status = "OK"
    if request.method == 'POST':
        if client.llen("queu") > 0:
            response = client.blpop("queu") 
        else:
            return jsonify({'status': 'ok'}, {'Body': "No hay Dato"})
    return jsonify({'status': 'ok'}, {'Body': str(response)})


@app.route('/apis/queue/count', methods=['GET'])
def count_queue():
    status = "OK"
    if request.method == 'GET':
        counts = client.llen("queu")
    return jsonify({"count": counts})


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port='5001')