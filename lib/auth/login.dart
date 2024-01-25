import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String $email = '';
  String $password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (input) {
                const ValueKey('email');
                {
                  return 'Please enter an email';
                }
              },
              onSaved: (input) => $email,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextFormField(
              validator: (input) {
                if (input != $password) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
              onSaved: (input) => $password,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: signIn,
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signIn() async {
    final bool formState = _formKey.currentState?.validate() ?? false;

    if (formState) {
      {
        final formState = _formKey.currentState;
        formState?.save();
        UserCredential user = await _auth.signInWithEmailAndPassword(
            email: $email, 
            password: $password
        );
      }
      Navigator.pushReplacementNamed(context, '../pages/home_page.dart');
    }

    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: $email, password: $password);
      Navigator.pushReplacementNamed(context, '../pages/home_page.dart');
    } catch (e) {
      print(e);
    }
  }
}
