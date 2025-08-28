import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/home/home_screen.dart';
import '../screens/ads/ad_detail_screen.dart';
import '../screens/ads/create_ad_screen.dart'; // assumed existing
import '../screens/messages/messages_screen.dart'; // assumed existing
import '../screens/messages/conversation_screen.dart'; // assumed existing
import '../screens/admin/admin_dashboard.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/profile/my_ads_screen.dart';
import '../screens/premium/premium_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/category/category_screen.dart';
import '../screens/static/privacy_policy_screen.dart';
import '../screens/static/terms_of_service_screen.dart';
import '../screens/static/not_found_screen.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      routes: [
        GoRoute(path: '/', name: 'home', builder: (_, __) => const HomeScreen()),
        GoRoute(
          path: '/ad/:id',
          name: 'ad-detail',
          builder: (_, s) => AdDetailScreen(adId: s.pathParameters['id']!),
        ),
        GoRoute(path: '/create-ad', name: 'create-ad', builder: (_, __) => const CreateAdScreen()),
        GoRoute(path: '/profile', name: 'profile', builder: (_, __) => const ProfileScreen()),
        GoRoute(path: '/my-ads', name: 'my-ads', builder: (_, __) => const MyAdsScreen()),
        GoRoute(path: '/messages', name: 'messages', builder: (_, __) => const MessagesScreen()),
        GoRoute(
          path: '/messages/:conversationId',
          name: 'conversation',
          builder: (_, s) => ConversationScreen(conversationId: s.pathParameters['conversationId']!),
        ),
        GoRoute(path: '/admin', name: 'admin', builder: (_, __) => const AdminDashboard()),
        GoRoute(path: '/premium', name: 'premium', builder: (_, __) => const PremiumScreen()),
        GoRoute(
          path: '/search',
          name: 'search',
          builder: (_, s) => SearchScreen(
            initialQuery: s.uri.queryParameters['q'],
            categoryId: s.uri.queryParameters['category'],
          ),
        ),
        GoRoute(
          path: '/category/:slug',
          name: 'category',
          builder: (_, s) => CategoryScreen(categorySlug: s.pathParameters['slug']!),
        ),
        GoRoute(path: '/privacy', name: 'privacy', builder: (_, __) => const PrivacyPolicyScreen()),
        GoRoute(path: '/terms', name: 'terms', builder: (_, __) => const TermsOfServiceScreen()),
        GoRoute(path: '/404', name: '404', builder: (_, __) => const NotFoundScreen()),
      ],
      errorBuilder: (_, __) => const NotFoundScreen(),
    );
  }
}
