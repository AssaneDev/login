import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'signup_page.dart';

FirebaseAuth auth = FirebaseAuth.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  auth.authStateChanges().listen((User? user) {
    if (user == null) {
      print('Utilisateur non connecté');
      runApp(LoginTabBar());
    } else {
      print('Utilisateur connecté: ' + user.email!);
      runApp(const HomePage());
    }
  });
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Page de profil'),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}

class LoginTabBar extends StatelessWidget {
  const LoginTabBar({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.red.shade400),
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            bottom: const TabBar(
              tabs: [Tab(text: 'Connexion'), Tab(text: 'Inscription')],
            ),
            title: const Text('Firebase Login'),
          ),
          body: const TabBarView(
            children: [LoginPage(), SignupPage()],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.amber.shade300,
            Colors.amber.shade700,
            Colors.orange.shade900,
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            flutterIcon,
            titleSection,
            textSection,
            InputSection(),
          ],
        ),
      ),
    );
  }
}

Widget flutterIcon = Container(
  margin: const EdgeInsets.only(top: 20),
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(60),
    color: const Color.fromRGBO(255, 255, 255, 0.1),
  ),
  height: 200,
  width: 200,
  child: Container(
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 5,
          blurRadius: 15,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Image.network('https://img.icons8.com/color/452/firebase.png'),
  ),
);

Widget titleSection = Container(
  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        'Firebase',
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w900,
          color: Colors.white,
        ),
      ),
      const SizedBox(width: 3),
      Text(
        'Login',
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Colors.red.shade400),
      ),
    ],
  ),
);

Widget textSection = Container(
  margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
  child: Text(
    'Page de connexion Firebase',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.red.shade700,
    ),
  ),
);

class InputSection extends StatelessWidget {
  InputSection({Key? key}) : super(key: key);
  final emailField = TextEditingController();
  final passwordField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white30, width: 1),
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromRGBO(255, 255, 255, 0.1),
            ),
            height: 60,
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.people_outline,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 230,
                  child: Center(
                    child: TextField(
                      controller: emailField,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: 'Adresse email',
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white30, width: 1),
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromRGBO(255, 255, 255, 0.1),
            ),
            height: 60,
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.lock_outline,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 230,
                  child: Center(
                    child: TextField(
                      controller: passwordField,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Mot de passe',
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              child: Text(
                "Connexion".toUpperCase(),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                loginToFirebase();
              },
            ),
          ),
        ],
      ),
    );
  }

  void loginToFirebase() {
    try {
      auth.signInWithEmailAndPassword(
        email: emailField.text.trim(),
        password: passwordField.text.trim(),
      );
    } catch (error) {
      print(error.toString());
    }
  }
}
