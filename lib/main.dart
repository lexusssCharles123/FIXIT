import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyAppWithIntro());
}

class MyAppWithIntro extends StatelessWidget {
  const MyAppWithIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatelessWidget {
  final List<String> introSlideImages = [
    'assets/12.png',
    'assets/15.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue, // Set your desired background color
        child: PageView.builder(
          itemCount: introSlideImages.length + 1,
          itemBuilder: (context, index) {
            if (index < introSlideImages.length) {
              return Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.asset(
                        introSlideImages[index],
                        fit: BoxFit.contain,
                      ),
                    ),
                    if (index == 1) // Display text only on the second image
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center, // Center text vertically
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              'Repair anything in a click!!',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              );
            } else if (index == introSlideImages.length) {
              // Additional code for the last slide
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp()),
                  );
                },
                child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              // You can add more conditions for other slides if needed
              return Container();
            }
          },
        ),
      ),
    );
  }
}




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: const MyScaffold(),
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  const MyScaffold({Key? key}) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue, // Set the background color
        title: Image.asset(
          'assets/12.png',
          height: 40,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                'Do you need help?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const MyImageRow(['assets/3.jpg', 'Plumbing service'], ['assets/4.jpg', 'Gadget Repair']),
              const SizedBox(height: 20),
              const MyImageRow(['assets/5.jpg', 'Painting Services'], ['assets/c.jpg', 'Electrical Work']),
              const SizedBox(height: 20),
              const MyImageRow(['assets/7.jpeg', 'Furniture Assembly'], ['assets/8.jpeg', 'Home Cleaning']),
            ],
          ),
        ),
      ),
    );
  }
}


class MyImageRow extends StatelessWidget {
  final List<String> firstImage;
  final List<String> secondImage;

  const MyImageRow(this.firstImage, this.secondImage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyImageBox(context, firstImage[0], firstImage[1]),
        const SizedBox(width: 20),
        MyImageBox(context, secondImage[0], secondImage[1]),
      ],
    );
  }
}

class MyImageBox extends StatelessWidget {
  final BuildContext context;
  final String assetPath;
  final String title;

  const MyImageBox(this.context, this.assetPath, this.title, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showContractForm(context, title);
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    assetPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _showContractForm(BuildContext context, String title) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery
                .of(context)
                .viewInsets
                .bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sign Contract for $title',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Add form fields for name, contract, and remarks
              ContractForm(),
            ],
          ),
        );
      },
    );
  }
}

class ContractForm extends StatefulWidget {
  const ContractForm({Key? key}) : super(key: key);

  @override
  _ContractFormState createState() => _ContractFormState();
}

class _ContractFormState extends State<ContractForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contractController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(labelText: 'Name'),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: contractController,
          decoration: InputDecoration(labelText: 'Contract'),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: remarksController,
          decoration: InputDecoration(labelText: 'Remarks'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Handle form submission here
            _submitForm(context, nameController.text, contractController.text,
                remarksController.text);
          },
          child: Text('Submit'),
        ),
      ],
    );
  }

  void _submitForm(BuildContext context, String name, String contract,
      String remarks) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.254.148:3000/submitForm'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'contract': contract,
          'remarks': remarks,
        }),
      );

      if (response.statusCode == 200) {
        // Data inserted successfully
        Navigator.pop(context); // Close the bottom sheet

        // Show success dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Your Request submitted successfully!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Handle server error
        print('Server error: ${response.body}');

        // Show error dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to submit data. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      // Handle network error
      print('Network error: $error');

      // Show error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Network error. Please check your connection.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}