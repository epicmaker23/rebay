import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final _auth = AuthService();
  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AuthProvider() {
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    _currentUser = await _auth.getCurrentUser();
    notifyListeners();
  }

  Future<bool> signUp(String email, String password, String name) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      final resp = await _auth.signUp(email, password, name);
      await _loadCurrentUser();
      return resp.user != null;
    } catch (e) {
      _errorMessage = '$e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      final resp = await _auth.signIn(email, password);
      await _loadCurrentUser();
      return resp.user != null;
    } catch (e) {
      _errorMessage = '$e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _currentUser = null;
    } catch (e) {
      _errorMessage = '$e';
    }
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    try {
      _errorMessage = null;
      await _auth.resetPassword(email);
    } catch (e) {
      _errorMessage = '$e';
      notifyListeners();
    }
  }

  Future<void> updateProfile(Map<String, dynamic> updates) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      await _auth.updateProfile(updates);
      await _loadCurrentUser();
    } catch (e) {
      _errorMessage = '$e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
