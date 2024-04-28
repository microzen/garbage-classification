from openai import OpenAI
from flask import Flask, jsonify, request
from flask_cors import CORS

client = OpenAI()
app = Flask(__name__)

CORS(app, resources={r"/*": {"origins": "*"}})
@app.route('/event',methods=['GET'])
def ReturnJSON():
    if(request.method == 'GET'):
      completion = client.chat.completions.create(
        model="gpt-4-turbo",
        messages=[
          {"role": "system", "content": "You are a poetic assistant, skilled in explaining complex programming concepts with creative flair."},
          {"role": "user", "content": "Compose a poem that explains the concept of recursion in programming."}
        ]
      )
      return completion.choices[0].message.content