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
        print("POST -- Z")
        if 'image' not in request.files:
            print('file image can\'t find!')
            return 'No file part'
        print("pass")
        file = request.files['image']
        print(file.filename)
        file.save(os.path.join("./img", "123.jpg"))
        print("success")
        return 'success'


if __name__ == '__main__':
    app.run(debug=True)