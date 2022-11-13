import 'package:get_it/get_it.dart';
import 'package:our_pass/core/services/local_storage.dart';
import 'package:our_pass/features/auth/presentation/viewmodel/login_vm.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  _registerStorage();
  // register viewmodels
  _registerViewModels();
}

void _registerStorage() {
  sl.registerFactory<LocalStorage>(() => LocalStorageImpl(sl()));
}

// View models
void _registerViewModels() {
  sl.registerFactory(
    () => LoginProvider(),
  );
}
