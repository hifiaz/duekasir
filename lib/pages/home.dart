import 'package:due_kasir/controller/auth_controller.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/pages/home/users_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final auth = authController.customer.watch(context);
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Account'),
        centerTitle: false,
        actions: [
          // ShadButton(
          //   icon: const Padding(
          //       padding: EdgeInsets.only(right: 8),
          //       child: Icon(Icons.clear_all)),
          //   text: const Text('Reset'),
          //   onPressed: () {
          //     showShadDialog(
          //       context: context,
          //       builder: (context) => ShadDialog.alert(
          //         title: const Text('Are you absolutely sure?'),
          //         description: const Padding(
          //           padding: EdgeInsets.only(bottom: 8),
          //           child: Text(
          //             'This action cannot be undone. This will permanently delete your data.',
          //           ),
          //         ),
          //         actions: [
          //           ShadButton.outline(
          //             text: const Text('Cancel'),
          //             onPressed: () => Navigator.of(context).pop(false),
          //           ),
          //           ShadButton(
          //             text: const Text('Continue'),
          //             onPressed: () async {
          //               await Database().clearAllData().whenComplete(
          //                   () => Navigator.of(context).pop(true));
          //             },
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
          // ShadButton(
          //   icon: const Padding(
          //       padding: EdgeInsets.only(right: 8), child: Icon(Icons.store)),
          //   text: const Text('Backup'),
          //   onPressed: () => Database().createBackUp().whenComplete(
          //         () => const ShadToast(
          //           title: Text('Backup Database Success!'),
          //           description: Text('All your data on download folder'),
          //         ),
          //       ),
          // ),
          ShadButton(
            icon: const Padding(
                padding: EdgeInsets.only(right: 8), child: Icon(Icons.store)),
            text: const Text('Store'),
            onPressed: () {
              context.push('/home/store');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ShadCard(
            width: 350,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Account Login', style: theme.textTheme.h4),
                IconButton(onPressed: () => context.push('/login'), icon: const Icon(Icons.login))
              ],
            ),
            description:
                const Text('Make sure you have login with your account'),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Name', style: theme.textTheme.large),
                  Text(auth.value?.user.value?.nama ?? 'Kasir'),
                  const SizedBox(height: 6),
                  Text('Role', style: theme.textTheme.large),
                  Text(auth.value?.user.value?.keterangan ?? 'Super User'),
                ],
              ),
            ),
            footer: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ShadButton(
                  text: const Text('Change'),
                  onPressed: () {
                    showShadSheet(
                      side: ShadSheetSide.right,
                      context: context,
                      builder: (context) => const UsersSheet(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
