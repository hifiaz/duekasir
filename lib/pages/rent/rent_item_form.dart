import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/controller/rent_controller.dart';
import 'package:due_kasir/main.dart';
import 'package:due_kasir/model/rent_item_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class RentItemForm extends HookWidget {
  RentItemForm({super.key});
  final statusData = {true: 'Active', false: 'Non Active'};
  @override
  Widget build(context) {
    final rentItemFormKey = useMemoized(GlobalKey<FormState>.new);
    final item = rentController.rentItemSelected.watch(context);
    final editingName = useTextEditingController(text: item?.name ?? '');
    final editingCode = useTextEditingController(text: item?.code ?? '');
    final rentThreeDay =
        useTextEditingController(text: (item?.rentThreeDay ?? '').toString());
    final rentOneWeek =
        useTextEditingController(text: (item?.rentOneWeek ?? '').toString());
    final rentOneMonth =
        useTextEditingController(text: (item?.rentOneMonth ?? '').toString());
    final note = useTextEditingController(text: item?.note ?? '');
    final stock = useState(item?.jumlahBarang ?? 0);

    useListenable(editingName);
    useListenable(editingCode);
    useListenable(rentThreeDay);
    useListenable(rentOneWeek);
    useListenable(rentOneMonth);

    final isConnected = isDeviceConnected.watch(context);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: rentItemFormKey,
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
                        inventoryController.inventorySelected.value = null;
                        context.pop();
                      },
                    ),
                  ],
                ),
                ShadInputFormField(
                  controller: editingName,
                  validator: (val) =>
                      val.isEmpty == true ? 'Name is required' : null,
                  label: const Text('Nama Barang'),
                  placeholder: const Text('Baju'),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ShadInputFormField(
                        controller: editingCode,
                        label: const Text('Code'),
                        placeholder: const Text('HP08123'),
                      ),
                    ),
                    BarcodeKeyboardListener(
                      bufferDuration: const Duration(milliseconds: 200),
                      onBarcodeScanned: (barcode) async {
                        editingCode.text = barcode.replaceAll('½', '-');
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(bottom: 5.0),
                        child: ShadButton.ghost(
                          icon: Icon(Icons.barcode_reader),
                        ),
                      ),
                    ),
                    if (PlatformExtension.isMobile)
                      ShadButton.ghost(
                        icon: const Icon(Icons.camera_alt),
                        onPressed: () async {
                          var res = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const SimpleBarcodeScannerPage(),
                              ));
                          editingCode.text = res;
                        },
                      ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: ShadSelect<int>(
                          placeholder: const Text('Select a Stock'),
                          initialValue: item?.jumlahBarang,
                          options: List.generate(
                              10,
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
                  children: [
                    Expanded(
                      child: ShadInputFormField(
                        controller: rentThreeDay,
                        validator: (val) =>
                            val.isEmpty == true ? 'Amount is required' : null,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        label: const Text('Rent 3 Days'),
                        placeholder: const Text('ex. 30000'),
                      ),
                    ),
                    Expanded(
                      child: ShadInputFormField(
                        controller: rentOneWeek,
                        validator: (val) =>
                            val.isEmpty == true ? 'Amount is required' : null,
                        label: const Text('Rent One Week'),
                        placeholder: const Text('ex. 80000'),
                      ),
                    ),
                    Expanded(
                      child: ShadInputFormField(
                        controller: rentOneMonth,
                        validator: (val) =>
                            val.isEmpty == true ? 'Amount is required' : null,
                        label: const Text('Rent One Month'),
                        placeholder: const Text('ex. 1200000'),
                      ),
                    ),
                  ],
                ),
                const Text('Catatan'),
                ShadInput(
                  controller: note,
                  maxLines: 3,
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
                                .deleteRentItem(item.id!)
                                .whenComplete(() {
                              rentController.rentItems.refresh();
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
                          if (!rentItemFormKey.currentState!.validate()) {
                            return;
                          } else {
                            if (item != null) {
                              final updateitem = RentItemModel(
                                id: item.id,
                                name: editingName.text.replaceAll(',', ' '),
                                code: editingCode.text,
                                rentThreeDay: int.parse(rentThreeDay.text),
                                rentOneWeek: int.parse(rentOneWeek.text),
                                rentOneMonth: int.parse(rentOneMonth.text),
                                jumlahBarang: stock.value,
                                note: note.text,
                                createdAt: item.createdAt ?? DateTime.now(),
                              );

                              Database()
                                  .updateRentItem(updateitem)
                                  .whenComplete(() {
                                Future.delayed(Durations.short1).then((_) {
                                  if (context.mounted) context.pop();
                                  rentController.rentItems.refresh();
                                  rentController.rentItemSelected.value = null;
                                });
                              });
                            } else {
                              final newItem = RentItemModel(
                                id: DateTime.now().microsecondsSinceEpoch,
                                name: editingName.text.replaceAll(',', ' '),
                                code: editingCode.text,
                                rentThreeDay: int.parse(rentThreeDay.text),
                                rentOneWeek: int.parse(rentOneWeek.text),
                                rentOneMonth: int.parse(rentOneMonth.text),
                                jumlahBarang: stock.value,
                                createdAt: DateTime.now(),
                                note: note.text,
                              );

                              Database().addRentItem(newItem).whenComplete(() {
                                rentController.rentItems.refresh();
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
