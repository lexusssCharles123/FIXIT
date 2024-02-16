import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'my_image_row.dart';
import 'chat_bot_page.dart'; // Import your chat bot page here
import 'menu.dart'; // Import your menu here
import 'package:shared_preferences/shared_preferences.dart';

class MyScaffold extends StatefulWidget {
  const MyScaffold({Key? key}) : super(key: key);

  @override
  _MyScaffoldState createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  bool agreed = false; // Initialize the agreed variable

  @override
  void initState() {
    super.initState();
    // Show terms and conditions when the app is opened
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      showTermsAndConditions();
    });
  }

  Future<void> showTermsAndConditions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool agreed = prefs.getBool('agreed_terms') ?? false;

    if (!agreed) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text("Terms and Conditions"),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Please read these terms and conditions carefully before using our app. By using the app, you agree to be bound by these terms and conditions. If you do not agree to abide by these terms and conditions, please do not use the app.",
                      ),
                      SizedBox(height: 10),
                      Text(
                        "1. Use of the App: You must be at least 18 years old to use this app. By using this app, you represent that you are at least 18 years old and have the legal capacity to enter into this agreement.",
                      ),
                      SizedBox(height: 10),
                      Text(
                        "2. Account Registration: You may be required to create an account to access certain features of the app. You agree to provide accurate and complete information during the registration process.",
                      ),
                      SizedBox(height: 10),
                      Text(
                        "3. User Content: You are solely responsible for any content you post or upload to the app. By posting content, you grant us a worldwide, non-exclusive, royalty-free license to use, reproduce, modify, adapt, publish, translate, distribute, and display such content.",
                      ),
                      SizedBox(height: 10),
                      Text(
                        "4. Prohibited Conduct: You agree not to engage in any conduct that violates these terms and conditions or infringes upon the rights of others. Prohibited conduct includes, but is not limited to, the following:",
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("- Using the app for any unlawful purpose."),
                            Text("- Impersonating any person or entity."),
                            Text("- Posting or transmitting any content that is defamatory, obscene, or otherwise objectionable."),
                            Text("- Interfering with the operation of the app."),
                            Text("- Uploading viruses or other malicious code."),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "5. Modification of Terms: We reserve the right to modify these terms and conditions at any time without prior notice. Your continued use of the app after any such changes constitutes your acceptance of the new terms and conditions.",
                      ),
                      SizedBox(height: 10),
                      Text(
                        "If you have any questions about these terms and conditions, please contact us.",
                      ),
                      SizedBox(height: 10),
                      CheckboxListTile(
                        title: Text("I Agree"),
                        value: agreed,
                        onChanged: (value) {
                          setState(() {
                            agreed = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                  TextButton(
                    onPressed: agreed
                        ? () async {
                      setState(() {
                        agreed = true;
                      });
                      await prefs.setBool('agreed_terms', true);
                      Navigator.of(context).pop();
                    }
                        : null, // Disable the button if agreed is false
                    child: Text('Agree'),
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }

  Future<bool> _onWillPop(BuildContext context) async {
    // Show dialog only when using back arrow button
    final shouldExit = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit the app?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    );
    return shouldExit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return WillPopScope(
      onWillPop: () async {
        // Handle system back button press
        final shouldExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        );
        // Return true to exit the app if the dialog was shown and "Yes" was pressed
        return shouldExit ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 2.0,
          backgroundColor: Colors.white,
          title: Image.asset(
            'assets/12.png',
            height: 40,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.black,
            ),
            onPressed: () async {
              // Handle back arrow button press
              final shouldExit = await _onWillPop(context);
              if (shouldExit) {
                SystemNavigator.pop(); // Exit the app
              }
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                FontAwesomeIcons.user,
                size: 24,
              ),
              onPressed: () {
                // Show the menu
                FirebaseAuth auth = FirebaseAuth.instance;
                User? user = auth.currentUser;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MyMenu(user: user);
                  },
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              Text(
                'Do you need help?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 3,
                color: Colors.grey[100], // Dark background color
                child: InkWell(
                  onTap: () {
                    // Handle card tap for House Repair/Services
                    print('House Repair/Services tapped');
                  },
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'House Repair/Services',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87), // White text color
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        elevation: 3,
                        color: Colors.grey[300], // Dark background color
                        child: MyImageRow(
                          firstImage: ['assets/3.jpg', 'Plumbing Service'],
                          secondImage: ['assets/5.jpg', 'Painting Services'],
                          thirdImage: ['assets/carrepair1.jpg', 'Car Repair'],
                          textFontSize: 10,
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        elevation: 3,
                        color: Colors.grey[300], // Dark background color
                        child: MyImageRow(
                          firstImage: ['assets/c.jpg', 'Electrical Work'],
                          secondImage: ['assets/appliance.jpg', 'Appliance Fix'],
                          thirdImage: ['assets/4.jpg', 'Gadget Repair'],
                          textFontSize: 10,
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        elevation: 3,
                        color: Colors.grey[300], // Dark background color
                        child: MyImageRow(
                          firstImage: ['assets/7.jpeg', 'Furniture Repair'],
                          secondImage: ['assets/nn.jpg', 'Welding Services'],
                          thirdImage: ['assets/kk.jpg', 'Kasambahay'],
                          textFontSize: 10,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 3,
                color: Colors.grey[100], // Dark background color
                child: InkWell(
                  onTap: () {
                    // Handle card tap for Personal Services
                    print('Personal Services tapped');
                  },
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          'Personal Services',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87), // White text color
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        elevation: 3,
                        color: Colors.grey[300], // Dark background color
                        child: MyImageRow(
                          firstImage: ['assets/hh.jpg', 'Haircut Services'],
                          secondImage: ['assets/mm.jpg', 'Massage Therapy'],
                          thirdImage: ['assets/8.jpeg', 'Home Cleaning'],
                          textFontSize: 10,
                        ),
                      ),
                      SizedBox(height: 10),
                      Card(
                        elevation: 3,
                        color: Colors.grey[300], // Dark background color
                        child: MyImageRow(
                          firstImage: ['assets/den.jpg', 'Dental Services'],
                          secondImage: ['assets/dd.jpg', 'Driving Services'],
                          thirdImage: ['assets/ma.jpg', 'Makeup Artist'],
                          textFontSize: 10,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),


        bottomNavigationBar: Container(
          height: 40, // set your custom height here
          color: Colors.white, // set the color of the BottomAppBar
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.home,
                  size: 24,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.message,
                  size: 24,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChatBotPage())); // Navigate to the chat bot page
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
