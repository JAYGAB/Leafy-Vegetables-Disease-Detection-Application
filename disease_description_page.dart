import 'package:flutter/material.dart';

class DiseaseDescriptionPage extends StatelessWidget {
  final String diseaseName;

  DiseaseDescriptionPage({required this.diseaseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/DecPage_bg.jpg'), 
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              PreferredSize(
                preferredSize: Size.fromHeight(80.0),
                child: AppBar(
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [const Color.fromARGB(255, 255, 255, 255), const Color.fromARGB(255, 255, 255, 255)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      diseaseName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  elevation: 0,
                  backgroundColor: const Color(0x00000000), // Make the AppBar transparent
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Description:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                      Text(
                        _getDiseaseDescription(diseaseName),
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 250, 250, 250),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Causes:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 246, 246, 246),
                          ),
                        ),
                      ),
                      Text(
                        _getDiseaseCauses(diseaseName),
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          'Treatment:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                      Text(
                        _getDiseaseTreatment(diseaseName),
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
String _getDiseaseDescription(String diseaseName) {
switch (diseaseName.toLowerCase()) {
case 'not leafy vegetables':
return 'Not Leafy Vegetables is not a disease, but rather a category of plants.';
case 'bacterial spot':
return 'Bacterial spot is a plant disease caused by bacteria that affects the leaves of plants, causing small, water-soaked spots that eventually turn brown and necrotic.';
case 'healthy':
return 'This term refers to the absence of any disease symptoms in plants.';
case 'leaf scorch':
return 'Leaf scorch is a condition characterized by yellowing or browning of leaves due to environmental stress, such as high temperatures, drought, or exposure to extreme light.';
case 'leaf spot':
return 'Leaf spot refers to a variety of fungal and bacterial infections that cause discolored lesions or spots on the leaves of affected plants.';
case 'mold':
return 'Mold is a fungal disease that can affect a wide range of plants, including vegetables, ornamentals, and even trees.';
case 'mosaic virus':
return 'Mosaic virus is characterized by leaves mottled with yellow, white, and light or dark green spots and streaks, forming a mosaic of colors.';
case 'powdery mildew':
return 'Powdery mildew is a fungal disease that covers leaves with a white, powdery coating, often accompanied by distorted or stunted growth.';
case 'target spot':
return 'Target spot refers to a variety of fungal and bacterial infections that cause discolored lesions or spots on the leaves of affected plants.';
default:
return 'No description available.';
}
}

String _getDiseaseCauses(String diseaseName) {
switch (diseaseName.toLowerCase()) {
case 'not leafy vegetables':
return 'N/A';
case 'bacterial spot':
return 'Caused by bacterial pathogens, such as Xanthomonas campestris or Pseudomonas syringae, which infect the leaves of plants.';
case 'healthy':
return 'Proper care, good nutrition, and disease prevention practices contribute to plant health.';
case 'leaf scorch':
return 'Environmental stress, high temperatures, drought, or exposure to extreme light.';
case 'leaf spot':
return 'Primarily caused by pathogenic fungi, though some are caused by bacteria.';
case 'mold':
return 'Excessive moisture, poor air circulation, and overcrowding of plants.';
case 'mosaic virus':
return 'Spread by aphids and other insects, mites, fungi, nematodes, and contact; pollen and seeds can carry the infection as well.';
case 'powdery mildew':
return 'Caused by fungal pathogens, often favored by high humidity and moderate temperatures.';
case 'target spot':
return 'Primarily caused by pathogenic fungi, though some are caused by bacteria.';
default:
return 'No causes available.';
}
}

String _getDiseaseTreatment(String diseaseName) {
switch (diseaseName.toLowerCase()) {
case 'not leafy vegetables':
return 'N/A';
case 'bacterial spot':
return 'Provide good air circulation, avoid overhead watering, and practice crop rotation.';
case 'healthy':
return 'Maintain optimal growing conditions and promptly address any issues.';
case 'leaf scorch':
return 'Water plants regularly, provide shade, and avoid exposure to extreme temperatures.';
case 'leaf spot':
return 'Proper spacing, watering, sanitation, and crop rotation.';
case 'mold':
return 'Proper site selection, adequate spacing between plants, appropriate watering practices, and removing and disposing of infected plant parts.';
case 'mosaic virus':
return 'There is no cure for mosaic viruses. Prevention is key. Remove and destroy infected plants and avoid composting them.';
case 'powdery mildew':
return 'Remove infected leaves, improve air circulation, and apply fungicides if necessary.';
case 'target spot':
return 'Proper spacing, watering, sanitation, and crop rotation.';
default:
return 'No treatment available.';
}
}
}