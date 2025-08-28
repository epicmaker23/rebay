import 'package:flutter/material.dart';

class CreateAdScreen extends StatelessWidget {
  const CreateAdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear anuncio')),
      body: const Center(child: Text('Formulario de creación')),
    );
  }
}
