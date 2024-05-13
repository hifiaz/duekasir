import 'package:due_kasir/controller/user_controller.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class UserForm extends HookWidget {
  UserForm({super.key});

  final statusData = {true: 'Active', false: 'Non Active'};

  final roleData = {
    'User': 'User',
    'Admin': 'Admin',
    'Super Admin': 'Super Admin'
  };

  @override
  Widget build(BuildContext context) {
    final user = userController.userSelected.watch(context);
    final editingName = useTextEditingController(text: user?.nama ?? '');
    final lahirTemp = useTextEditingController(
        text: user?.dob != null ? dateWithoutTime.format(user!.dob!) : '');
    final lahir = useState(user?.dob ?? DateTime.now());
    final status = useState(user?.status ?? true);
    final role = useState(user?.keterangan ?? 'User');
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: ShadButton.ghost(
                  text: const Text('Close'),
                  onPressed: () => context.pop(),
                ),
              ),
              ShadInputFormField(
                controller: editingName,
                validator: (val) =>
                    val.isEmpty == true ? 'Name is required' : null,
                label: const Text('Nama'),
                placeholder: const Text('Jhon Doe'),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: user?.dob ?? DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          lahirTemp.text = dateWithoutTime.format(lahir.value);
                          lahir.value = pickedDate;
                        }
                      },
                      child: ShadInputFormField(
                        controller: lahirTemp,
                        label: const Text('Date of Birth'),
                        placeholder: const Text('24-5-2003'),
                        readOnly: true,
                        enabled: false,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      ShadSelect<bool>(
                        initialValue: user?.status,
                        placeholder: const Text('Select a Status'),
                        options: [
                          ...statusData.entries.map(
                            (e) => ShadOption(
                              value: e.key,
                              child: Text(e.value),
                            ),
                          ),
                        ],
                        onChanged: (bool? value) => status.value = value!,
                        selectedOptionBuilder: (context, value) =>
                            Text(statusData[value]!),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                  Column(
                    children: [
                      ShadSelect<String>(
                        initialValue: user?.keterangan,
                        placeholder: const Text('Select a Role'),
                        options: [
                          ...roleData.entries.map(
                            (e) => ShadOption(
                              value: e.key,
                              child: Text(e.value),
                            ),
                          ),
                        ],
                        onChanged: (String? value) => role.value = value!,
                        selectedOptionBuilder: (context, value) =>
                            Text(roleData[value]!),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (user != null)
                      ShadButton.destructive(
                        text: const Text('Delete'),
                        onPressed: () {
                          Database().deleteUser(user.id!).whenComplete(() {
                            userController.users.refresh();
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ShadButton(
                      text: const Text('Save changes'),
                      onPressed: () {
                        if (editingName.text.isEmpty) {
                          return;
                        } else {
                          if (user != null) {
                            final updateUser = UserModel(
                              id: user.id,
                              nama: editingName.text,
                              dob: lahir.value,
                              status: status.value,
                              keterangan: role.value,
                              masuk: DateTime.now(),
                              createdAt: user.createdAt,
                            );
                            Database().updateUser(updateUser).whenComplete(() {
                              Future.delayed(Durations.short1).then((_) {
                                userController.users.refresh();
                                context.pop();
                              });
                            });
                          } else {
                            final newUser = UserModel(
                              nama: editingName.text,
                              dob: lahir.value,
                              status: status.value,
                              keterangan: role.value,
                              masuk: DateTime.now(),
                              createdAt: DateTime.now(),
                            );

                            Database().addNewUser(newUser).whenComplete(() {
                              userController.users.refresh();
                              context.pop();
                            });
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
