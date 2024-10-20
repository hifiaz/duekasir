import 'package:due_kasir/controller/user_controller.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:signals/signals_flutter.dart';

class UserList extends HookWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    final users = userController.users.watch(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              onChanged: (val) {
                userController.searchUser.value = val;
                userController.users.refresh();
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
              ),
            ),
            const SizedBox(height: 20),
            DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Birth')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Join')),
                DataColumn(label: Text('Role')),
                DataColumn(label: Text('Detail')),
              ],
              rows: users.map(
                  loading: () => [
                        const DataRow(cells: [
                          DataCell(Text('Loading')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text(''))
                        ])
                      ],
                  error: (e) => [
                        const DataRow(cells: [
                          DataCell(Text('No Data')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text('')),
                          DataCell(Text(''))
                        ])
                      ],
                  data: (data) {
                    return [
                      for (Users user in data)
                        DataRow(cells: [
                          DataCell(Text(user.id.toString())),
                          DataCell(Text(user.nama)),
                          DataCell(Text(dateWithoutTime
                              .format(user.dob ?? DateTime.now()))),
                          DataCell(Text(
                              user.status == true ? 'Active' : 'Non Active')),
                          DataCell(Text(dateWithTime
                              .format(user.masuk ?? DateTime.now()))),
                          DataCell(Text(user.keterangan ?? '')),
                          DataCell(
                            const Icon(Icons.keyboard_arrow_right_outlined),
                            onTap: () {
                              userController.userSelected.value = user;
                              context.push('/users/form');
                            },
                          ),
                        ])
                    ];
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
