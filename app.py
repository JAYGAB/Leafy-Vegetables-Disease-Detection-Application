from flask import Flask, request, jsonify
import tensorflow as tf
import numpy as np
from PIL import Image
import io

app = Flask(__name__)

# Load the TensorFlow model
model_path = r'C:\Users\Noraisa\Downloads\FOR BACKEND (WAG PO DELETE HEHE)\model(notgood)\model.savedmodel'
model = tf.keras.models.load_model(model_path)

# Define the class names for the model's output
class_names = [
    'Not Leafy Vegetables', 'Bacterial Spot', 'Healthy', 'Leaf Scorch', 
    'Leaf Spot', 'Mold', 'Mosaic Virus', 'Powdery Mildew', 'Target Spot'
]

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Get the image file from the request
        file = request.files.get('file')
        if not file:
            return jsonify({'error': 'No file provided'}), 400

        # Open and preprocess the image
        image = Image.open(io.BytesIO(file.read())).convert('RGB')
        image = image.resize((224, 224))  # Resize as per your model's requirement
        image_array = np.array(image) / 255.0  # Normalize the image
        image_array = np.expand_dims(image_array, axis=0)  # Add batch dimension

        # Make prediction
        predictions = model.predict(image_array)
        predicted_index = np.argmax(predictions)
        predicted_class = class_names[predicted_index]
        confidence = predictions[0][predicted_index] * 100

        # Debugging: Print the prediction results to the console
        print(f"Predictions: {predictions}")
        print(f"Predicted Index: {predicted_index}")
        print(f"Predicted Class: {predicted_class}")
        print(f"Confidence: {confidence:.2f}%")

        return jsonify({'class': predicted_class, 'confidence': confidence})
    
    except Exception as e:
        print(f"Error during prediction: {e}")
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)