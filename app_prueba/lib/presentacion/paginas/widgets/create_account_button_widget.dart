import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;
  final VoidCallback onPressed;

  const CreateAccountButton({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.repeatPasswordController,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text(
          'Crear',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
