import 'package:flutter/material.dart';
import 'package:our_chat/services/auth/auth_service.dart';
import 'package:our_chat/components/my_textfield.dart';
import 'package:our_chat/components/my_button.dart';

class RegisterPage extends StatelessWidget {
  // email and password text controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  // tap to go to login page
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  // register method
  void register(BuildContext context) async {
    final _auth = AuthService();

    if (_pwController.text == _confirmPwController.text) {
      try {
        await _auth.signUpWithEmailAndPassword(
          _emailController.text.trim(),
          _pwController.text.trim(),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Error"),
            content: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (ctx) =>
            const AlertDialog(title: Text("Passwords do not match")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 50),
              Text(
                "Let's create an account for you",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 25),
              MyTextField(
                hintText: 'Email',
                obscureText: false,
                controller: _emailController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: 'Password',
                obscureText: true,
                controller: _pwController,
              ),
              const SizedBox(height: 10),
              MyTextField(
                hintText: 'Confirm Password',
                obscureText: true,
                controller: _confirmPwController,
              ),
              const SizedBox(height: 25),
              MyButton(text: 'Register', onTap: () => register(context)),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Text(
                      "Login Now",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
