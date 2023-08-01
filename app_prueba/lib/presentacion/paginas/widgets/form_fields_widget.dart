import 'package:flutter/material.dart';

class MyFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;

  const MyFormFields({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.repeatPasswordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTextField('Nombre', 'Nombre', nameController),
        const SizedBox(height: 20),
        _buildTextField('Correo Electrónico', 'Correo electrónico', emailController, isPassword: false),
        const SizedBox(height: 20),
        _buildTextField('Contraseña', 'Contraseña', passwordController, isPassword: true),
        const SizedBox(height: 20),
        _buildTextField('Repetir Contraseña', 'Repetir contraseña', repeatPasswordController, isPassword: true),
      ],
    );
  }

  Widget _buildTextField(String labelText, String hintText, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Color(0xFF44546F)),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF44546F),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xFFA29B96)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
