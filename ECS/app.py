from flask import Flask, jsonify
import os
import socket

app = Flask(__name__)


@app.route("/")
def index():
    return jsonify({
        "message": "Hello from ECS Fargate!",
        "hostname": socket.gethostname(),
        "env": os.environ.get("APP_ENV", "not set"),
    })


@app.route("/health")
def health():
    return jsonify({"status": "healthy"}), 200


if __name__ == "__main__":
    # 0.0.0.0 so the container is reachable from outside itself
    app.run(host="0.0.0.0", port=8080)
