import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'my_scaffold.dart';
import 'login_page.dart';
import 'sign_up_page.dart';
import 'intro_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyCQxsQEG5hgAX-rw-mjBAx8Nq6lgjikymo',
      appId: '1:178197668801:android:5c4590aea2a58cecdb8540',
      messagingSenderId: '178197668801',
      projectId: 'fixit-f252b',
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FIXIT',
      initialRoute: '/',
      routes: {
        '/': (context) => IntroScreen(),
        '/login': (context) => LoginPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomeScreen(),


      },
    );
  }
}


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const MyScaffold(),
    );
  }
}
