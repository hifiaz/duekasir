import 'package:due_kasir/controller/customer_controller.dart';
import 'package:due_kasir/model/pembeli_model.dart';
import 'package:due_kasir/service/database.dart';
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
            ? dateWithoutTime.format(customer!.dob!)
            : '');
    final lahir = useState(customer?.dob ?? DateTime.now());
    final status = useState(customer?.status ?? true);
    return Scaffold(
      body: Form(
        key: customerFormKey,
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), topRight: Radius.circular(8))),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: ShadButton.ghost(
                      text: const Text('Close'),
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
                              initialDate: customer?.dob ?? DateTime.now(),
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
                          text: const Text('Delete'),
                          onPressed: () {
                            Database()
                                .deleteCustomer(customer.id)
                                .whenComplete(() {
                              Database().searchCustomers().then((val) {
                                customerController.customer.clear();
                                customerController.customer.addAll(val);
                              });
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ShadButton(
                        text: const Text('Save changes'),
                        onPressed: () {
                          if (customerFormKey.currentState!.validate()) {
                            if (customer != null) {
                              final updateCustomer = PembeliModel()
                                ..id = customer.id
                                ..nama = editingName.text
                                ..dob = lahir.value
                                ..ktp = editingKtp.text
                                ..status = status.value
                                ..phone = editingPhone.text
                                ..keterangan = editingKeterangan.text;
                              Database()
                                  .updateCustomer(updateCustomer)
                                  .whenComplete(() {
                                Future.delayed(Durations.short1).then((_) {
                                  Database().searchCustomers().then((val) {
                                    customerController.customer.clear();
                                    customerController.customer.addAll(val);
                                  });
                                  context.pop();
                                });
                              });
                            } else {
                              final newCustomer = PembeliModel()
                                ..nama = editingName.text
                                ..dob = lahir.value
                                ..ktp = editingKtp.text
                                ..status = status.value
                                ..phone = editingPhone.text
                                ..keterangan = editingKeterangan.text
                                ..masuk = DateTime.now();
                              Database()
                                  .addNewCustomer(newCustomer)
                                  .whenComplete(() {
                                Database().searchCustomers().then((val) {
                                  customerController.customer.clear();
                                  customerController.customer.addAll(val);
                                });
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
      ),
    );
    // final editingName = useTextEditingController();
    // final editingKTP = useTextEditingController();
    // final editingKeterangan = useTextEditingController();
    // final lahirTemp = useTextEditingController();
    // final lahir = useState(DateTime.now());
    // final status = useState(true);
    // return SingleChildScrollView(
    //   child: Container(
    //     decoration: const BoxDecoration(
    //         borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(8), topRight: Radius.circular(8))),
    //     padding: const EdgeInsets.all(20),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       mainAxisSize: MainAxisSize.min,
    //       children: <Widget>[
    //         Text(
    //           'New Customer',
    //           style: Theme.of(context).textTheme.headlineMedium,
    //         ),
    //         const SizedBox(height: 10),
    //         TextFormField(
    //           controller: editingName,
    //           validator: (val) =>
    //               val?.isEmpty == true ? 'Nama wajib di isi' : null,
    //           decoration: const InputDecoration(
    //             hintText: 'Nama',
    //             label: Text('Nama'),
    //           ),
    //         ),
    //         const SizedBox(height: 10),
    //         TextFormField(
    //           controller: editingKTP,
    //           decoration: const InputDecoration(
    //             hintText: 'No KTP',
    //             label: Text('No KTP'),
    //           ),
    //         ),
    //         const SizedBox(height: 10),
    //         TextField(
    //           controller: lahirTemp,
    //           decoration: const InputDecoration(
    //             suffixIcon: Icon(Icons.calendar_today),
    //             labelText: "Masukkan Tanggal",
    //           ),
    //           readOnly: true,
    //           onTap: () async {
    //             DateTime? pickedDate = await showDatePicker(
    //                 context: context,
    //                 initialDate: DateTime.now(),
    //                 firstDate: DateTime(1950),
    //                 //DateTime.now() - not to allow to choose before today.
    //                 lastDate: DateTime(2100));

    //             if (pickedDate != null) {
    //               lahirTemp.text = dateWithoutTime.format(lahir.value);
    //               lahir.value = pickedDate;
    //             }
    //           },
    //         ),
    //         const SizedBox(height: 10),
    //         const Text('Status'),
    //         DropdownButton<bool>(
    //           isExpanded: true,
    //           value: status.value,
    //           onChanged: (bool? value) => status.value = value!,
    //           items: const [
    //             DropdownMenuItem<bool>(
    //               value: true,
    //               child: Text('Active'),
    //             ),
    //             DropdownMenuItem<bool>(
    //               value: false,
    //               child: Text('Non Active'),
    //             )
    //           ],
    //         ),
    //         const SizedBox(height: 10),
    //         TextFormField(
    //           controller: editingKeterangan,
    //           maxLines: 3,
    //           decoration: const InputDecoration(
    //             hintText: 'Keterangan',
    //             label: Text('Keterangan'),
    //           ),
    //         ),
    //         const SizedBox(height: 10),
    //         SizedBox(
    //           width: double.infinity,
    //           child: ElevatedButton(
    //             style: active,
    //             child: const Text('Save'),
    //             onPressed: () {
    //               final newUser = PembeliModel()
    //                 ..nama = editingName.text
    //                 ..dob = lahir.value
    //                 ..ktp = editingKTP.text
    //                 ..status = status.value
    //                 ..keterangan = editingKeterangan.text
    //                 ..masuk = DateTime.now();

    //               Database().addNewCustomer(newUser).whenComplete(() {
    //                 customerController.customer.refresh();
    //                 Navigator.pop(context);
    //               });
    //             },
    //           ),
    //         ),
    //         const SizedBox(height: 20),
    //       ],
    //     ),
    //   ),
    // );
  }
}
