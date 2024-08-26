import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:due_kasir/controller/due_payment_controller.dart';
import 'package:due_kasir/main.dart';
import 'package:due_kasir/model/due_payment_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class DuePaymentForm extends HookWidget {
  DuePaymentForm({super.key});
  final statusData = {'dept': 'Dept', 'paid': 'Paid'};
  @override
  Widget build(context) {
    final duePaymentFormKey = useMemoized(GlobalKey<FormState>.new);
    final item = duePaymentController.paymentSelected.watch(context);
    final editingName = useTextEditingController(text: item?.name ?? '');
    final editingInvoice = useTextEditingController(text: item?.invoice ?? '');
    final editingItemName =
        useTextEditingController(text: item?.itemName ?? '');
    final editingAmount =
        useTextEditingController(text: (item?.amount ?? '').toString());
    final editingNote =
        useTextEditingController(text: (item?.note ?? '').toString());

    final stock = useState(item?.itemAmount ?? 0);
    final hargaJual = useState(0.0);
    final hargaJualDiscount = useState(0.0);
    final status = useState(item?.status ?? 'dept');
    final dateIn = useState(item?.dateIn ?? DateTime.now());
    final dueDate =
        useState(item?.dueDate ?? DateTime.now().add(const Duration(days: 3)));

    useListenable(hargaJual);
    useListenable(editingName);
    useListenable(editingInvoice);
    useListenable(editingItemName);
    useListenable(hargaJualDiscount);

    final isConnected = isDeviceConnected.watch(context);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: duePaymentFormKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.circle,
                        color: isConnected ? Colors.green : null),
                    ShadButton.ghost(
                      child: const Text('Close'),
                      onPressed: () {
                        duePaymentController.paymentSelected.value = null;
                        context.pop();
                      },
                    ),
                  ],
                ),
                ShadInputFormField(
                  controller: editingName,
                  validator: (val) =>
                      val.isEmpty == true ? 'Name is required' : null,
                  label: const Text('Nama PT'),
                  placeholder: const Text('PT Keluarga Langit'),
                ),
                ShadInputFormField(
                  controller: editingInvoice,
                  label: const Text('No Faktur (Jika Ada)'),
                  placeholder: const Text('ex. KLI12960'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ShadInputFormField(
                        controller: editingItemName,
                        validator: (val) => val.isEmpty == true
                            ? 'Nama Barang is required'
                            : null,
                        label: const Text('Nama Barang'),
                        placeholder: const Text('ex. Bambi'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 25),
                        child: ShadSelect<int>(
                          placeholder: const Text('Jumlah Barang'),
                          initialValue: item?.itemAmount,
                          options: List.generate(
                              200,
                              (val) =>
                                  ShadOption(value: val, child: Text('$val'))),
                          onChanged: (val) => stock.value = val,
                          selectedOptionBuilder: (context, value) {
                            stock.value = value;
                            return Text('$value');
                          },
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ShadInputFormField(
                        controller: editingAmount,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        label: const Text('Total Tagihan'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Jatuh Tempo'),
                        const SizedBox(height: 10),
                        ShadSelect<String>(
                          placeholder: const Text('Status'),
                          initialValue: item?.status,
                          options: [
                            ...statusData.entries.map(
                              (e) => ShadOption(
                                value: e.key,
                                child: Text(e.value),
                              ),
                            ),
                          ],
                          onChanged: (String? value) => status.value = value!,
                          selectedOptionBuilder: (context, value) =>
                              Text(statusData[value]!),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Barang Masuk'),
                        const SizedBox(height: 10),
                        ShadButton.outline(
                            child: Text(dateWithoutTime.format(dateIn.value)),
                            onPressed: () async {
                              var results = await showCalendarDatePicker2Dialog(
                                context: context,
                                config:
                                    CalendarDatePicker2WithActionButtonsConfig(
                                  calendarType: CalendarDatePicker2Type.single,
                                ),
                                dialogSize: const Size(325, 400),
                                value: [dateIn.value],
                                borderRadius: BorderRadius.circular(15),
                              );
                              if (results != null) {
                                dateIn.value = results.first!;
                              }
                            }),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Jatuh Tempo'),
                        const SizedBox(height: 10),
                        ShadButton.outline(
                            child: Text(dateWithoutTime.format(dueDate.value)),
                            onPressed: () async {
                              var results = await showCalendarDatePicker2Dialog(
                                context: context,
                                config:
                                    CalendarDatePicker2WithActionButtonsConfig(
                                  calendarType: CalendarDatePicker2Type.single,
                                ),
                                dialogSize: const Size(325, 400),
                                value: [dueDate.value],
                                borderRadius: BorderRadius.circular(15),
                              );
                              if (results != null) {
                                dueDate.value = results.first!;
                              }
                            }),
                      ],
                    ),
                  ],
                ),
                ShadInputFormField(
                  controller: editingNote,
                  label: const Text('Note'),
                  maxLines: 3,
                  placeholder: const Text('ex. status titip barang'),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item != null)
                        ShadButton.destructive(
                          child: const Text('Delete'),
                          onPressed: () {
                            Database()
                                .deleteInventory(item.id!)
                                .whenComplete(() {
                              duePaymentController.payments.refresh();
                              if (context.mounted) Navigator.pop(context);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.blue,
                                    content: const Text(
                                        'Please refresh data to see changes'),
                                    action: SnackBarAction(
                                      label: 'Refresh',
                                      onPressed: () async {},
                                    ),
                                  ),
                                );
                              }
                            });
                          },
                        ),
                      ShadButton(
                        child: const Text('Save changes'),
                        onPressed: () {
                          if (!duePaymentFormKey.currentState!.validate()) {
                            return;
                          } else {
                            if (item != null) {
                              final updateitem = DuePaymentModel(
                                id: item.id,
                                name: editingName.text.replaceAll(',', ' '),
                                invoice: editingInvoice.text,
                                itemName: editingItemName.text,
                                itemAmount: stock.value,
                                amount: int.parse(editingAmount.text),
                                status: status.value,
                                dateIn: dateIn.value,
                                dueDate: dueDate.value,
                                note: editingNote.text,
                                createdAt: item.createdAt,
                              );

                              Database()
                                  .updateDuePayment(updateitem)
                                  .whenComplete(() {
                                Future.delayed(Durations.short1).then((_) {
                                  if (context.mounted) context.pop();
                                  duePaymentController.payments.refresh();
                                  duePaymentController.paymentSelected.value =
                                      null;
                                });
                              });
                            } else {
                              final newItem = DuePaymentModel(
                                id: DateTime.now().microsecondsSinceEpoch,
                                name: editingName.text.replaceAll(',', ' '),
                                invoice: editingInvoice.text,
                                itemName: editingItemName.text,
                                itemAmount: stock.value,
                                amount: int.parse(editingAmount.text),
                                status: status.value,
                                dateIn: dateIn.value,
                                dueDate: dueDate.value,
                                note: editingNote.text,
                                createdAt: DateTime.now(),
                              );

                              Database()
                                  .addDuePayment(newItem)
                                  .whenComplete(() {
                                duePaymentController.payments.refresh();
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
    );
  }
}
