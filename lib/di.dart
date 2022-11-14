import 'package:get_it/get_it.dart';
import 'package:our_pass/core/services/local_storage.dart';
import 'package:our_pass/features/auth/presentation/viewmodel/login_vm.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  _registerOthers();

  _registerLocalService();
  // register viewModels
  _registerViewModels();
}

// Any other class
Future<void> _registerOthers() async {
  final sharePreference = await SharedPreferences.getInstance();
  sl.registerFactory<SharedPreferences>(() => sharePreference);
}

void _registerLocalService() {
  sl.registerFactory<LocalStorage>(() => LocalStorageImpl(sl()));
}

// View models
void _registerViewModels() {
  sl.registerFactory(
    () => AuthProvider(),
  );
}
