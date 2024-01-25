import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String $email = '';
  String $password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
              decoration: const InputDecoration(
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
              onPressed: signUp,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUp() async {
    final formState = _formKey.currentState?.validate() ?? false;
    if (formState) {
      final formState = _formKey.currentState;
      formState?.save();
      try {
        UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: $email,
          password: $password,
        );
        // Navigasi ke halaman berikutnya setelah register berhasil
        Navigator.pushReplacementNamed(context, './login.dart');
      } catch (e) {
        print(e);
      }
    }
  }
}
