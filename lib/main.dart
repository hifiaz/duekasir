import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:due_kasir/powersync.dart';
import 'package:due_kasir/routes/router.dart';
import 'package:due_kasir/service/get_it.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

final isDeviceConnected = signal(false);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await openDatabase();
  setup();
  runApp(const MyApp());
}

final _router = GoRouter(routes: $appRoutes);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<List<ConnectivityResult>> subscription;
  @override
  void initState() {
    super.initState();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      isDeviceConnected.value = await InternetConnection().hasInternetAccess;
      log("Internet status ====== $isDeviceConnected");
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadApp.materialRouter(
      debugShowCheckedModeBanner: false,
      title: 'Due Kasir',
      routerConfig: _router,
    );
  }
}
