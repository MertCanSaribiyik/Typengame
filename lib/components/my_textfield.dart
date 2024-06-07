import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  bool obscureText;
  final FocusNode? focusNode;

  MyTextfield({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
    this.focusNode,
  });

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  void _changeVisibilty() {
    setState(() {
      widget.obscureText = !widget.obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText,
      focusNode: widget.focusNode,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        suffixIcon: widget.labelText.contains("Password")
            ? IconButton(
                onPressed: _changeVisibilty,
                icon: Icon(
                  widget.obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                color: Theme.of(context).colorScheme.inversePrimary,
              )
            : null,
      ),
    );
  }
}
