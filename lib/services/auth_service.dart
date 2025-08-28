import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/supabase_config.dart';
import '../models/user.dart';

class AuthService {
  Future<AuthResponse> signUp(
    String email,
    String password,
    String name,
  ) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );

    if (response.user != null) {
      // Crear perfil de usuario
      await supabase.from('users').insert({
        'id': response.user!.id,
        'email': email,
        'name': name,
      });
    }

    return response;
  }

  Future<AuthResponse> signIn(String email, String password) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<User?> getCurrentUser() async {
    final authUser = supabase.auth.currentUser;
    if (authUser == null) return null;

    final response = await supabase
        .from('users')
        .select('*')
        .eq('id', authUser.id)
        .maybeSingle();

    if (response == null) return null;
    return User.fromJson(response);
  }

  Stream<AuthState> get authStateStream => supabase.auth.onAuthStateChange;

  Future<void> resetPassword(String email) async {
    await supabase.auth.resetPasswordForEmail(email);
  }

  Future<void> updateProfile(Map<String, dynamic> updates) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('Usuario no autenticado');

    await supabase.from('users').update(updates).eq('id', user.id);
  }
}
