import 'package:due_kasir/controller/auth_controller.dart';
import 'package:due_kasir/controller/customer_controller.dart';
import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = Supabase.instance.client.auth.currentUser;
    final auth = authController.customer.watch(context);
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color(0xff71C9CE)),
              accountName: Text(
                  '${auth.value?.user.value?.nama ?? "Kasir"} - ${auth.value?.user.value?.keterangan ?? "Role"}',
                  style: ShadTheme.of(context).textTheme.h4),
              accountEmail: Text(user?.email ?? '',
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
              title: const Text('Rent'),
              leading: const Icon(Icons.shopping_bag),
              onTap: () {
                context.go('/rent');
              },
            ),
            ListTile(
              title: const Text('Inventory'),
              leading: const Icon(Icons.inventory),
              onTap: () {
                Database().searchInventorys().then((val) {
                  inventoryController.inventorys.clear();
                  inventoryController.inventorys.addAll(val);
                });
                context.go('/inventory');
              },
            ),
            ListTile(
              title: const Text('Presence'),
              leading: const Icon(Icons.adobe_sharp),
              onTap: () {
                context.go('/presence');
              },
            ),
            ListTile(
              title: const Text('Expenses'),
              leading: const Icon(Icons.monetization_on),
              onTap: () {
                context.go('/expenses');
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
              onTap: () {
                Database().searchCustomers().then((val) {
                  customerController.customer.clear();
                  customerController.customer.addAll(val);
                });
                context.go('/customer');
              },
            ),
            ListTile(
              title: const Text('Account'),
              leading: const Icon(Icons.account_circle),
              trailing: PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (item) async {
                  if (item == 'restore') {
                    ShadToaster.of(context).show(
                      ShadToast(
                        title: const Text('Restore Backup?'),
                        description:
                            const Text('Please pick isar file to restore'),
                        action: ShadButton.outline(
                          text: const Text('Select'),
                          onPressed: () => Database()
                              .restoreDB()
                              .whenComplete(() => ShadToaster.of(context).show(
                                    const ShadToast(
                                      title: Text('Restore Database Success!'),
                                      description: Text(
                                          'Please make sure all data is imported'),
                                    ),
                                  )),
                        ),
                      ),
                    );
                  } else if (item == 'login') {
                    context.pop();
                    context.push('/login');
                  } else if (item == 'backup') {
                    context.pop();
                    Database().createBackUp().then((_) => const ShadToast(
                          title: Text('Backup Database Success!'),
                          description: Text('All your data on download folder'),
                        ));
                  } else if (item == 'clear') {
                    context.pop();
                    showShadDialog(
                      context: context,
                      builder: (context) => ShadDialog.alert(
                        title: const Text('Are you absolutely sure?'),
                        description: const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            'This action cannot be undone. This will permanently delete your data.',
                          ),
                        ),
                        actions: [
                          ShadButton.outline(
                            text: const Text('Cancel'),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                          ShadButton(
                            text: const Text('Continue'),
                            onPressed: () async {
                              await Database().clearAllData().whenComplete(
                                  () => Navigator.of(context).pop(true));
                            },
                          ),
                        ],
                      ),
                    );
                  } else if (item == 'logout') {
                    context.pop();
                    await Supabase.instance.client.auth.signOut();
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'restore',
                    child: Text('Restore'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'backup',
                    child: Text('Backup'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'clear',
                    child: Text('Clear/Reset'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'store',
                    child: Text('Store'),
                  ),
                  if (user == null)
                    const PopupMenuItem<String>(
                      value: 'login',
                      child: Text('Login'),
                    )
                  else
                    const PopupMenuItem<String>(
                      value: 'logout',
                      child: Text('Logout'),
                    ),
                ],
              ),
              onTap: () => context.go('/home'),
            ),
          ],
        ),
      ),
    );
  }
}
