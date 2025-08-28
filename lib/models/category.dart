// lib/models/category.dart
class Category {
  final String id;
  final String name;
  final String slug;
  final String? parentId;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    this.parentId,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      parentId: json['parent_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'slug': slug, 'parent_id': parentId};
  }
}
