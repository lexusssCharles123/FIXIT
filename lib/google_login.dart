import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginScreen extends StatelessWidget {
  Future<void> _loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        print('Google login successful!');
        print('User ID: ${googleUser.id}');
        print('Display Name: ${googleUser.displayName}');
        print('Email: ${googleUser.email}');
      } else {
        print('Google login canceled.');
      }
    } catch (e) {
      print('Error during Google login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _loginWithGoogle,
          child: Text('Login with Google'),
        ),
      ),
    );
  }
}
