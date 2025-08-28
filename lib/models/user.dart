class User {
  final String id;
  final String email;
  final String name;
  final String? phone;
  final String? avatarUrl;
  final bool isPremium;
  final DateTime? premiumExpiresAt;
  final String role;
  final int adsCountThisMonth;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.avatarUrl,
    required this.isPremium,
    this.premiumExpiresAt,
    required this.role,
    required this.adsCountThisMonth,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      avatarUrl: json['avatar_url'],
      isPremium: json['is_premium'] ?? false,
      premiumExpiresAt: json['premium_expires_at'] != null
          ? DateTime.parse(json['premium_expires_at'])
          : null,
      role: json['role'] ?? 'user',
      adsCountThisMonth: json['ads_count_this_month'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'avatar_url': avatarUrl,
      'is_premium': isPremium,
      'premium_expires_at': premiumExpiresAt?.toIso8601String(),
      'role': role,
      'ads_count_this_month': adsCountThisMonth,
    };
  }

  bool get canPublishMoreAds {
    return isPremium || adsCountThisMonth < 3;
  }
}
