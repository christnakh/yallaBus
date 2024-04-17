import pandas as pd
import joblib
from flask import Flask, request, jsonify
from flask_cors import CORS 

app = Flask(__name__)
CORS(app)  

loaded_model = joblib.load("decision_tree_model_2_81%.joblib")
custom_names = {
    'routeA': 'Antelias-Tripoli',
    'routeB': 'Khalde-Tyre',
    'routeC': 'Hazmieh-Baalbak'
}
@app.route('/predict', methods=['POST'])
def predict():
    try:
        data = request.get_json()
     
        data_df = pd.DataFrame(data)

        predictions = loaded_model.predict(data_df)
        
        custom_predictions = [custom_names[prediction] for prediction in predictions]

        return jsonify({'predictions': custom_predictions})
    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001, debug=True)
