from openai import OpenAI
from flask import Flask, jsonify, request
from flask_cors import CORS
import base64
import os
import requests

# OpenAI API Key
def encode_image(image_path):
  with open(image_path, "rb") as image_file:
    return base64.b64encode(image_file.read()).decode('utf-8')

# Path to your image
image_path = "./img/IMG_5474.jpg"


app = Flask(__name__)

CORS(app, resources={r"/*": {"origins": "*"}})
@app.route('/upload', methods=['GET','POST'])
def test_image_processing():
    headers = {
          "Content-Type": "application/json",
          "Authorization": f"Bearer {api_key}"
        }
    prompt = f"What is this? What kind of garbage is this? What is the material of it? Answer these three questions in seperate and concise answers. The first and third answers limit into 2 words respectively. The second answer is more than one sentence.Seperate them with *"
    
    if request.method == 'GET':
        
        base64_image = encode_image(image_path)
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
                    "text": "sample output: Battery"
                  },
                  {
                    "type": "text",
                    "text": "sample output: Ensure it is empty and rinse it out if possible."
                  },
                  {
                    "type": "text",
                    "text": "sample output: aluminum"
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
        return response.json()
    # Path to your image
    if request.method == 'POST':
        if 'image' not in request.files:
            print('file image can\'t find!')
            return 'No file part'
        file = request.files['image']
        base64_image = base64.b64encode(file.read()).decode('utf-8')
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
                    "text": "sample output: Battery"
                  },
                  {
                    "type": "text",
                    "text": "sample output: Ensure it is empty and rinse it out if possible."
                  },
                  {
                    "type": "text",
                    "text": "sample output: aluminum"
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