// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $sellingRoute,
      $homeRoute,
      $inventoryRoute,
      $reportRoute,
      $userRoute,
      $customerRoute,
      $csvPreviewRoute,
      $printSettingRoute,
      $loginRoute,
      $registerRoute,
      $rentRoute,
      $presenceRoute,
      $expensesRoute,
      $syncRoute,
      $salariesRoute,
      $duePaymentRoute,
      $requestRoute,
      $testingRoute,
    ];

RouteBase get $sellingRoute => GoRouteData.$route(
      path: '/',
      factory: $SellingRouteExtension._fromState,
    );

extension $SellingRouteExtension on SellingRoute {
  static SellingRoute _fromState(GoRouterState state) => const SellingRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeRoute => GoRouteData.$route(
      path: '/home',
      factory: $HomeRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'store',
          factory: $StoreRouteExtension._fromState,
        ),
      ],
    );

extension $HomeRouteExtension on HomeRoute {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  String get location => GoRouteData.$location(
        '/home',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $StoreRouteExtension on StoreRoute {
  static StoreRoute _fromState(GoRouterState state) => const StoreRoute();

  String get location => GoRouteData.$location(
        '/home/store',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $inventoryRoute => GoRouteData.$route(
      path: '/inventory',
      factory: $InventoryRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'form',
          factory: $InventoryFormRouteExtension._fromState,
        ),
      ],
    );

extension $InventoryRouteExtension on InventoryRoute {
  static InventoryRoute _fromState(GoRouterState state) =>
      const InventoryRoute();

  String get location => GoRouteData.$location(
        '/inventory',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $InventoryFormRouteExtension on InventoryFormRoute {
  static InventoryFormRoute _fromState(GoRouterState state) =>
      const InventoryFormRoute();

  String get location => GoRouteData.$location(
        '/inventory/form',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $reportRoute => GoRouteData.$route(
      path: '/report',
      factory: $ReportRouteExtension._fromState,
    );

extension $ReportRouteExtension on ReportRoute {
  static ReportRoute _fromState(GoRouterState state) => const ReportRoute();

  String get location => GoRouteData.$location(
        '/report',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $userRoute => GoRouteData.$route(
      path: '/users',
      factory: $UserRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'form',
          factory: $UserFormRouteExtension._fromState,
        ),
      ],
    );

extension $UserRouteExtension on UserRoute {
  static UserRoute _fromState(GoRouterState state) => const UserRoute();

  String get location => GoRouteData.$location(
        '/users',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $UserFormRouteExtension on UserFormRoute {
  static UserFormRoute _fromState(GoRouterState state) => const UserFormRoute();

  String get location => GoRouteData.$location(
        '/users/form',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $customerRoute => GoRouteData.$route(
      path: '/customer',
      factory: $CustomerRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'form',
          factory: $CustomerFormRouteExtension._fromState,
        ),
      ],
    );

extension $CustomerRouteExtension on CustomerRoute {
  static CustomerRoute _fromState(GoRouterState state) => const CustomerRoute();

  String get location => GoRouteData.$location(
        '/customer',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CustomerFormRouteExtension on CustomerFormRoute {
  static CustomerFormRoute _fromState(GoRouterState state) =>
      const CustomerFormRoute();

  String get location => GoRouteData.$location(
        '/customer/form',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $csvPreviewRoute => GoRouteData.$route(
      path: '/csv-preview',
      factory: $CsvPreviewRouteExtension._fromState,
    );

extension $CsvPreviewRouteExtension on CsvPreviewRoute {
  static CsvPreviewRoute _fromState(GoRouterState state) =>
      const CsvPreviewRoute();

  String get location => GoRouteData.$location(
        '/csv-preview',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $printSettingRoute => GoRouteData.$route(
      path: '/print-setting',
      factory: $PrintSettingRouteExtension._fromState,
    );

extension $PrintSettingRouteExtension on PrintSettingRoute {
  static PrintSettingRoute _fromState(GoRouterState state) =>
      const PrintSettingRoute();

  String get location => GoRouteData.$location(
        '/print-setting',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
      path: '/login',
      factory: $LoginRouteExtension._fromState,
    );

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  String get location => GoRouteData.$location(
        '/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $registerRoute => GoRouteData.$route(
      path: '/register',
      factory: $RegisterRouteExtension._fromState,
    );

extension $RegisterRouteExtension on RegisterRoute {
  static RegisterRoute _fromState(GoRouterState state) => const RegisterRoute();

  String get location => GoRouteData.$location(
        '/register',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $rentRoute => GoRouteData.$route(
      path: '/rent',
      factory: $RentRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'form',
          factory: $RentItemFormRouteExtension._fromState,
        ),
      ],
    );

extension $RentRouteExtension on RentRoute {
  static RentRoute _fromState(GoRouterState state) => const RentRoute();

  String get location => GoRouteData.$location(
        '/rent',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RentItemFormRouteExtension on RentItemFormRoute {
  static RentItemFormRoute _fromState(GoRouterState state) =>
      const RentItemFormRoute();

  String get location => GoRouteData.$location(
        '/rent/form',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $presenceRoute => GoRouteData.$route(
      path: '/presence',
      factory: $PresenceRouteExtension._fromState,
    );

extension $PresenceRouteExtension on PresenceRoute {
  static PresenceRoute _fromState(GoRouterState state) => const PresenceRoute();

  String get location => GoRouteData.$location(
        '/presence',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $expensesRoute => GoRouteData.$route(
      path: '/expenses',
      factory: $ExpensesRouteExtension._fromState,
    );

extension $ExpensesRouteExtension on ExpensesRoute {
  static ExpensesRoute _fromState(GoRouterState state) => const ExpensesRoute();

  String get location => GoRouteData.$location(
        '/expenses',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $syncRoute => GoRouteData.$route(
      path: '/sync',
      factory: $SyncRouteExtension._fromState,
    );

extension $SyncRouteExtension on SyncRoute {
  static SyncRoute _fromState(GoRouterState state) => const SyncRoute();

  String get location => GoRouteData.$location(
        '/sync',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $salariesRoute => GoRouteData.$route(
      path: '/salaries',
      factory: $SalariesRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'form',
          factory: $SalariesFormRouteExtension._fromState,
        ),
      ],
    );

extension $SalariesRouteExtension on SalariesRoute {
  static SalariesRoute _fromState(GoRouterState state) => const SalariesRoute();

  String get location => GoRouteData.$location(
        '/salaries',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SalariesFormRouteExtension on SalariesFormRoute {
  static SalariesFormRoute _fromState(GoRouterState state) =>
      const SalariesFormRoute();

  String get location => GoRouteData.$location(
        '/salaries/form',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $duePaymentRoute => GoRouteData.$route(
      path: '/due-payment',
      factory: $DuePaymentRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'form',
          factory: $DuePaymentFormRouteExtension._fromState,
        ),
      ],
    );

extension $DuePaymentRouteExtension on DuePaymentRoute {
  static DuePaymentRoute _fromState(GoRouterState state) =>
      const DuePaymentRoute();

  String get location => GoRouteData.$location(
        '/due-payment',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $DuePaymentFormRouteExtension on DuePaymentFormRoute {
  static DuePaymentFormRoute _fromState(GoRouterState state) =>
      const DuePaymentFormRoute();

  String get location => GoRouteData.$location(
        '/due-payment/form',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $requestRoute => GoRouteData.$route(
      path: '/request',
      factory: $RequestRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'form',
          factory: $RequestFormRouteExtension._fromState,
        ),
      ],
    );

extension $RequestRouteExtension on RequestRoute {
  static RequestRoute _fromState(GoRouterState state) => const RequestRoute();

  String get location => GoRouteData.$location(
        '/request',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $RequestFormRouteExtension on RequestFormRoute {
  static RequestFormRoute _fromState(GoRouterState state) =>
      const RequestFormRoute();

  String get location => GoRouteData.$location(
        '/request/form',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $testingRoute => GoRouteData.$route(
      path: '/testing',
      factory: $TestingRouteExtension._fromState,
    );

extension $TestingRouteExtension on TestingRoute {
  static TestingRoute _fromState(GoRouterState state) => const TestingRoute();

  String get location => GoRouteData.$location(
        '/testing',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
