import 'package:stacked/stacked_annotations.dart';
import 'package:my_app/models/user.dart';

class AnalyticService implements InitializableDependency {
  User? _currentUser;

  User? get currentUser => _currentUser;

  void setUser(User user) {
    _currentUser = user;
  }

  void clearUser() {
    _currentUser = null;
  }

  @override
  Future<void> init() async {
    // Initialize analytics service
    try {
      // Add any additional analytics initialization here
    } catch (e) {
      throw Exception('Failed to initialize AnalyticService: ${e.toString()}');
    }
  }
}
