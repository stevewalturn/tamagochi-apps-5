import 'dart:convert';
import 'package:shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:my_app/models/user.dart';

class UserPreferencesService implements InitializableDependency {
  static const String _userKey = 'user_preferences';
  SharedPreferences? _preferences;

  Future<void> saveUser(User user) async {
    try {
      if (_preferences == null) {
        throw Exception('SharedPreferences not initialized');
      }
      final userJson = json.encode(user.toJson());
      await _preferences!.setString(_userKey, userJson);
    } catch (e) {
      throw Exception('Failed to save user preferences: ${e.toString()}');
    }
  }

  Future<User?> getUser() async {
    try {
      if (_preferences == null) {
        throw Exception('SharedPreferences not initialized');
      }
      final userJson = _preferences!.getString(_userKey);
      if (userJson == null) return null;
      return User.fromJson(json.decode(userJson));
    } catch (e) {
      throw Exception('Failed to get user preferences: ${e.toString()}');
    }
  }

  Future<void> clearUser() async {
    try {
      if (_preferences == null) {
        throw Exception('SharedPreferences not initialized');
      }
      await _preferences!.remove(_userKey);
    } catch (e) {
      throw Exception('Failed to clear user preferences: ${e.toString()}');
    }
  }

  @override
  Future<void> init() async {
    try {
      _preferences = await SharedPreferences.getInstance();
    } catch (e) {
      throw Exception(
          'Failed to initialize SharedPreferences: ${e.toString()}');
    }
  }
}
