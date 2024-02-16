import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyMenu extends StatelessWidget {
  const MyMenu({Key? key, required this.user}) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Menu"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Icon(
              FontAwesomeIcons.user,
              color: Colors.black,
              size: 20,
            ),
            title: Text(
              user != null
                  ? "Logged in as ${user!.email}"
                  : "User not logged in",
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
          ListTile(
            leading: Icon(
              FontAwesomeIcons.envelope,
              color: Colors.blue,
              size: 20,
            ),
            title: Text("Fixit@gmail.com"),
            onTap: () {
              // Action to follow on Facebook
            },
          ),
          Divider(color: Colors.grey),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.fileAlt,
              color: Colors.black,
              size: 20,
            ),
            title: Text("Terms and Conditions"),
            onTap: () {
              _showTermsAndConditionsDialog(context);
            },
          ),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.userShield,
              color: Colors.black,
              size: 20,
            ),
            title: Text("Data Privacy"),
            onTap: () {
              _showDataPrivacyDialog(context);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close', style: TextStyle(color: Theme.of(context).primaryColor)),
        ),
      ],
    );
  }

  void _showTermsAndConditionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool agreed = false; // Track if the user agreed to the terms

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
                          Text(
                              "- Posting or transmitting any content that is defamatory, obscene, or otherwise objectionable."),
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
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: agreed
                      ? null
                      : () async {
                    setState(() {
                      agreed = true;
                    });
                    // Save agreement to shared preferences or other storage mechanism
                    Navigator.of(context).pop();
                  },
                  child: Text('Agree'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDataPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                FontAwesomeIcons.userShield,
                // You can replace this with the desired icon
                color: Theme.of(context).primaryColor, // Example color
              ),
              SizedBox(width: 8),
              Text("Data Privacy"),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your privacy is important to us. This section outlines our practices regarding the collection, use, and disclosure of personal information when you use our services.",
                ),
                SizedBox(height: 10),
                Text(
                  "1. Information Collection: We may collect personal information such as your name, email address, and contact details when you register for an account or use our services.",
                ),
                SizedBox(height: 10),
                Text(
                  "2. Information Use: We use the collected information for various purposes, including providing and improving our services, communicating with you, and personalizing your experience.",
                ),
                SizedBox(height: 10),
                Text(
                  "3. Information Disclosure: We may disclose your personal information to third-party service providers who assist us in operating our services or conducting our business.",
                ),
                SizedBox(height: 10),
                Text(
                  "4. Data Security: We take reasonable measures to protect your personal information from unauthorized access, use, or disclosure.",
                ),
                SizedBox(height: 10),
                Text(
                  "5. Changes to This Privacy Policy: We may update our privacy policy from time to time. We will notify you of any changes by posting the new privacy policy on this page.",
                ),
                SizedBox(height: 10),
                Text(
                  "By using our services, you agree to the collection and use of information in accordance with this policy.",
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
          ],
        );
      },
    );
  }
}

