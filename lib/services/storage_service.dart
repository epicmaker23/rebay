// lib/services/storage_service.dart
import 'dart:typed_data';
import '../config/supabase_config.dart';

class StorageService {
  final _bucket = supabase.storage.from('ad-images');

  Future<String> uploadImage(String adId, Uint8List bytes) async {
    final filePath = '$adId/${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Versión básica del SDK
    await _bucket.uploadBinary(filePath, bytes);

    return _bucket.getPublicUrl(filePath);
  }

  Future<void> deleteImage(String path) async {
    await _bucket.remove([path]);
  }
}
