from flask import Flask, render_template
app = Flask(__name__)
from flup.server.fcgi import WSGIServer

@app.route("/")
def index():
    return render_template('index.html', **locals())

if __name__ == "__main__":
    WSGIServer(app,bindAddress='/tmp/gn-drive.sock').run()
    #app.run(host='0.0.0.0')
