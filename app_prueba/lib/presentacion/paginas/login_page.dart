import 'package:flutter/material.dart';
import 'package:app_prueba/presentacion/paginas/create_page.dart'; // Importar la página CreatePage
import 'package:app_prueba/presentacion/paginas/home_page.dart'; // Importar la página HomePage
import 'db.dart'; // Importar el DBHelper

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  void _navigateToCreatePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreatePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

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
              _buildEmailTextField(_emailController),
              const SizedBox(height: 10),
              _buildPasswordTextField(_passwordController),
              const SizedBox(height: 20),
              _buildLoginButton(context, _emailController, _passwordController),
              const SizedBox(height: 10),
              _buildCreateAccountButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context, TextEditingController emailController, TextEditingController passwordController) {
    return SizedBox(
      width: 300,
      height: 48,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFF79935),
              Color(0xFFF84A18),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: TextButton(
          onPressed: () async {
            String email = emailController.text;
            String password = passwordController.text;

            // Verificar el inicio de sesión con la base de datos
            bool isLoggedIn = await DBHelper().checkLogin(email, password);

            if (isLoggedIn) {
              // Inicio de sesión exitoso, redirigir a la página HomePage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            } else {
              // Credenciales incorrectas, mostrar mensaje de error
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text('Usuario o contraseña incorrectos.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: const Text(
            'Ingresar',
            style: TextStyle(
              color: Colors.white,
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

  Widget _buildEmailTextField(TextEditingController controller) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: const Color(0xFF44372D),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF44372D)),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Correo electrónico',
          hintStyle: const TextStyle(color: Color(0xFFA29B96)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField(TextEditingController controller) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: const Color(0xFF44372D),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF44372D)),
      ),
      child: TextField(
        controller: controller,
        obscureText: true,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Contraseña',
          hintStyle: const TextStyle(color: Color(0xFFA29B96)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
