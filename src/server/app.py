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
    if request.method == 'GET':
       prompt = f"What is this? What kind of garbage is this? Rate this on a scale of 10. The larger the number, the more hazardous it is."
        
        try:
            completion = client.chat.completions.create(
                model="gpt-4-turbo",
                messages=[
                    {"role": "system", "content": "You are a garbage classifier"},
                    {"role": "assistant", "content": "This is a lithium-based battery. 10. Hazardous waste."},
                    {"role": "user", "content": prompt},
                    {
                        "type": "image_url",
                        "image_url": {
                            "url": f"data:image/jpeg;base64,{base64_message}"
                        }
                     }
                ],
                max_tokens=300  # Limit the tokens of the response
            )
            response_content = completion.choices[0].message.content
            return jsonify({'chatgpt_response': response_content})
        except Exception as e:
            return jsonify({'error': str(e)}), 500

    # Path to your image
    if request.method == 'POST':
        if 'image' not in request.files:
            return 'No file part'
        file = request.files['img']
        file.save(os.path.join("./img", filename))
        print("success")
        return 'success'


if __name__ == '__main__':
    app.run(debug=True)