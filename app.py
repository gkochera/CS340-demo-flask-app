from flask import Flask
import os

# Configuration

app = Flask(__name__)

# Routes 

@app.route('/')
def root():
    return "Hello World!"

# Listener

if __name__ == "__main__":
    port = int(os.environ.get('PORT', 9113))
    app.run(host='0.0.0.0', port=9113)