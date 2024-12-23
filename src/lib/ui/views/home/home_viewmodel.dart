import 'package:my_app/app/app.bottomsheets.dart';
import 'package:my_app/app/app.dialogs.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/user_data.dart';
import 'package:my_app/services/shared_preferences_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final _preferencesService = locator<SharedPreferencesService>();

  String get counterLabel => 'Counter is: $_counter';
  String? get modelError => _modelError;

  int _counter = 0;
  String? _modelError;

  Future<void> init() async {
    try {
      final userData = await _preferencesService.getUserData();
      _counter = userData.counter;
      notifyListeners();
    } catch (e) {
      _modelError = e.toString();
      notifyListeners();
    }
  }

  Future<void> incrementCounter() async {
    _counter++;
    try {
      await _preferencesService.saveUserData(
        UserData(counter: _counter),
      );
      notifyListeners();
    } catch (e) {
      _modelError = e.toString();
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
