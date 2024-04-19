import 'package:due_kasir/controller/selling/events.dart';
import 'package:due_kasir/controller/selling_controller.dart';
import 'package:due_kasir/enum/payment_enum.dart';
import 'package:due_kasir/model/item_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/service/get_it.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class Selling extends HookWidget {
  Selling({super.key});
  final _sellingFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final tipeBayar = getIt.get<SellingController>().tipeBayar.watch(context);
    final pelanggan = getIt.get<SellingController>().pelanggan.watch(context);
    final kasir = getIt.get<SellingController>().kasir.watch(context);
    final list = getIt.get<SellingController>().cart.watch(context);
    final cashEditing = useTextEditingController(text: '0');
    useListenable(cashEditing);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Autocomplete<ItemModel>(
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      if (textEditingValue.text == '') {
                        return const Iterable<ItemModel>.empty();
                      }
                      final data = await Database()
                          .searchInventorys(textEditingValue.text);
                      return data;
                    },
                    onSelected: (ItemModel value) {
                      getIt
                          .get<SellingController>()
                          .dispatch(CartItemAdded(value));
                    },
                    displayStringForOption: (option) => option.nama,
                    optionsViewBuilder: (context, onSelected, options) {
                      return Material(
                        child: ListView(
                          children: options
                              .map(
                                (option) => GestureDetector(
                                  onTap: () => onSelected(option),
                                  child: ListTile(
                                    leading:
                                        const Icon(Icons.arrow_right_rounded),
                                    title: Text(option.nama),
                                    subtitle: Text(option.code),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      );
                    },
                    fieldViewBuilder: (context, textEditingController,
                            focusNode, onFieldSubmitted) =>
                        TextFormField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      onEditingComplete: onFieldSubmitted,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search',
                        suffixIcon: IconButton(
                          onPressed: () => textEditingController.clear(),
                          icon: const Icon(Icons.clear),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  list.map(
                    data: (item) => Column(
                      children: item.items
                          .map(
                            (val) => ListTile(
                                title: Text(val.nama),
                                subtitle: Text(currency.format(val.hargaJual)),
                                trailing: Text(val.code),
                                onLongPress: () => showShadDialog(
                                      context: context,
                                      builder: (context) => ShadDialog.alert(
                                        title: const Text(
                                            'Apakah kamu yakin akan menghapusnya??'),
                                        description: const Padding(
                                          padding: EdgeInsets.only(bottom: 8),
                                          child: Text(
                                            'Tindakan ini tidak dapat di kembalikan, data akan di hapus dari list',
                                          ),
                                        ),
                                        actions: [
                                          ShadButton.outline(
                                            text: const Text('Batal'),
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                          ),
                                          ShadButton(
                                              text: const Text('Lanjutkan'),
                                              onPressed: () {
                                                getIt
                                                    .get<SellingController>()
                                                    .dispatch(
                                                        CartItemRemoved(val));
                                                Navigator.of(context).pop(true);
                                              }),
                                        ],
                                      ),
                                    )),
                          )
                          .toList(),
                    ),
                    error: (e, __) => Text('$__'),
                    loading: () => const Text('Loading'),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Form(
              key: _sellingFormKey,
              child: ShadCard(
                title:
                    Text('Payment', style: ShadTheme.of(context).textTheme.h4),
                description: const Text('Rangkuman belanja'),
                content: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(kasir?.nama ?? 'Admin'),
                        subtitle: const Text('Kasir'),
                        trailing: const Icon(Icons.arrow_right),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(pelanggan?.nama ?? 'Mommy'),
                        subtitle: const Text('Pelanggan'),
                        trailing: const Icon(Icons.arrow_right),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Total'),
                        trailing: Text(
                          currency.format(list.value?.totalPrice ?? 0),
                          style: ShadTheme.of(context).textTheme.large,
                        ),
                      ),
                      ShadRadioGroupFormField<TypePayment>(
                        label: const Text('Tipe pembayaran'),
                        initialValue: tipeBayar,
                        onChanged: (TypePayment? val) {
                          getIt.get<SellingController>().tipeBayar.value = val!;
                        },
                        items: TypePayment.values.map(
                          (e) => ShadRadio(
                            value: e,
                            label: Text(e.message),
                          ),
                        ),
                        validator: (v) {
                          if (v == null) {
                            return 'You need to select a notification type.';
                          }
                          return null;
                        },
                      ),
                      if (tipeBayar == TypePayment.cash)
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Nominal Cash'),
                                  ShadInput(
                                    controller: cashEditing,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                ],
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Kembalian'),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(currency.format((double.parse(
                                          cashEditing.text.isNotEmpty
                                              ? cashEditing.text
                                              : '0') -
                                      (list.value?.totalPrice ?? 0.0)))),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ))
                          ],
                        )
                    ],
                  ),
                ),
                footer: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ShadCheckboxFormField(
                        id: 'terms',
                        initialValue: false,
                        inputLabel: const Text('Saya Bertanggun Jawab'),
                        onChanged: (v) {},
                        inputSublabel: const Text(
                            'Barang sudah saya cek dan sudah di bayar pelanggan dengan nominal yg benar'),
                        validator: (v) {
                          if (!v) {
                            return 'You must accept the terms and conditions';
                          }
                          return null;
                        },
                      ),
                    ),
                    ShadButton(
                      onPressed: () {
                        if (_sellingFormKey.currentState!.validate()) {
                          cashEditing.clear();
                          getIt.get<SellingController>().tipeBayar.value =
                              TypePayment.qris;
                          getIt.get<SellingController>().dispatch(CartPaid());
                        }
                      },
                      text: const Text('Print'),
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.print,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            // Container(
            //   padding: const EdgeInsets.all(10),
            //   child: Column(
            //     children: [
            //       Text('Payment', style: ShadTheme.of(context).textTheme.h3),
            //       ListTile(
            //         title: const Text('Total'),
            //         trailing: Text(
            //           currency.format(list.value?.totalPrice),
            //           style: ShadTheme.of(context).textTheme.large,
            //         ),
            //       ),
            //       const Spacer(),
            //       Align(
            //         alignment: Alignment.bottomRight,
            //         child: ShadButton(
            //           onPressed: () {},
            //           text: const Text('Print'),
            //           icon: const Padding(
            //             padding: EdgeInsets.only(right: 8),
            //             child: Icon(
            //               Icons.print,
            //               size: 16,
            //             ),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            ),
      ],
    );
  }
}
