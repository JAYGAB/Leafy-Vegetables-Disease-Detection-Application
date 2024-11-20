AgriSmart: Leafy Vegetable Disease Detection App 🌱

AgriSmart is an innovative mobile application designed to detect diseases in leafy vegetables using image recognition. The app integrates cutting-edge machine learning technologies and user-friendly design to assist farmers and agricultural enthusiasts in identifying plant diseases and improving crop health.

Features
Disease Detection: Capture or upload images of leafy vegetables to detect diseases with a trained model.
Teachable Machine Integration: The machine learning model is built using Google's Teachable Machine and trained with the PlantVillage dataset for high accuracy.
Flask Backend: A Flask server is used to serve the model through REST APIs, making the predictions accessible.
API Connectivity: The app connects to the backend using an API key, with public access enabled through ngrok.
Firebase Integration: Secure user authentication and real-time database management powered by Firebase.
Modern UI: Built with Flutter, the app provides a smooth and aesthetically pleasing user experience.

Tech Stack
Frontend: Flutter (Virtual Studio Code as IDE)
Backend: Flask, TensorFlow, Teachable Machine
Database: Firebase
Model Training Dataset: PlantVillage Dataset
Deployment: ngrok for public API access

How It Works
Image Upload: Users can upload or capture an image of a leafy vegetable through the app.
Model Prediction: The image is sent to the Flask backend, where it is processed using the trained Teachable Machine model.
Disease Results: The app displays the disease detected along with a confidence score and potential solutions.
User Management: Firebase handles user authentication and database functionality.

Requirements:
Flutter SDK
Python (for Flask and TensorFlow)
Virtual Studio Code
ngrok
Firebase configuration


Future Enhancements
Add multilingual support.
Improve model accuracy with additional training data.
Include a community section for user discussions and tips.
License
This project is licensed under the MIT License.

Full project in Gdrive link:
https://drive.google.com/drive/folders/1EXuMA71j8A9xcseAZnaJz9ptLzC7tqGM?usp=sharing

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
