import 'package:flutter/material.dart';

class CustomSimpleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const CustomSimpleButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(MediaQuery.of(context).size.width, 50),
      ),
      child: child,
    );
  }
}
