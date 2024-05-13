import 'dart:io';

import 'package:due_kasir/controller/presence_controller.dart';
import 'package:due_kasir/controller/user_controller.dart';
import 'package:due_kasir/enum/absense_enum.dart';
import 'package:due_kasir/model/presence_model.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class PresenceForm extends StatefulHookWidget {
  final ShadSheetSide? side;
  const PresenceForm({super.key, this.side});

  @override
  State<PresenceForm> createState() => _PresenceFormState();
}

class _PresenceFormState extends State<PresenceForm> {
  UserModel? userSelected;
  AbsenseEnum? status;
  @override
  Widget build(BuildContext context) {
    final formPresenseKey = useMemoized(GlobalKey<FormState>.new);
    final users = userController.users.watch(context);
    final note = useTextEditingController();

    return ShadSheet(
      title: const Text('Present'),
      description: const Text(
          "Make sure you have choise your profile and check in or out"),
      content: Form(
        key: formPresenseKey,
        child: SizedBox(
          width: widget.side == ShadSheetSide.bottom ||
                  widget.side == ShadSheetSide.top
              ? MediaQuery.sizeOf(context).width
              : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (users.hasValue)
                  DataTable(
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Detail')),
                    ],
                    rows: users.value!
                        .map((user) => DataRow(cells: [
                              DataCell(Text(user.id.toString())),
                              DataCell(Text(user.nama)),
                              DataCell(ShadButton.outline(
                                text: Text(user == userSelected
                                    ? 'Selected'
                                    : 'Select'),
                                onPressed: () {
                                  setState(() {
                                    userSelected = user;
                                  });
                                },
                              )),
                            ]))
                        .toList(),
                  ),
                ShadRadioGroupFormField<AbsenseEnum>(
                  id: 'absense',
                  label: const Text('Status'),
                  onChanged: (val) {
                    setState(() => status = val);
                  },
                  items: AbsenseEnum.values.map(
                    (e) => ShadRadio(
                      value: e,
                      label: Text(e.message),
                    ),
                  ),
                  validator: (v) {
                    if (v == null) {
                      return 'You need to select a status type.';
                    }
                    return null;
                  },
                ),
                const Text('Catatan'),
                ShadInput(
                  controller: note,
                  placeholder: const Text('Telat karena...'),
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        ShadButton(
            onPressed: () async {
              if (formPresenseKey.currentState!.validate() &&
                  userSelected != null) {
                if (Platform.isWindows) {
                  // final XFile image =
                  //     await CameraPlatform.instance.takePicture(_cameraId);

                  // final Directory duplicateFilePath =
                  //     await getApplicationDocumentsDirectory();

                  // final fileName = basename(image.path);
                  // await image.saveTo('$duplicateFilePath/$fileName');
                  Database().addPresense(PresenceModel(
                      user: userSelected!.id,
                      status: status!.name,
                      createdAt: DateTime.now()));
                } else {
                  Database()
                      .addPresense(PresenceModel(
                          user: userSelected!.id,
                          status: status!.name,
                          createdAt: DateTime.now()))
                      .whenComplete(() {
                    presenceController.presence.refresh();
                    context.pop();
                  });
                }
              }
            },
            text: const Text('Save')),
      ],
    );
  }
}
