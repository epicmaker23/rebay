// lib/services/ad_service.dart
import '../config/supabase_config.dart';
import '../models/ad.dart';

class AdService {
  /// Obtiene anuncios con filtros opcionales
  Future<List<Ad>> getAds({
    String? categoryId,
    String? search,
    bool featuredOnly = false,
  }) async {
    final query = supabase
        .from('ads')
        .select('*, ad_images(*), categories(*), users(*)')
        .order('created_at', ascending: false);

    if (categoryId != null && categoryId.isNotEmpty) {
      query.eq('category_id', categoryId);
    }

    if (search != null && search.isNotEmpty) {
      query.ilike('title', '%$search%');
    }

    if (featuredOnly) {
      query.eq('is_featured', true);
    }

    final data = await query;
    return (data as List).map((json) => Ad.fromJson(json)).toList();
  }

  /// Obtiene un anuncio por ID
  Future<Ad?> getAdById(String id) async {
    final data = await supabase
        .from('ads')
        .select('*, ad_images(*), categories(*), users(*)')
        .eq('id', id)
        .maybeSingle();

    if (data == null) return null;
    return Ad.fromJson(data);
  }

  /// Crea un nuevo anuncio
  Future<Ad> createAd({
    required String title,
    required String description,
    required String categoryId,
    double? price,
    bool priceNegotiable = false,
    String? location,
    List<String> imageUrls = const [],
  }) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) {
      throw Exception('Usuario no autenticado');
    }

    final inserted = await supabase
        .from('ads')
        .insert({
          'user_id': userId,
          'category_id': categoryId,
          'title': title,
          'description': description,
          'price': price,
          'price_negotiable': priceNegotiable,
          'location': location,
        })
        .select()
        .single();

    final ad = Ad.fromJson(inserted);

    // Si hay imágenes, insertarlas en ad_images
    for (var url in imageUrls) {
      await supabase.from('ad_images').insert({'ad_id': ad.id, 'url': url});
    }

    return ad;
  }

  /// Elimina un anuncio
  Future<void> deleteAd(String adId) async {
    await supabase.from('ads').delete().eq('id', adId);
  }

  /// Incrementa contador de vistas
  Future<void> incrementViews(String adId) async {
    await supabase.rpc('increment_ad_views', params: {'ad_id': adId});
  }

  /// Incrementa contador de contactos
  Future<void> incrementContacts(String adId) async {
    await supabase.rpc('increment_ad_contacts', params: {'ad_id': adId});
  }
}
