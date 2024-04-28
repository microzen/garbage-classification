from openai import OpenAI
from flask import Flask, jsonify, request
from flask_cors import CORS
import base64
import os
import requests

# OpenAI API Key


app = Flask(__name__)

CORS(app, resources={r"/*": {"origins": "*"}})
@app.route('/upload', methods=['GET','POST'])
def test_image_processing():
    # Path to your image
    if request.method == 'POST':
        if 'image' not in request.files:
            print('file image can\'t find!')
            return 'No file part'
        file = request.files['image']
        base64_image = base64.b64encode(file.read()).decode('utf-8')

        headers = {
          "Content-Type": "application/json",
          "Authorization": f"Bearer {api_key}"
        }
        prompt = f"What is this? What kind of garbage is this? Rate this on a scale of 10. The larger the number, the more hazardous it is."
        payload = {
            "model": "gpt-4-turbo",
            "messages": [
              {"role": "user", "content": [
                  {
                    "type": "text",
                    "text": prompt
                  },
                  {
                    "type": "text",
                    "text": "You are a garbage classifier"
                  },
                  {
                    "type": "text",
                    "text": "This is a lithium-based battery. 10. Hazardous waste."
                  },
                  {
                    "type": "image_url",
                    "image_url": {
                      "url": f"data:image/jpeg;base64,{base64_image}"
                    }
                  }
                ]
              }
            ],
            "max_tokens": 300
        }

        response = requests.post("https://api.openai.com/v1/chat/completions", headers=headers, json=payload)
        print(response.json())
        return response.json()


if __name__ == '__main__':
    app.run(debug=True)