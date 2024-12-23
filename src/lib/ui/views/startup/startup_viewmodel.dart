import 'package:my_app/app/app.locator.dart';
import 'package:my_app/app/app.router.dart';
import 'package:my_app/services/user_preferences_service.dart';
import 'package:my_app/services/analytic_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userPreferences = locator<UserPreferencesService>();
  final _analyticService = locator<AnalyticService>();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future runStartupLogic() async {
    try {
      setBusy(true);

      // Load saved user data
      final user = await _userPreferences.getUser();
      if (user != null) {
        _analyticService.setUser(user);
      }

      await Future.delayed(const Duration(seconds: 3));

      await _navigationService.replaceWithHomeView();
    } catch (e) {
      _errorMessage =
          'Failed to initialize app: Please check your connection and try again';
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }
}
