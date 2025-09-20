from flask import Flask
import os 

app = Flask(__name__)

@app.route("/")
def hello():
    return "It's a Flask appliation running on Pod! and a new version. "

if __name__ == "__main__":
    app.run(host='0.0.0.0',port=5001, debug=False)