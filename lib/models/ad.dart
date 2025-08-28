// lib/models/ad.dart
import 'category.dart';
import 'user.dart';

class Ad {
  final String id;
  final String userId;
  final String categoryId;
  final String title;
  final String description;
  final double? price;
  final bool priceNegotiable;
  final String? location;
  final double? latitude;
  final double? longitude;
  final String status;
  final bool isFeatured;
  final DateTime? featuredExpiresAt;
  final int viewsCount;
  final int contactCount;
  final DateTime createdAt;
  final DateTime? publishedAt;
  final DateTime expiresAt;
  final List<AdImage> images;
  final Category? category;
  final User? user;

  Ad({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.description,
    this.price,
    required this.priceNegotiable,
    this.location,
    this.latitude,
    this.longitude,
    required this.status,
    required this.isFeatured,
    this.featuredExpiresAt,
    required this.viewsCount,
    required this.contactCount,
    required this.createdAt,
    this.publishedAt,
    required this.expiresAt,
    this.images = const [],
    this.category,
    this.user,
  });

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      id: json['id'],
      userId: json['user_id'],
      categoryId: json['category_id'],
      title: json['title'],
      description: json['description'],
      price: json['price']?.toDouble(),
      priceNegotiable: json['price_negotiable'] ?? false,
      location: json['location'],
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      status: json['status'],
      isFeatured: json['is_featured'] ?? false,
      featuredExpiresAt: json['featured_expires_at'] != null
          ? DateTime.parse(json['featured_expires_at'])
          : null,
      viewsCount: json['views_count'] ?? 0,
      contactCount: json['contact_count'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      publishedAt: json['published_at'] != null
          ? DateTime.parse(json['published_at'])
          : null,
      expiresAt: DateTime.parse(json['expires_at']),
      images: json['ad_images'] != null
          ? (json['ad_images'] as List)
                .map((img) => AdImage.fromJson(img))
                .toList()
          : [],
      // Cuando uses select con relaciones, llegan anidadas como 'categories' y 'users'
      category: json['categories'] != null
          ? Category.fromJson(json['categories'])
          : null,
      user: json['users'] != null ? User.fromJson(json['users']) : null,
    );
  }

  String get priceFormatted {
    if (price == null) return 'Precio a consultar';
    return '${price!.toStringAsFixed(0)}€${priceNegotiable ? ' (Negociable)' : ''}';
  }

  String get mainImageUrl {
    return images.isNotEmpty ? images.first.url : '';
  }
}

class AdImage {
  final String id;
  final String adId;
  final String url;
  final String? thumbnailUrl;
  final String? altText;
  final int sortOrder;

  AdImage({
    required this.id,
    required this.adId,
    required this.url,
    this.thumbnailUrl,
    this.altText,
    required this.sortOrder,
  });

  factory AdImage.fromJson(Map<String, dynamic> json) {
    return AdImage(
      id: json['id'],
      adId: json['ad_id'],
      url: json['url'],
      thumbnailUrl: json['thumbnail_url'],
      altText: json['alt_text'],
      sortOrder: json['sort_order'] ?? 0,
    );
  }
}
