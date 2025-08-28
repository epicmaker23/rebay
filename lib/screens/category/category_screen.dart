import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final String categorySlug;
  const CategoryScreen({super.key, required this.categorySlug});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Categoría $categorySlug')),
        body: Center(child: Text('Listado de $categorySlug')),
      );
}
