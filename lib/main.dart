import 'package:due_kasir/routes/router.dart';
import 'package:due_kasir/service/get_it.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(const MyApp());
}

final _router = GoRouter(routes: $appRoutes);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp.materialRouter(
      debugShowCheckedModeBanner: false,
      title: 'Due Kasir',
      routerConfig: _router,
    );
  }
}
