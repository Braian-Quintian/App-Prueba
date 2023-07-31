import 'package:flutter/material.dart';
import 'package:app_prueba/presentacion/paginas/create_page.dart'; // Importar la página CreatePage

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  void _navigateToCreatePage(BuildContext context) {
    Navigator.push(
      context,
      // ignore: prefer_const_constructors
      MaterialPageRoute(builder: (context) => CreatePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_image.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 50),
              _buildEmailTextField(),
              const SizedBox(height: 10),
              _buildPasswordTextField(),
              const SizedBox(height: 20),
              _buildLoginButton(),
              const SizedBox(height: 10),
              _buildCreateAccountButton(context), // Pasar el contexto aquí
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: 300, // Ancho del botón "Ingresar"
      height: 48, // Altura del botón "Ingresar"
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFF79935), // Color del botón (lado derecho del degradado)
              Color(0xFFF84A18), // Color del botón (lado izquierdo del degradado)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: TextButton(
          onPressed: () {
            // Aquí puedes agregar la lógica para procesar el inicio de sesión
          },
          child: const Text(
            'Ingresar',
            style: TextStyle(
              color: Colors.white, // Color del texto del botón "Ingresar" (blanco)
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return Container(
      width: 300,
      height: 48,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(0, 162, 155, 150),
        border: Border.all(color: const Color(0xFFE2B190)),
      ),
      child: TextButton(
        onPressed: () {
          _navigateToCreatePage(context);
        },
        child: const Text(
          'Crear cuenta',
          style: TextStyle(
            color: Color(0xFFE2B190),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Container(
      width: 300, // Ancho del campo de correo electrónico
      decoration: BoxDecoration(
        color: const Color(0xFF44372D), // Color del cuadro de correo electrónico
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF44372D)), // Color del borde del cuadro
      ),
      child: const TextField(
        style: TextStyle(color: Colors.white), // Color del texto del campo de correo electrónico
        decoration: InputDecoration(
          hintText: 'Correo electrónico',
          hintStyle: TextStyle(color: Color(0xFFA29B96)), // Color del texto "Correo electrónico"
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Container(
      width: 300, // Ancho del campo de contraseña
      decoration: BoxDecoration(
        color: const Color(0xFF44372D), // Color del cuadro de contraseña
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF44372D)), // Color del borde del cuadro
      ),
      child: const TextField(
        obscureText: true,
        style: TextStyle(color: Colors.white), // Color del texto del campo de contraseña
        decoration: InputDecoration(
          hintText: 'Contraseña',
          hintStyle: TextStyle(color: Color(0xFFA29B96)), // Color del texto "Contraseña"
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
