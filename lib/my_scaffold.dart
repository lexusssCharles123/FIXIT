import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'my_image_row.dart';
import 'login_page.dart'; // Import your login page here
import 'chat_bot_page.dart'; // Import your chat bot page here

class MyScaffold extends StatelessWidget {
  const MyScaffold({Key? key}) : super(key: key);

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
        await showDialog(
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
        // Return false to prevent back navigation if the dialog was shown
        return false;
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
                Navigator.of(context).pop();
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
                // Show a menu for the user
                FirebaseAuth auth = FirebaseAuth.instance;
                User? user = auth.currentUser;
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Menu"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(
                              user != null ? "User Email: ${user.email}" : "User not logged in",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(color: Colors.grey),
                          ListTile(
                            leading: Icon(
                              FontAwesomeIcons.facebook,
                              color: Colors.blue,
                              size: 20,
                            ),
                            title: Text("Follow us on Facebook"),
                            onTap: () {
                              // Action to follow on Facebook
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              FontAwesomeIcons.tiktok,
                              color: Colors.black,
                              size: 20,
                            ),
                            title: Text("Follow us on TikTok"),
                            onTap: () {
                              // Action to follow on TikTok
                            },
                          ),
                          Divider(color: Colors.grey),
                          ListTile(
                            title: Text("Forgot Password"),
                            onTap: () {
                              // Action to navigate to forgot password screen
                            },
                          ),
                          ListTile(
                            title: Text(
                              "Logout",
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage())); // Navigate to login page
                            },
                          ),
                          ListTile(
                            title: Text(
                              "Close",
                              style: TextStyle(color: Theme.of(context).primaryColor),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
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
              Text(
                'House Repair/Services',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              MyImageRow(
                firstImage: ['assets/3.jpg', 'Plumbing Service'],
                secondImage: ['assets/5.jpg', 'Painting Services'],
                thirdImage: ['assets/carrepair1.jpg', 'Car Repair'],
                textFontSize: 10,
              ),
              const SizedBox(height: 20),
              MyImageRow(
                firstImage: ['assets/c.jpg', 'Electrical Work'],
                secondImage: ['assets/appliance.jpg', 'Appliance Fix'],
                thirdImage: ['assets/4.jpg', 'Gadget Repair'],
                textFontSize: 10,
              ),
              const SizedBox(height: 20),
              MyImageRow(
                firstImage: ['assets/7.jpeg', 'Furniture Repair'],
                secondImage: ['assets/nn.jpg', 'Welding Services'],
                thirdImage: ['assets/kk.jpg', 'Kasambahay'],
                textFontSize: 10,
              ),
              const SizedBox(height: 20),
              Text(
                'Personal Services',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              MyImageRow(
                firstImage: ['assets/hh.jpg', 'Haircut Services'],
                secondImage: ['assets/mm.jpg', 'Massage Therapy'],
                thirdImage: ['assets/8.jpeg', 'Home Cleaning'],
                textFontSize: 10,
              ),
              const SizedBox(height: 20),
              MyImageRow(
                firstImage: ['assets/den.jpg', 'Dental Services'],
                secondImage: ['assets/dd.jpg', 'Driving Services'],
                thirdImage: ['assets/ma.jpg', 'Makeup Artist'],
                textFontSize: 10,
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
