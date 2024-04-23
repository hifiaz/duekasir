import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/model/item_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class InventoryForm extends HookWidget {
  InventoryForm({super.key});

  final statusData = {true: 'Active', false: 'Non Active'};
  final _inventoryFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final item = inventoryController.inventorySelected.watch(context);
    final editingName = useTextEditingController(text: item?.nama ?? '');
    final editingCode = useTextEditingController(text: item?.code ?? '');
    final editingUkuran = useTextEditingController(text: item?.ukuran ?? '');
    final editingHargaDasar =
        useTextEditingController(text: (item?.hargaDasar ?? '0').toString());
    final editingHargaJualPersen = useTextEditingController(
        text: (item?.hargaJualPersen?.toInt() ?? '20').toString());
    final stock = useState(item?.jumlahBarang ?? 0);
    final hargaJual = useState(0.0);
    useListenableSelector(editingHargaDasar, () {
      if (editingHargaDasar.text.isNotEmpty) {
        hargaJual.value = int.parse(
                editingHargaDasar.text.isEmpty ? '0' : editingHargaDasar.text) +
            int.parse(editingHargaDasar.text.isEmpty
                    ? '0'
                    : editingHargaDasar.text) *
                ((int.parse(editingHargaJualPersen.text.isEmpty
                        ? '0'
                        : editingHargaJualPersen.text)) /
                    100);
      }
    });
    useListenable(editingHargaJualPersen);
    useListenable(hargaJual);
    useListenable(editingName);
    useListenable(editingCode);
    useListenable(editingUkuran);
    return Scaffold(
      body: Form(
        key: _inventoryFormKey,
        child: SingleChildScrollView(
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
                    onPressed: () {
                      inventoryController.inventorySelected.value = null;
                      context.pop();
                    },
                  ),
                ),
                ShadInputFormField(
                  controller: editingName,
                  validator: (val) =>
                      val.isEmpty == true ? 'Name is required' : null,
                  label: const Text('Nama Barang'),
                  placeholder: const Text('Baju'),
                ),
                ShadInputFormField(
                  controller: editingCode,
                  label: const Text('Code'),
                  placeholder: const Text('HP08123'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ShadInputFormField(
                        controller: editingUkuran,
                        validator: (val) =>
                            val.isEmpty == true ? 'Ukuran is required' : null,
                        label: const Text('Ukuran Barang'),
                        placeholder: const Text('ex. S/M/L 50ml/100ml'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 25),
                        child: ShadSelect<int>(
                          placeholder: const Text('Select a Stock'),
                          initialValue: item?.jumlahBarang,
                          options: List.generate(
                              1000,
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
                        controller: editingHargaDasar,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        label: const Text('Harga Dasar'),
                      ),
                    ),
                    Expanded(
                      child: ShadInputFormField(
                        controller: editingHargaJualPersen,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        label: const Text('Harga Jual Persen'),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Harga Jual'),
                          const SizedBox(height: 20),
                          Text('${hargaJual.value.toInt()}'),
                          const SizedBox(height: 15),
                        ],
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (item != null)
                        ShadButton.destructive(
                          text: const Text('Delete'),
                          onPressed: () {
                            Database()
                                .deleteInventory(item.id)
                                .whenComplete(() {
                              Navigator.pop(context);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.blue,
                                    content: const Text(
                                        'Please refresh data to see changes'),
                                    action: SnackBarAction(
                                      label: 'Refresh',
                                      onPressed: () async {
                                        Database()
                                            .searchInventorys('')
                                            .then((val) {
                                          inventoryController.inventorySearch
                                              .clear();
                                          inventoryController.inventorySearch
                                              .addAll(val);
                                        });
                                      },
                                    ),
                                  ),
                                );
                              }
                            });
                          },
                        ),
                      ShadButton(
                        text: const Text('Save changes'),
                        onPressed: () {
                          if (!_inventoryFormKey.currentState!.validate()) {
                            return;
                          } else {
                            if (item != null) {
                              final updateitem = ItemModel()
                                ..id = item.id
                                ..nama = editingName.text
                                ..code = editingCode.text
                                ..quantity = 1
                                ..hargaJual = hargaJual.value.toInt()
                                ..ukuran = editingUkuran.text
                                ..isHargaJualPersen = true
                                ..hargaJualPersen =
                                    double.parse(editingHargaJualPersen.text)
                                ..hargaDasar = int.parse(editingHargaDasar.text)
                                ..jumlahBarang = stock.value;
                              Database()
                                  .updateInventory(updateitem)
                                  .whenComplete(() {
                                Future.delayed(Durations.short1).then((_) {
                                  context.pop();
                                  inventoryController.inventory.refresh();
                                  inventoryController.inventorySelected.value =
                                      null;
                                });
                              });
                            } else {
                              final newItem = ItemModel()
                                ..nama = editingName.text
                                ..code = editingCode.text
                                ..quantity = 1
                                ..hargaJual = hargaJual.value.toInt()
                                ..ukuran = editingUkuran.text
                                ..isHargaJualPersen = true
                                ..hargaJualPersen =
                                    double.parse(editingHargaJualPersen.text)
                                ..hargaDasar = int.parse(editingHargaDasar.text)
                                ..jumlahBarang = stock.value;
                              Database().addInventory(newItem).whenComplete(() {
                                inventoryController.inventory.refresh();
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
  }
}
