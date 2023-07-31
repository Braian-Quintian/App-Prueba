import 'dart:io';
import 'package:app_prueba/presentacion/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // Variable para almacenar la ruta de la imagen seleccionada
  String? _imagePath;
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _repeatPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _repeatPasswordFocusNode.dispose();
    super.dispose();
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

  void _handleTap() {
    // Desenfocar el campo de texto actualmente enfocado
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Prueba',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().theme(),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: const Color(0xFFFF991F), // Color del ícono de retroceso
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
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
                  _buildTextField('Nombre', 'Nombre', _nameFocusNode),
                  const SizedBox(height: 20),
                  _buildTextField('Correo Electrónico', 'Correo electrónico',
                      _emailFocusNode,
                      isPassword: false),
                  const SizedBox(height: 20),
                  _buildTextField(
                      'Contraseña', 'Contraseña', _passwordFocusNode,
                      isPassword: true),
                  const SizedBox(height: 20),
                  _buildTextField('Repetir Contraseña', 'Repetir contraseña',
                      _repeatPasswordFocusNode,
                      isPassword: true),
                  const SizedBox(height: 20),
                  _buildCreateAccountButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccountButton() {
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
        child: TextButton( // Cambio de ElevatedButton a TextButton
          onPressed: () {
            _navigateToGifView(context); // Pasa el contexto actual como argumento
          },
          child: const Text(
            'Crear',
            style: TextStyle(
              color:
                  Colors.white, // Color del texto del botón "Ingresar" (blanco)
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, String hintText, FocusNode focusNode,
      {bool isPassword = false}) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: focusNode.hasFocus
                ? const Color(0xFF97A0B0)
                : const Color(0xFF97A0B0),
            width: 1.0),
      ),
      child: TextField(
        focusNode: focusNode,
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
