// lib/widgets/image_upload_widget.dart
import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageUploadWidget extends StatelessWidget {
  final List<Uint8List> images;
  final VoidCallback onPick;
  final void Function(int index)? onRemove;

  const ImageUploadWidget({
    super.key,
    required this.images,
    required this.onPick,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: images.asMap().entries.map((e) {
            return Stack(
              children: [
                Image.memory(
                  e.value,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                if (onRemove != null)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => onRemove!(e.key),
                    ),
                  ),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: onPick,
          icon: const Icon(Icons.photo),
          label: const Text('Añadir imágenes'),
        ),
      ],
    );
  }
}
