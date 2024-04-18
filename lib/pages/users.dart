import 'package:due_kasir/controller/user_controller.dart';
import 'package:due_kasir/pages/users/user_form.dart';
import 'package:due_kasir/pages/users/user_list.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              if (userController.listActive.watch(context))
                const UserList()
              else
                UserForm(user: userController.userSelected.value),
              if (userController.listActive.watch(context))
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () => userController.listActive.value = false,
                      tooltip: 'Add',
                      child: const Icon(Icons.add),
                    ),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
