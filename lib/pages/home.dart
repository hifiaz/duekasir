import 'package:due_kasir/controller/auth_controller.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/pages/home/users_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final auth = authController.customer.watch(context);
    User? user = Supabase.instance.client.auth.currentUser;
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Account'),
        centerTitle: false,
        actions: [
          ShadButton.ghost(
            icon: const Padding(
                padding: EdgeInsets.only(right: 8), child: Icon(Icons.store)),
            child: const Text('Store'),
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
                if (user == null)
                  ShadButton.outline(
                    child: const Text('Login'),
                    onPressed: () => context.push('/login'),
                  ),
              ],
            ),
            description:
                const Text('Make sure you have login with your account'),
            footer: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ShadButton(
                  child: const Text('Change'),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Name', style: theme.textTheme.large),
                  Text(auth.value?.nama ?? 'Kasir'),
                  const SizedBox(height: 6),
                  Text('Role', style: theme.textTheme.large),
                  Text(auth.value?.keterangan ?? 'Super User'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
