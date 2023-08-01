import 'dart:io';
import 'package:flutter/material.dart';
import 'db.dart';
import 'image_picker_service.dart';
import 'widgets/app_bar_widget.dart';
import 'widgets/form_fields_widget.dart';
import 'widgets/create_account_button_widget.dart';
import 'widgets/gif_view_widget.dart';

class CreatePage extends StatelessWidget {
  final ImagePickerService _imagePickerService = ImagePickerService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();

  void _handleTap(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  Future<void> _pickImageFromGallery() async {
    final imagePath = await _imagePickerService.pickImageFromGallery();
    if (imagePath != null) {
      _imagePath = imagePath;
    }
  }

  Future<void> _createAccount(BuildContext context) async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final repeatPassword = _repeatPasswordController.text;

    if (password != repeatPassword) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Las contraseñas no coinciden.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Aquí puedes crear un mapa con la información del usuario
    final user = {
      'name': name,
      'email': email,
      'password': password,
      'repeat_password': repeatPassword,
    };

    // Llamamos a la función para insertar el usuario en la base de datos
    final insertedRowId = await DBHelper().insertUser(user);

    // Si el usuario fue registrado con éxito, mostramos un mensaje al usuario
    if (insertedRowId != -1) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Usuario registrado'),
            content: Text(
                'El usuario ha sido registrado con éxito con el ID: $insertedRowId'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _navigateToGifView(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // En caso de que no se haya podido insertar el usuario, mostramos un mensaje de error
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Ha ocurrido un error al registrar el usuario.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Prueba',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: MyAppBar(),
        body: GestureDetector(
          onTap: () => _handleTap(context),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Crear Cuenta',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _pickImageFromGallery,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: const Color(0xFFEEF2F5),
                      alignment: Alignment.center,
                      child: _imagePath != null
                          ? Image.file(File(_imagePath!))
                          : const Text(
                              'Subir Foto',
                              style: TextStyle(
                                color: Color(0xFF44546F),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyFormFields(
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    repeatPasswordController: _repeatPasswordController,
                  ),
                  const SizedBox(height: 20),
                  CreateAccountButton(
                    onPressed: () => _createAccount(context),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToGifView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const GifView(),
      ),
    );
  }
}
