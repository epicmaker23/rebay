import 'package:flutter/material.dart';

class ConversationScreen extends StatelessWidget {
  final String conversationId;
  const ConversationScreen({super.key, required this.conversationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Conversación $conversationId')),
      body: const Center(child: Text('Mensajes de la conversación')),
    );
  }
}
