import 'dart:io';
import 'package:app_prueba/presentacion/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'db.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  String? _imagePath;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Prueba',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().theme(),
      home: Scaffold(
        appBar: const MyAppBar(),
        body: GestureDetector(
          onTap: _handleTap, // Cuando se toque fuera del teclado
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Align(
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
                    onTap: () => _pickImageFromGallery(),
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
                    nameController: _nameController,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    repeatPasswordController: _repeatPasswordController,
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

  void _handleTap() {
    // Desenfocar el campo de texto actualmente enfocado
    FocusScope.of(context).unfocus();
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        // Actualiza la ruta de la imagen seleccionada
        _imagePath = pickedFile.path;
      });
    }
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: const Color(0xFFFF991F), // Color del ícono de retroceso
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

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
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF44546F),
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Añadir el border-radius aquí
            borderSide: const BorderSide(color: Color(0xFF44546F), width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Añadir el border-radius aquí
            borderSide: const BorderSide(color: Color(0xFF44546F), width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), // Añadir el border-radius aquí
            borderSide: const BorderSide(color: Color(0xFF44546F), width: 1.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}

class CreateAccountButton extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController repeatPasswordController;

  const CreateAccountButton({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.repeatPasswordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 48,
      child: ElevatedButton(
        onPressed: () async {
          final name = nameController.text;
          final email = emailController.text;
          final password = passwordController.text;
          final repeatPassword = repeatPasswordController.text;

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
          Map<String, dynamic> user = {
            'name': name,
            'email': email,
            'password': password,
            'repeat_password': repeatPassword,
          };

          // Llamamos al método para insertar el usuario en la base de datos
          int insertedRowId = await DBHelper().insertUser(user);

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
                  content: const Text(
                      'Ha ocurrido un error al registrar el usuario.'),
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
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: 0,
          primary: Colors.transparent, // Hacemos el fondo transparente
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFF79935),
                Color(0xFFF84A18),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 88.0,
              minHeight: 36.0,
            ),
            alignment: Alignment.center,
            child: const Text(
              'Crear',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
            )
          ),
        ),
      ),
    );
  }
}


class GifView extends StatelessWidget {
  const GifView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/animations/animation.gif'),
      ),
    );
  }
}

void _navigateToGifView(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const GifView(),
    ),
  );
}
