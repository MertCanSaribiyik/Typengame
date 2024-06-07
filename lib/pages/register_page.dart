import 'package:flutter/material.dart';
import 'package:typengame/services/auth/auth_service.dart';
import 'package:typengame/components/my_button.dart';
import 'package:typengame/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final void Function() onPressed;

  RegisterPage({super.key, required this.onPressed});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _register(BuildContext context) async {
    final authService = AuthService();

    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        await authService.signOnWithEmailPassword(
            _emailController.text, _passwordController.text);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password dont`t match !"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Logo :
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: 40.0),

              //Welcome back message :
              Text(
                "Let`s create an account for you",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 16.0,
                ),
              ),

              const SizedBox(height: 25.0),

              //Email textfield :
              MyTextfield(
                controller: _emailController,
                labelText: "Email",
                obscureText: false, //To not hide text. Defaults to false
              ),

              const SizedBox(height: 15.0),

              //Password textfield :
              MyTextfield(
                controller: _passwordController,
                labelText: "Password",
                obscureText: true, //To not hide text.
              ),

              const SizedBox(height: 15.0),

              //Confirm Password textfield :
              MyTextfield(
                controller: _confirmPasswordController,
                labelText: "Confirm Password",
                obscureText: true, //To not hide text.
              ),

              const SizedBox(height: 25.0),

              //Register button :
              MyButton(
                text: "Register",
                onPressed: () => _register(context),
              ),

              const SizedBox(height: 20.0),

              //Register now :
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Already have an account ?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  TextButton(
                    onPressed: onPressed,
                    child: Text(
                      "Login now",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
