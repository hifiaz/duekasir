import 'package:due_kasir/controller/auth_controller.dart';
import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = authController.customer.watch(context);
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Color(0xff71C9CE)),
            accountName: Text(auth.value?.user.value?.nama ?? "Kasir",
                style: ShadTheme.of(context).textTheme.h4),
            accountEmail: Text(auth.value?.user.value?.keterangan ?? "Role",
                style: ShadTheme.of(context).textTheme.p),
            currentAccountPictureSize: const Size(200, 80),
            currentAccountPicture: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Due Kasir',
                  style: ShadTheme.of(context).textTheme.h1,
                ),
                Text(
                  dateWithTime.format(DateTime.now()),
                  style: ShadTheme.of(context).textTheme.p,
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Selling'),
            leading: const Icon(Icons.sell_outlined),
            onTap: () => context.go('/'),
          ),
          ListTile(
            title: const Text('Inventory'),
            leading: const Icon(Icons.inventory),
            onTap: () {
              Database().searchInventorys('').then((val) {
                inventoryController.inventorySearch.clear();
                inventoryController.inventorySearch.addAll(val);
              });
              context.go('/inventory');
            },
          ),
          ListTile(
            title: const Text('Report'),
            leading: const Icon(Icons.home_repair_service_outlined),
            onTap: () => context.go('/report'),
          ),
          ListTile(
            title: const Text('Users'),
            leading: const Icon(Icons.person_2),
            onTap: () => context.go('/users'),
          ),
          ListTile(
            title: const Text('Customer'),
            leading: const Icon(Icons.people),
            onTap: () => context.go('/customer'),
          ),
          const Spacer(),
          ListTile(
            title: const Text('Account'),
            leading: const Icon(Icons.account_circle),
            trailing: IconButton(
                onPressed: () {
                  ShadToaster.of(context).show(
                    ShadToast(
                      title: const Text('Restore Backup?'),
                      description:
                          const Text('Please pick isar file to restore'),
                      action: ShadButton.outline(
                        text: const Text('Select'),
                        onPressed: () => Database().restoreDB(),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.more_vert)),
            onTap: () => context.go('/home'),
          ),
        ],
      ),
    );
  }
}
