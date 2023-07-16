from flask import Flask, request, jsonify
from predict import make_pred

app = Flask(__name__)

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()
    print(data)
    weight = data['weight']
    cal_in = data['cal_in']
    cal_out = data['cal_out']

    # Make the prediction using the provided function
    prediction = make_pred(weight, cal_in, cal_out)

    response = jsonify({'prediction': prediction})    
    return response


if __name__ == '__main__':
    app.run()
