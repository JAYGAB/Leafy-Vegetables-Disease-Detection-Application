import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:smartappli/FeedbackPage.dart';
import 'dart:io';
import 'dart:convert';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'login_page.dart';
import 'disease_description_page.dart';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  File? _image;
  String _diseaseName = '';
  String _confidencePercentage = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showInfoDialog();
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _uploadImage(_image!);
    }
  }

  Future<void> _captureImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _uploadImage(_image!);
    }
  }

Future<void> _uploadImage(File image) async {
  final uri = Uri.parse('https://66fc-136-158-46-91.ngrok-free.app/predict'); 
  final request = http.MultipartRequest('POST', uri)
    ..files.add(await http.MultipartFile.fromPath('file', image.path));

  setState(() {
    _isLoading = true; 
  });

  try {
    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    
    await Future.delayed(Duration(seconds: 1)); 

    if (response.statusCode == 200) {
      final responseJson = json.decode(responseBody);

      setState(() {
        _diseaseName = responseJson['class'] ?? 'Unknown';
        _confidencePercentage = responseJson['confidence'] != null
            ? responseJson['confidence'].toStringAsFixed(2) + '%'
            : 'Unknown';
      });
    } else {
      setState(() {
        _diseaseName = 'Failed to get result';
        _confidencePercentage = 'Status code: ${response.statusCode}';
      });
    }
  } catch (e) {
    setState(() {
      _diseaseName = 'Error uploading image: ${e.toString()}';
      _confidencePercentage = '';
    });
    print("Error uploading image: $e"); 
  } finally {
    setState(() {
      _isLoading = false; 
    });
  }
}

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut(); 
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _navigateToDescriptionPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              DiseaseDescriptionPage(diseaseName: _diseaseName)),
    );
  }

  void _navigateToFeedbackPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FeedbackPage()),
    );
  }

void _showInfoDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 38, 83, 40),
        contentPadding: EdgeInsets.only(top: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Instruction',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ],
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'For the best results in detecting diseases in leafy vegetables, please follow these guidelines when taking or uploading an image:\n\n'
                '1. Upload a Clear Image\n'
                '2. Focus on the Leaf\n'
                '3. Ensure Good Lighting\n\n'
                'Following these instructions will improve the application\'s ability to accurately detect diseases in leafy vegetables. Thank you!',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20), 
            ],
          ),
        ),
      );
    },
  );
}

@override
Widget build(BuildContext context) {
  User? user = FirebaseAuth.instance.currentUser;

  return Scaffold(
    extendBodyBehindAppBar: true,
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(100.0),
      child: ClipPath(
        clipper: CustomAppBarClipper(),
        child: AppBar(
          title: Text('AgriSmart', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 38, 83, 40),
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
      ),
    ),
    body: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/background_image.jpg',
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.1), 
                Colors.black.withOpacity(0.1)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Upload or Capture an Image',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 20),
                _image == null
                    ? Text(
                        'No image selected.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 38, 83, 40)
                                  .withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 350,
                          ),
                        ),
                      ),
                SizedBox(height: 20),
                
                if (_isLoading) 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      SizedBox(width: 10), 
                      Text(
                        'Predicting...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                else ...[
                  Text(
                    'Disease Name: $_diseaseName',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Confidence: $_confidencePercentage',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 38, 83, 40),
                image: DecorationImage(
                  image: AssetImage('assets/background_image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 16.0,
                    left: 16.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to AgriSmart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        if (user != null && user.email != null)
                          Text(
                            '(${user.email})',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.feedback,
                  color: const Color.fromARGB(255, 38, 83, 40)),
              title: Text('Feedback',
                  style: TextStyle(color: const Color.fromARGB(255, 38, 83, 40))),
              onTap: _navigateToFeedbackPage,
            ),
            ListTile(
              leading: Icon(Icons.logout,
                  color: const Color.fromARGB(255, 38, 83, 40)),
              title: Text('Logout',
                  style: TextStyle(color: const Color.fromARGB(255, 38, 83, 40))),
              onTap: _logout,
            ),
          ],
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: const Color.fromARGB(255, 38, 83, 40),
        color: Colors.white,
        activeColor: Colors.white,
        style: TabStyle.reactCircle,
        items: [
          TabItem(icon: Icons.photo_library, title: 'Gallery'),
          TabItem(icon: Icons.camera_alt, title: 'Camera'),
          TabItem(icon: Icons.description, title: 'Description'),
          TabItem(icon: Icons.info, title: 'Instruction'),
        ],
        initialActiveIndex: 0,
        onTap: (int i) {
          switch (i) {
            case 0:
              _pickImage();
              break;
            case 1:
              _captureImage();
              break;
            case 2:
              _navigateToDescriptionPage();
              break;
            case 3:
              _showInfoDialog();
              break;
          }
        },
      ),
    );
  }
}


class CustomAppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}