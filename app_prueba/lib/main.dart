import 'package:flutter/material.dart';
import 'package:app_prueba/presentacion/theme/app_theme.dart';
import 'package:app_prueba/presentacion/paginas/login_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simula una carga asincrónica (por ejemplo, llamada a una API o carga de datos)
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Prueba',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().theme(),
      home: _isLoading
          ? Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/splash.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          : const LoginPage(), // Cambia LoginPage() por la página de inicio de sesión que está en otro archivo
    );
  }
}
