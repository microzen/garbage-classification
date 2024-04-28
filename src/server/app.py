from openai import OpenAI
from flask import Flask, jsonify, request
from flask_cors import CORS
import base64
import os

client = OpenAI

def encode_image(image_path):
  with open(image_path, "rb") as image_file:
    return base64.b64encode(image_file.read()).decode('utf-8')

app = Flask(__name__)

CORS(app, resources={r"/*": {"origins": "*"}})
@app.route('/upload', methods=['GET','POST'])
def test_image_processing():
    # Path to your image
    if request.method == 'POST':
        if 'image' not in request.files:
            return 'No file part'
        file = request.files['img']
        file.save(os.path.join("./img", "123.jpg"))
        print("success")
        return 'success'


if __name__ == '__main__':
    app.run(debug=True)