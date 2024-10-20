import 'package:due_kasir/controller/user_controller.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class UserSheet extends StatelessWidget {
  const UserSheet({super.key, this.side});
  final ShadSheetSide? side;
  @override
  Widget build(BuildContext context) {
    return ShadSheet(
      title: const Text('List Customer'),
      description: const Text("Pick customer who whant to buy"),
      child: SizedBox(
        width: side == ShadSheetSide.bottom || side == ShadSheetSide.top
            ? MediaQuery.sizeOf(context).width
            : null,
        child: Material(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Watch((context) => DataTable(
                        columns: const [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Birth')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Join')),
                          DataColumn(label: Text('Role')),
                          DataColumn(label: Text('Detail')),
                        ],
                        rows: userController.users.value.map(
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
                            error: (e) => Text('Error $e'),
                            data: (data) {
                              return [
                                for (Users user in data)
                                  DataRow(cells: [
                                    DataCell(Text(user.id.toString())),
                                    DataCell(Text(user.nama)),
                                    DataCell(Text(dateWithoutTime
                                        .format(user.dob ?? DateTime.now()))),
                                    DataCell(Text(user.status == true
                                        ? 'Active'
                                        : 'Non Active')),
                                    DataCell(Text(dateWithTime
                                        .format(user.masuk ?? DateTime.now()))),
                                    DataCell(Text(user.keterangan ?? '')),
                                    DataCell(
                                      const Icon(
                                          Icons.keyboard_arrow_right_outlined),
                                      onTap: () {
                                        userController.userSelected.value =
                                            user;
                                        context.push('/users/form');
                                      },
                                    ),
                                  ])
                              ];
                            }),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
