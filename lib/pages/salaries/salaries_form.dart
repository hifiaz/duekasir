import 'package:due_kasir/controller/user_controller.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class SalariesForm extends StatefulWidget {
  const SalariesForm({super.key});

  @override
  State<SalariesForm> createState() => _SalariesFormState();
}

class _SalariesFormState extends State<SalariesForm> {
  final salariesFormKey = GlobalKey<ShadFormState>();
  final status = ['Draf', 'Paid'];
  @override
  Widget build(BuildContext context) {
    final users = userController.users.watch(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ShadForm(
              key: salariesFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      if (users.hasValue && users.value?.isNotEmpty == true)
                        ShadSelectFormField<UserModel>(
                          id: 'user',
                          minWidth: 350,
                          initialValue: null,
                          label: const Text('User'),
                          onChanged: (v) {},
                          options: users.value!
                              .map((u) =>
                                  ShadOption(value: u, child: Text(u.nama)))
                              .toList(),
                          selectedOptionBuilder: (context, value) =>
                              Text(value.nama),
                          placeholder: const Text('Select a user to display'),
                          validator: (v) {
                            if (v == null) {
                              return 'Please select an user to display';
                            }
                            return null;
                          },
                        ),
                      ShadSelectFormField<String>(
                        id: 'status',
                        initialValue: null,
                        label: const Text('Status'),
                        onChanged: (v) {},
                        options: status
                            .map((u) => ShadOption(value: u, child: Text(u)))
                            .toList(),
                        selectedOptionBuilder: (context, value) => Text(value),
                        placeholder: const Text('Select a status to display'),
                        validator: (v) {
                          if (v == null) {
                            return 'Please select an status to display';
                          }
                          return null;
                        },
                      ),
                      Expanded(
                        child: ShadInputFormField(
                          id: 'periode',
                          label: const Text('Periode'),
                          placeholder: const Text('Ex: Mei 2024'),
                          validator: (v) {
                            if (v.length < 2) {
                              return 'Must be at least 2 characters.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ShadButton(
                    text: const Text('Submit'),
                    onPressed: () {
                      if (salariesFormKey.currentState!.saveAndValidate()) {
                        print(
                            'validation succeeded with ${salariesFormKey.currentState!.value}');
                      } else {
                        print('validation failed');
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
