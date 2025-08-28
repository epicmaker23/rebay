import 'package:flutter/material.dart';

class AdDetailScreen extends StatelessWidget {
  final String adId;
  const AdDetailScreen({super.key, required this.adId});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Anuncio $adId')),
        body: Center(child: Text('Detalle $adId')),
      );
}
