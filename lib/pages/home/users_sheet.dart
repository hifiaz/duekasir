import 'package:due_kasir/controller/auth_controller.dart';
import 'package:due_kasir/controller/user_controller.dart';
import 'package:due_kasir/service/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class UsersSheet extends StatelessWidget {
  const UsersSheet({super.key, this.side});

  final ShadSheetSide? side;

  @override
  Widget build(BuildContext context) {
    final auth = authController.customer.watch(context);
    final users = userController.users.watch(context);
    return SafeArea(
      child: ShadSheet(
        title: const Text('List Profile'),
        description: const Text(
            "Make changes to your profile here. Click save when you're done"),
        child: SizedBox(
          width: side == ShadSheetSide.bottom || side == ShadSheetSide.top
              ? MediaQuery.sizeOf(context).width
              : null,
          child: Material(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: users.value != null
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: users.value!
                          .map((p) => ListTile(
                                title: Text(p.nama),
                                subtitle: Text(p.keterangan ?? ''),
                                trailing: Icon(auth.value?.id == p.id
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank),
                                onTap: () async {
                                  if (auth.hasValue) {
                                    await SupabaseHelper()
                                        .authUser(val: p)
                                        .whenComplete(
                                          () =>
                                              authController.customer.refresh(),
                                        );
                                  } else {
                                    await SupabaseHelper().authUser();
                                  }
                                  authController.customer.refresh();
                                  if (context.mounted) context.pop();
                                },
                              ))
                          .toList(),
                    )
                  : const Text('You not have uses'),
            ),
          ),
        ),
      ),
    );
  }
}
