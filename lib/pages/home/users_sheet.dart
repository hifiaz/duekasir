import 'package:due_kasir/controller/auth_controller.dart';
import 'package:due_kasir/controller/user_controller.dart';
import 'package:due_kasir/model/auth_model.dart';
import 'package:due_kasir/service/database.dart';
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
        content: SizedBox(
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
                                trailing: Icon(auth.value?.user.value?.id == p.id
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank),
                                onTap: () async {
                                  if (auth.hasValue) {
                                    final user = AuthModel()
                                      ..id = auth.value!.id
                                      ..user.value = p;
                                    await Database()
                                        .changeUser(user)
                                        .whenComplete(
                                          () => authController.customer.refresh(),
                                        );
                                  } else {
                                    final user = AuthModel()
                                      ..user.value = p
                                      ..createdAt = DateTime.now();
                                    await Database().loginUser(user);
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
