import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/pages/users/user_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: false,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                const UserList(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      onPressed: () => context.push('/user/form'),
                      tooltip: 'Add',
                      child: const Icon(Icons.add),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
