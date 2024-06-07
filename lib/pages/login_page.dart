import 'package:flutter/material.dart';
import 'package:typengame/services/auth/auth_service.dart';
import 'package:typengame/components/my_button.dart';
import 'package:typengame/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  final void Function() onPressed;

  LoginPage({super.key, required this.onPressed});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
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
                  "Welcome back, you`ve been missed !",
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

                const SizedBox(height: 25.0),

                //Login button :
                MyButton(
                  text: "Login",
                  onPressed: () => _login(context),
                ),

                const SizedBox(height: 20.0),

                //Register now :
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Not a member ?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    TextButton(
                      onPressed: onPressed,
                      child: Text(
                        "Register now",
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
      ),
    );
  }
}
