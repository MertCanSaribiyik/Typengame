import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const MyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      color: Theme.of(context).colorScheme.secondary,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18.0,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
