import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/models/user_data.dart';
import 'package:stacked/stacked_annotations.dart';

class SharedPreferencesService implements InitializableDependency {
  static const String _userDataKey = 'user_data';
  SharedPreferences? _prefs;

  Future<void> saveUserData(UserData userData) async {
    try {
      if (_prefs == null) {
        throw 'Shared preferences not initialized';
      }

      final userDataJson = jsonEncode(userData.toJson());
      await _prefs!.setString(_userDataKey, userDataJson);
    } catch (e) {
      throw 'Failed to save user data: Please try again later';
    }
  }

  Future<UserData> getUserData() async {
    try {
      if (_prefs == null) {
        throw 'Shared preferences not initialized';
      }

      final userDataJson = _prefs!.getString(_userDataKey);
      if (userDataJson == null) {
        return const UserData();
      }

      final userData = UserData.fromJson(
        jsonDecode(userDataJson) as Map<String, dynamic>,
      );
      return userData;
    } catch (e) {
      throw 'Failed to load user data: Please restart the app';
    }
  }

  @override
  Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      throw 'Failed to initialize storage: Please check app permissions';
    }
  }
}