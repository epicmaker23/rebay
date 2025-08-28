// lib/services/category_service.dart
import '../config/supabase_config.dart';
import '../models/category.dart';

class CategoryService {
  Future<List<Category>> getCategories() async {
    final res = await supabase.from('categories').select().order('name');
    return (res as List).map((e) => Category.fromJson(e)).toList();
  }
}
