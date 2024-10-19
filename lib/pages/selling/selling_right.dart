import 'dart:async';
import 'dart:io';

import 'package:due_kasir/controller/selling/events.dart';
import 'package:due_kasir/controller/selling_controller.dart';
import 'package:due_kasir/controller/store_controller.dart';
import 'package:due_kasir/enum/payment_enum.dart';
import 'package:due_kasir/model/inventory_model.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/model/store_model.dart';
import 'package:due_kasir/pages/customer/customer_sheet.dart';
import 'package:due_kasir/service/get_it.dart';
import 'package:due_kasir/service/supabase_service.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:usb_esc_printer_windows/usb_esc_printer_windows.dart'
    as usb_esc_printer_windows;

class SellingRight extends StatefulHookWidget {
  const SellingRight({super.key});

  @override
  SellingRightState createState() => SellingRightState();
}

class SellingRightState extends State<SellingRight> {
  // final formWhatsappKey = GlobalKey<ShadFormState>();
  late Future<CapabilityProfile> _profile;
  bool isConnected = false;
  bool isNeedToPrint = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isWindows) {
      _profile = CapabilityProfile.load();
    } else {
      if (!Platform.isMacOS) checkConnection();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sellingFormKey = useMemoized(GlobalKey<FormState>.new);
    final printName =
        getIt.get<SellingController>().selectedPrint.watch(context);
    final store = storeController.store.watch(context);
    final tipeBayar = getIt.get<SellingController>().tipeBayar.watch(context);
    final pelanggan = getIt.get<SellingController>().pelanggan.watch(context);
    final kasir = getIt.get<SellingController>().kasir.watch(context);
    final list = getIt.get<SellingController>().cart.watch(context);
    final cashEditing = useTextEditingController(text: '0');
    final note = useTextEditingController();

    useListenable(cashEditing);
    useListenable(note);
    return SingleChildScrollView(
      child: Form(
        key: sellingFormKey,
        child: ShadCard(
          title: Text('Payment', style: ShadTheme.of(context).textTheme.h4),
          description: Text('Rangkuman belanja ${store.value?.title ?? ''}'),
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
                  if (sellingFormKey.currentState!.validate() &&
                      store.hasValue) {
                    List<Inventory> products = [];
                    for (Inventory p in list.value!.items) {
                      products.add(Inventory.fromJson({
                        'id': p.id,
                        'nama': p.nama,
                        'code': p.code,
                        'quantity': p.quantity,
                        'hargaJual': p.hargaJual,
                        'ukuran': p.ukuran,
                        'isHargaJualPersen': p.isHargaJualPersen,
                        'hargaJualPersen': p.hargaJualPersen,
                        'hargaDasar': p.hargaDasar,
                        'diskonPersen': p.diskonPersen,
                        'deskripsi': p.deskripsi,
                        'jumlahBarang': p.jumlahBarang,
                      }));
                    }
                    final newItem = {
                      'id': DateTime.now().microsecondsSinceEpoch,
                      'items': products,
                      'kasir': kasir?.id ?? 1,
                      'keterangan': note.text,
                      'diskon': 0,
                      'totalHarga': list.value?.totalPrice ?? 0.0,
                      'totalItem': list.value?.totalItem ?? 0,
                      'pembeli': pelanggan?.id,
                      'createdAt': DateTime.now(),
                    };
                    if (products.isEmpty) return;
                    SupabaseHelper().addReport(newItem).whenComplete(() {
                      cashEditing.clear();
                      note.clear();
                      getIt.get<SellingController>().tipeBayar.value =
                          TypePayment.qris;
                      sellingFormKey.currentState?.reset();
                      getIt
                          .get<SellingController>()
                          .updateBatch(list.value!.items)
                          .whenComplete(() => getIt
                              .get<SellingController>()
                              .dispatch(CartPaid()));
                    });
                  }
                },
                icon: const Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Icon(
                    Icons.save,
                    size: 16,
                  ),
                ),
                child: const Text('Simpan'),
              ),
              ShadButton(
                onPressed: () {
                  if (sellingFormKey.currentState!.validate() &&
                      store.hasValue) {
                    List<Inventory> products = [];
                    for (Inventory p in list.value!.items) {
                      products.add(Inventory.fromJson({
                        'id': p.id,
                        'nama': p.nama,
                        'code': p.code,
                        'quantity': p.quantity,
                        'hargaJual': p.hargaJual,
                        'ukuran': p.ukuran,
                        'isHargaJualPersen': p.isHargaJualPersen,
                        'hargaJualPersen': p.hargaJualPersen,
                        'hargaDasar': p.hargaDasar,
                        'diskonPersen': p.diskonPersen,
                        'deskripsi': p.deskripsi,
                        'jumlahBarang': p.jumlahBarang,
                      }));
                    }
                    final newItem = {
                      'id': DateTime.now().microsecondsSinceEpoch,
                      'items': products,
                      'kasir': kasir?.id ?? 1,
                      'keterangan': note.text,
                      'diskon': 0,
                      'totalHarga': list.value?.totalPrice ?? 0.0,
                      'totalItem': list.value?.totalItem ?? 0,
                      'pembeli': pelanggan?.id,
                      'createdAt': DateTime.now(),
                    };
                    if (products.isEmpty) return;
                    SupabaseHelper().addReport(newItem).whenComplete(() {
                      letsPrint(
                              store: store.value!,
                              model: Report.fromJson(newItem),
                              kasir: kasir?.nama ?? 'Umum',
                              tipe: tipeBayar,
                              total: cashEditing.text,
                              kembalian: (double.parse(
                                          cashEditing.text.isNotEmpty
                                              ? cashEditing.text
                                              : '0') -
                                      (list.value?.totalPrice ?? 0.0))
                                  .toString(),
                              printName: printName)
                          .whenComplete(() {
                        cashEditing.clear();
                        note.clear();
                        getIt.get<SellingController>().tipeBayar.value =
                            TypePayment.qris;
                        sellingFormKey.currentState?.reset();
                        getIt
                            .get<SellingController>()
                            .updateBatch(list.value!.items)
                            .whenComplete(() => getIt
                                .get<SellingController>()
                                .dispatch(CartPaid()));
                        // sendWhatsapp(
                        //   store: store.value!,
                        //   sales: newItem,
                        //   customer: pelanggan,
                        // );
                      });
                    });
                  }
                },
                icon: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(
                    isConnected && !Platform.isWindows || printName.isNotEmpty
                        ? Icons.print
                        : Icons.print_disabled,
                    size: 16,
                  ),
                ),
                child: const Text('Print'),
              ),
            ],
          ),
          child: Padding(
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
                  onTap: () => context.push('/home'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(pelanggan?.nama ?? 'Mommy'),
                  subtitle: const Text('Pelanggan'),
                  trailing: const Icon(Icons.arrow_right),
                  onTap: () {
                    showShadSheet(
                      side: ShadSheetSide.right,
                      context: context,
                      builder: (context) => const CustomerSheet(),
                    );
                  },
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
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                  ),
                const Text('Catatan'),
                ShadInput(
                  controller: note,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void sendWhatsapp(
  //     {required StoreModel store,
  //     required PenjualanModel sales,
  //     CustomerModel? customer}) {
  //   showShadDialog(
  //     context: context,
  //     builder: (context) => ShadDialog(
  //       title: const Text('Kirim ke Whatsaap?'),
  //       description:
  //           const Text("Rincian ringkas akan di kirim ke nomor whatsapp"),
  //       content: ShadForm(
  //         key: formWhatsappKey,
  //         child: Container(
  //           width: 375,
  //           padding: const EdgeInsets.symmetric(vertical: 20),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             children: [
  //               ShadInputFormField(
  //                 id: "name",
  //                 label: const Text('Nama'),
  //                 initialValue: customer?.nama,
  //                 validator: (v) {
  //                   if (v.length < 2) {
  //                     return 'Name must be at least 2 characters.';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //               ShadInputFormField(
  //                 id: "phone",
  //                 label: const Text('Phone'),
  //                 initialValue: customer?.phone,
  //                 description: const Text(
  //                     'Pastikan nomor tidak ada angka 0 di depan dan berawalan 62 (tanpa tanda +)'),
  //                 validator: (v) {
  //                   if (v.length < 2) {
  //                     return 'Phone must valid';
  //                   }
  //                   return null;
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       actions: [
  //         ShadButton(
  //             onPressed: () => context.pop(), text: const Text('Cancel')),
  //         ShadButton(
  //             onPressed: () async {
  //               final newCustomer = CustomerModel(
  //                 nama: formWhatsappKey.currentState!.value['name'],
  //                 status: true,
  //                 phone: formWhatsappKey.currentState!.value['phone'],
  //                 keterangan: 'Add From Seling Page',
  //                 masuk: DateTime.now(),
  //                 createdAt: DateTime.now(),
  //               );

  //               Database().addNewCustomer(newCustomer).whenComplete(() {
  //                 customerController.customer.refresh();
  //               });

  //               try {
  //                 await DioClient.instance.dio.post('/messages', data: {
  //                   "messaging_product": "whatsapp",
  //                   "to": formWhatsappKey.currentState!.value['phone'],
  //                   "type": "template",
  //                   "template": {
  //                     "name": "order",
  //                     "language": {"code": "id"},
  //                     'components': [
  //                       {
  //                         "type": "body",
  //                         "parameters": [
  //                           {
  //                             "type": "text",
  //                             "text":
  //                                 formWhatsappKey.currentState!.value['name']
  //                           },
  //                           {"type": "text", "text": store.title},
  //                           {
  //                             "type": "text",
  //                             "text": currency.format(sales.totalHarga)
  //                           },
  //                           {"type": "text", "text": store.footer}
  //                         ],
  //                       }
  //                     ]
  //                   }
  //                 });
  //                 if (context.mounted) {
  //                   context.pop();
  //                 }
  //               } on DioException catch (e) {
  //                 print(e);
  //               }
  //             },
  //             text: const Text('Kirim'))
  //       ],
  //     ),
  //   );
  // }

  void checkConnection() async {
    isConnected = await PrintBluetoothThermal.connectionStatus;
    setState(() {});
  }

  Future<Uint8List> loadImageFromAssets(String path) async {
    final ByteData data = await rootBundle.load(path);
    return data.buffer.asUint8List();
  }

  Future<void> letsPrint({
    required StoreModel store,
    required Report model,
    required String kasir,
    required TypePayment tipe,
    String? total,
    String? kembalian,
    String? printName,
  }) async {
    final profile = await CapabilityProfile.load();
    late CapabilityProfile winProfile;
    if (Platform.isWindows) {
      winProfile = await _profile;
    }
    final generator =
        Generator(PaperSize.mm80, Platform.isWindows ? winProfile : profile);
    List<int> bytes = [];
    // final Uint8List data = await loadImageFromAssets('assets/logo.jpeg');

    // img.Image originalImage = img.decodeImage(data)!;

    // bytes += generator.imageRaster(originalImage, align: PosAlign.center);
    // bytes += generator.feed(1);
    // bytes += generator.imageRaster(image);
    bytes += generator.text(store.title,
        styles: const PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));
    bytes += generator.feed(1);
    bytes += generator.text(store.description ?? '',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text(store.phone ?? '',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.feed(1);
    bytes += generator.hr();
    bytes += generator.text(
        'Date/Time : ${DateFormat.yMd().add_jm().format(DateTime.now())}');
    bytes += generator.text('Cashier   : $kasir');
    bytes += generator.feed(1);

    bytes += [27, 97, 0];
    bytes += generator.row([
      PosColumn(
        text: 'QTY',
        width: 1,
        styles: const PosStyles(
          align: PosAlign.left,
          bold: true,
        ),
      ),
      PosColumn(
        text: 'S/T/DESCRIPTION',
        width: 9,
        styles: const PosStyles(
          align: PosAlign.left,
          bold: true,
        ),
      ),
      PosColumn(
        text: 'TOTAL',
        width: 2,
        styles: const PosStyles(
          align: PosAlign.left,
          bold: true,
        ),
      ),
    ]);
    bytes += generator.hr();
    for (Inventory i in model.items) {
      bytes += generator.text(i.nama!);
      bytes += generator.row([
        PosColumn(
          text:
              '${i.diskonPersen == null || i.diskonPersen == 0.0 ? '' : 'Disc'} ${i.quantity} x ${i.diskonPersen == null || i.diskonPersen == 0.0 ? i.hargaJual : '${i.hargaJual} >> ${i.hargaJual! - i.hargaJual! * (i.diskonPersen! / 100)}'}',
          width: 6,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: i.diskonPersen == null || i.diskonPersen == 0.0
              ? '${i.quantity! * i.hargaJual!}'
              : '${i.quantity! * (i.hargaJual! - i.hargaJual! * (i.diskonPersen! / 100))}',
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }

    bytes += generator.hr();
    bytes += [27, 97, 2];
    bytes += generator.text(
      'Total ${currency.format(model.totalHarga)}',
      styles: const PosStyles(
        height: PosTextSize.size2,
        bold: true,
      ),
    );
    bytes += [27, 97, 1];
    bytes += generator.text('Transaction details');
    bytes += generator.text('*****************************************');
    bytes += generator.row([
      PosColumn(
        text: 'Bayar',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: tipe == TypePayment.cash ? total! : tipe.name,
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);
    if (tipe == TypePayment.cash) {
      bytes += generator.row([
        PosColumn(
          text: 'Kembali',
          width: 6,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: kembalian ?? '0',
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }
    bytes += generator.feed(2);
    if (store.footer != null) {
      bytes += generator.text(store.footer!,
          styles: const PosStyles(align: PosAlign.center));
    }
    if (store.subFooter != null) {
      bytes += generator.text(store.subFooter!,
          styles: const PosStyles(align: PosAlign.center));
    }
    bytes += generator.feed(2);
    bytes += generator.cut();
    bytes += generator.drawer();
    if (Platform.isWindows) {
      await usb_esc_printer_windows.sendPrintRequest(
          bytes, printName ?? 'Xprinter XP-T371U');
    } else {
      await PrintBluetoothThermal.writeBytes(bytes);
    }
  }
}
