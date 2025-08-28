// lib/providers/ad_provider.dart
import 'package:flutter/foundation.dart';
import '../models/ad.dart';
import '../models/category.dart';
import '../services/ad_service.dart';
import '../services/category_service.dart';

class AdProvider extends ChangeNotifier {
  final AdService _adService = AdService();
  final CategoryService _categoryService = CategoryService();

  List<Ad> _ads = <Ad>[];
  List<Category> _categories = <Category>[];
  bool _isLoading = false;
  String? _errorMessage;

  List<Ad> get ads => _ads;
  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Carga anuncios desde el servicio, con filtros opcionales.
  Future<void> loadAds({
    String? categoryId,
    String? search,
    bool featuredOnly = false,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      _ads = await _adService.getAds(
        categoryId: categoryId,
        search: search,
        featuredOnly: featuredOnly,
      );
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Carga categorías desde el servicio.
  Future<void> loadCategories() async {
    try {
      _categories = await _categoryService.getCategories();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  /// Crea un nuevo anuncio y lo añade a la lista local.
  Future<bool> createAd({
    required String title,
    required String description,
    required String categoryId,
    double? price,
    bool priceNegotiable = false,
    String? location,
    List<String> imageUrls = const [],
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      final ad = await _adService.createAd(
        title: title,
        description: description,
        categoryId: categoryId,
        price: price,
        priceNegotiable: priceNegotiable,
        location: location,
        imageUrls: imageUrls,
      );

      _ads.insert(0, ad);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Elimina un anuncio de la base de datos y de la lista local.
  Future<bool> deleteAd(String adId) async {
    try {
      await _adService.deleteAd(adId);
      _ads.removeWhere((ad) => ad.id == adId);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    }
  }
}
