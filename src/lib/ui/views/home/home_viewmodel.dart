import 'package:my_app/app/app.bottomsheets.dart';
import 'package:my_app/app/app.dialogs.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/user.dart';
import 'package:my_app/services/analytic_service.dart';
import 'package:my_app/services/user_preferences_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _userPreferences = locator<UserPreferencesService>();
  final _analyticService = locator<AnalyticService>();

  String get counterLabel => 'Counter is: $_counter';
  String? get errorMessage => _errorMessage;

  int _counter = 0;
  String? _errorMessage;

  Future<void> init() async {
    try {
      final user = await _userPreferences.getUser();
      if (user != null) {
        _counter = user.counter;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to load user data: Please try again';
      notifyListeners();
    }
  }

  Future<void> incrementCounter() async {
    try {
      _counter++;

      final currentUser = _analyticService.currentUser;
      final updatedUser = currentUser?.copyWith(counter: _counter) ??
          User(
            id: DateTime.now().toString(),
            name: 'User',
            counter: _counter,
          );

      await _userPreferences.saveUser(updatedUser);
      _analyticService.setUser(updatedUser);

      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to save counter: Please try again';
      notifyListeners();
    }
  }

  void showDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Steve Rocks!',
      description: 'Give steve $_counter stars on Github',
    );
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.notice,
      title: 'title',
      description: 'desc',
    );
  }
}
