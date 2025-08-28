import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final String? initialQuery;
  final String? categoryId;
  const SearchScreen({super.key, this.initialQuery, this.categoryId});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Buscar')),
        body: Center(child: Text('q=$initialQuery cat=$categoryId')),
      );
}
