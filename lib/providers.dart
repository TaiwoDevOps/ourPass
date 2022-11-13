import 'package:get_it/get_it.dart';
import 'package:our_pass/features/auth/presentation/viewmodel/login_vm.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider<AuthProvider>(
    create: (_) => GetIt.I<AuthProvider>(),
  ),
];
