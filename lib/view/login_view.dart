import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simple_notes/firebase_options.dart';

class LogInView extends StatefulWidget {
  const LogInView({super.key});

  @override
  State<LogInView> createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LogIniew")),
      body: Column(
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: "Enter Email Here"),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(hintText: "Enter Password Here"),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredentails = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(email: email, password: password);
                print(userCredentails);
              } on FirebaseAuthException catch (e) {
                if (e.code == "invalid-credential") {
                  print("user not foubd");
                }
              } catch (e) {
                print("Something Bad Happened");
                print(e);
              }
            },
            child: const Text("Login"),
          ),
      
          TextButton(onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil('/register/', (route) => false);
          }, child: const Text("Move To Register View"))
        ],
      ),
    );
  }
}
