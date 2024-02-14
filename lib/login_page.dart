import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'sign_up_page.dart';
import 'form_container_widget.dart';
import 'toast.dart';
import 'firebase_auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isSigning = false;
  final FirebaseAuthService _auth = FirebaseAuthService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery
                  .of(context)
                  .size
                  .width * 0.1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/12.png',
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * 0.4,
                ),
                SizedBox(height: 30),
                FormContainerWidget(
                  controller: _emailController,
                  hintText: "Email",
                  isPasswordField: false,
                ),
                SizedBox(height: 10),
                FormContainerWidget(
                  controller: _passwordController,
                  hintText: "Password",
                  isPasswordField: true,
                ),
                SizedBox(height: 30),
                _buildLoginButton("Login", Colors.blue, _signIn),
                _buildSignUpLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildLoginButton(String label, Color color, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: _isSigning
              ? CircularProgressIndicator(color: Colors.white)
              : Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButtonWithIcon(String label, Color color, IconData icon,
      VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(width: 5),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account?"),
        SizedBox(width: 5),
        GestureDetector(
          onTap: () =>
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
                    (route) => false,
              ),
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      User? user = await _auth.signInWithEmailAndPassword(email, password);

      setState(() {
        _isSigning = false;
      });

      if (user != null) {
        showToast(message: "User is successfully signed in");
        Navigator.pushNamed(context, "/home");
      } else {
        showToast(message: "Invalid email or password");
      }
    } catch (e) {
      setState(() {
        _isSigning = false;
      });
      showToast(message: "Error: $e");
    }
   }
  }

