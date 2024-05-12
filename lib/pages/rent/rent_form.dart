import 'package:due_kasir/controller/inventory_controller.dart';
import 'package:due_kasir/controller/rent_controller.dart';
import 'package:due_kasir/main.dart';
import 'package:due_kasir/model/rent_item_model.dart';
import 'package:due_kasir/model/rent_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class RentForm extends HookWidget {
  final RentItemModel item;
  final RentModel? rent;
  const RentForm({super.key, required this.item, this.rent});
  @override
  Widget build(context) {
    final rentFormKey = useMemoized(GlobalKey<FormState>.new);
    final editingName = useTextEditingController(text: rent?.name ?? '');
    final editingNote = useTextEditingController(text: rent?.note ?? '');
    final days = useState(rent?.howManyDay ?? 3);
    final amount = useState(rent?.amount ?? 0);
    final identity = useState(rent?.identity ?? false);
    final people = useState(rent?.picture ?? false);
    final pinalty = useState(0);

    useListenable(editingName);
    useListenable(editingNote);
    useState(() {
      if (rent != null) {
        if (!DateTime.now().difference(rent!.rentDate).inDays.isNegative) {
          pinalty.value =
              8000 * DateTime.now().difference(rent!.rentDate).inDays;
        }
      }
    });

    final isConnected = isDeviceConnected.watch(context);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: rentFormKey,
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
                      text: const Text('Close'),
                      onPressed: () {
                        inventoryController.inventorySelected.value = null;
                        context.pop();
                      },
                    ),
                  ],
                ),
                ShadInputFormField(
                  initialValue: item.name,
                  readOnly: true,
                  validator: (val) =>
                      val.isEmpty == true ? 'Name is required' : null,
                  label: const Text('Nama Barang'),
                  placeholder: const Text('Baju'),
                ),
                ShadInputFormField(
                  controller: editingName,
                  label: const Text('Peminjam'),
                  validator: (val) =>
                      val.isEmpty == true ? 'Customer is required' : null,
                  placeholder: const Text('ex: Jhon Mayer'),
                ),
                ShadRadioGroup<int>(
                  onChanged: (val) {
                    if (val == item.rentThreeDay) {
                      days.value = 3;
                    } else if (val == item.rentOneWeek) {
                      days.value = 7;
                    } else {
                      days.value = 30;
                    }
                    amount.value = val!;
                  },
                  initialValue: amount.value,
                  items: [
                    ShadRadio(
                      label: const Text('Rent for 3 Days'),
                      value: item.rentThreeDay,
                    ),
                    ShadRadio(
                      label: const Text('Rent for One Week'),
                      value: item.rentOneWeek,
                    ),
                    ShadRadio(
                      label: const Text('Rent for 1 Month'),
                      value: item.rentOneMonth,
                    ),
                  ],
                ),
                const Text('Pinalti keterlambatan Rp. 8.000,- perhari'),
                const SizedBox(height: 20),
                ShadCheckbox(
                  value: identity.value,
                  onChanged: (v) => identity.value = v,
                  label: const Text('Take photo Identity'),
                  sublabel: const Text(
                    'Have you take picture of identity customer?',
                  ),
                ),
                ShadCheckbox(
                  value: people.value,
                  onChanged: (v) => people.value = v,
                  label: const Text('Take photo People'),
                  sublabel: const Text(
                    'Have you take picture of customer and rent item?',
                  ),
                ),
                ShadInputFormField(
                  controller: editingNote,
                  label: const Text('Note'),
                  maxLines: 3,
                  placeholder: const Text('ex: Barang Kondisi Bagus'),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          const Text('Harga'),
                          const SizedBox(height: 20),
                          Text(currency.format(amount.value)),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          const Text('Pinalty'),
                          const SizedBox(height: 20),
                          if (rent != null)
                            Text(currency.format(pinalty.value))
                          else
                            const Text('-'),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 5),
                          const Text('Harga Total'),
                          const SizedBox(height: 20),
                          Text(currency.format(amount.value + pinalty.value)),
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
                      if (rent != null)
                        ShadButton.outline(
                          text: const Text('Update'),
                          onPressed: () {
                            if (!rentFormKey.currentState!.validate()) {
                              return;
                            } else {
                              if (rent != null) {
                                final updateitem = RentModel(
                                  name: editingName.text,
                                  id: rent!.id,
                                  item: item.id!,
                                  amount: amount.value,
                                  identity: identity.value,
                                  picture: people.value,
                                  paid: false,
                                  note: editingNote.text,
                                  rentDate: rent!.rentDate,
                                  howManyDay: rent!.howManyDay,
                                  updatedAt: DateTime.now(),
                                  createdAt: rent!.createdAt,
                                );

                                Database()
                                    .updateRent(updateitem)
                                    .whenComplete(() {
                                  Future.delayed(Durations.short1).then((_) {
                                    context.pop();
                                    rentController.rents.refresh();
                                  });
                                });
                              }
                            }
                          },
                        ),
                      ShadButton(
                        text: Text(
                            rent != null ? 'Customer Pay' : 'Save changes'),
                        onPressed: () {
                          if (!rentFormKey.currentState!.validate()) {
                            return;
                          } else {
                            if (rent != null) {
                              final updateitem = RentModel(
                                name: editingName.text,
                                id: rent!.id,
                                item: item.id!,
                                amount: amount.value,
                                identity: identity.value,
                                picture: people.value,
                                paid: true,
                                note: editingNote.text,
                                rentDate: rent!.rentDate,
                                howManyDay: rent!.howManyDay,
                                updatedAt: DateTime.now(),
                                createdAt: rent!.createdAt,
                              );

                              Database()
                                  .updateRent(updateitem)
                                  .whenComplete(() {
                                Future.delayed(Durations.short1).then((_) {
                                  context.pop();
                                  rentController.rents.refresh();
                                });
                              });
                            } else {
                              final newItem = RentModel(
                                name: editingName.text,
                                item: item.id!,
                                amount: amount.value,
                                identity: identity.value,
                                picture: people.value,
                                note: editingNote.text,
                                paid: false,
                                rentDate: DateTime.now()
                                    .add(Duration(days: days.value)),
                                howManyDay: days.value,
                                createdAt: DateTime.now(),
                              );
                              print('hello $newItem');
                              Database().addRent(newItem).whenComplete(() {
                                rentController.rents.refresh();
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
