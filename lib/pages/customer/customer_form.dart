import 'package:due_kasir/controller/customer_controller.dart';
import 'package:due_kasir/model/customer_model.dart';
import 'package:due_kasir/service/supabase_service.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class CustomerForm extends HookWidget {
  CustomerForm({super.key});

  final statusData = {true: 'Active', false: 'Non Active'};
  @override
  Widget build(BuildContext context) {
    final customerFormKey = useMemoized(GlobalKey<FormState>.new);
    final customer = customerController.customerSelected.watch(context);
    final editingName = useTextEditingController(text: customer?.nama ?? '');
    final editingPhone =
        useTextEditingController(text: (customer?.phone ?? '').toString());
    final editingKtp = useTextEditingController(text: customer?.ktp ?? '');
    final editingKeterangan =
        useTextEditingController(text: customer?.keterangan ?? '');
    final lahirTemp = useTextEditingController(
        text: customer?.dob != null
            ? dateWithoutTime
                .format(DateTime.tryParse(customer!.dob!) ?? DateTime.now())
            : '');
    final lahir = useState(
        DateTime.tryParse(customer?.dob ?? DateTime.now().toString()) ??
            DateTime.now());
    final status = useState(customer?.status ?? true);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: customerFormKey,
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8))),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: ShadButton.ghost(
                        child: const Text('Close'),
                        onPressed: () => context.pop()),
                  ),
                  ShadInputFormField(
                    controller: editingName,
                    validator: (val) =>
                        val.isEmpty == true ? 'Name is required' : null,
                    label: const Text('Nama'),
                    placeholder: const Text('Jhon Doe'),
                  ),
                  ShadInputFormField(
                    controller: editingPhone,
                    label: const Text('Phone'),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    placeholder: const Text('ex: 085648129312'),
                  ),
                  ShadInputFormField(
                    controller: editingKtp,
                    label: const Text('Identity (KTP)'),
                    placeholder: const Text('67128912038123'),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate:
                                    DateTime.tryParse(customer!.dob!) ??
                                        DateTime.now(),
                                firstDate: DateTime(1950),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100));

                            if (pickedDate != null) {
                              lahirTemp.text =
                                  dateWithoutTime.format(lahir.value);
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
                            initialValue: customer?.status,
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
                    ],
                  ),
                  ShadInputFormField(
                    controller: editingKeterangan,
                    maxLines: 3,
                    label: const Text('Description'),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (customer != null)
                          ShadButton.destructive(
                            child: const Text('Delete'),
                            onPressed: () {
                              SupabaseHelper()
                                  .removeCustomer(customer.id)
                                  .whenComplete(() async {
                                await customerController.customer.refresh();
                                if (context.mounted) Navigator.pop(context);
                              });
                            },
                          ),
                        ShadButton(
                          child: const Text('Save changes'),
                          onPressed: () {
                            if (customerFormKey.currentState!.validate()) {
                              if (customer != null) {
                                final updateCustomer = {
                                  'id': customer.id,
                                  'nama': editingName.text,
                                  'dob': lahir.value,
                                  'ktp': editingKtp.text,
                                  'status': status.value,
                                  'phone': editingPhone.text,
                                  'keterangan': editingKeterangan.text,
                                  'createdAt': customer.createdAt,
                                };
                                SupabaseHelper()
                                    .updateCustomer(
                                        Customer.fromJson(updateCustomer))
                                    .whenComplete(() {
                                  Future.delayed(Durations.short1).then((_) {
                                    customerController.customer.refresh();
                                    if (context.mounted) context.pop();
                                  });
                                });
                              } else {
                                final newCustomer = {
                                  'id': DateTime.now().microsecondsSinceEpoch,
                                  'nama': editingName.text,
                                  'dob': lahir.value,
                                  'ktp': editingKtp.text,
                                  'status': status.value,
                                  'phone': editingPhone.text,
                                  'keterangan': editingKeterangan.text,
                                  'masuk': DateTime.now(),
                                  'createdAt': DateTime.now(),
                                };

                                SupabaseHelper()
                                    .addCustomer(newCustomer)
                                    .whenComplete(() {
                                  customerController.customer.refresh();
                                  if (context.mounted) context.pop();
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
        ),
      ),
    );
  }
}
