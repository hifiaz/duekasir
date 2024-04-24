// ignore_for_file: depend_on_referenced_packages


import 'package:due_kasir/controller/selling_controller.dart';
import 'package:due_kasir/service/get_it.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_pos_printer_platform_image_3/flutter_pos_printer_platform_image_3.dart';
import 'package:signals/signals_flutter.dart';

class PrintSetting extends StatefulWidget {
  const PrintSetting({super.key});

  @override
  State<PrintSetting> createState() => _PrintSettingState();
}

class _PrintSettingState extends State<PrintSetting> {
  // var defaultPrinterType = PrinterType.usb;
  // var _isBle = false;
  // var _reconnect = false;
  // var _isConnected = false;
  // var printerManager = PrinterManager.instance;
  // var devices = <PrinterModel>[];
  // StreamSubscription<PrinterDevice>? _subscription;
  // StreamSubscription<BTStatus>? _subscriptionBtStatus;
  // StreamSubscription<USBStatus>? _subscriptionUsbStatus;
  // BTStatus _currentStatus = BTStatus.none;
  // // _currentUsbStatus is only supports on Android
  // // ignore: unused_field
  // USBStatus _currentUsbStatus = USBStatus.none;
  // List<int>? pendingTask;

  // @override
  // void initState() {
  //   if (Platform.isWindows) defaultPrinterType = PrinterType.usb;
  //   super.initState();
  //   _scan();

  //   // subscription to listen change status of bluetooth connection
  //   _subscriptionBtStatus =
  //       PrinterManager.instance.stateBluetooth.listen((status) {
  //     log(' ----------------- status bt $status ------------------ ');
  //     _currentStatus = status;
  //     if (status == BTStatus.connected) {
  //       setState(() {
  //         _isConnected = true;
  //       });
  //     }
  //     if (status == BTStatus.none) {
  //       setState(() {
  //         _isConnected = false;
  //       });
  //     }
  //     if (status == BTStatus.connected && pendingTask != null) {
  //       if (Platform.isAndroid) {
  //         Future.delayed(const Duration(milliseconds: 1000), () {
  //           PrinterManager.instance
  //               .send(type: PrinterType.bluetooth, bytes: pendingTask!);
  //           pendingTask = null;
  //         });
  //       } else if (Platform.isIOS) {
  //         PrinterManager.instance
  //             .send(type: PrinterType.bluetooth, bytes: pendingTask!);
  //         pendingTask = null;
  //       }
  //     }
  //   });
  //   //  PrinterManager.instance.stateUSB is only supports on Android
  //   _subscriptionUsbStatus = PrinterManager.instance.stateUSB.listen((status) {
  //     log(' ----------------- status usb $status ------------------ ');
  //     _currentUsbStatus = status;
  //     if (Platform.isAndroid) {
  //       if (status == USBStatus.connected && pendingTask != null) {
  //         Future.delayed(const Duration(milliseconds: 1000), () {
  //           PrinterManager.instance
  //               .send(type: PrinterType.usb, bytes: pendingTask!);
  //           pendingTask = null;
  //         });
  //       }
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   _subscription?.cancel();
  //   _subscriptionBtStatus?.cancel();
  //   _subscriptionUsbStatus?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final selectedPrint =
        getIt.get<SellingController>().selectedPrint.watch(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Print Setting'),
        centerTitle: false,
        actions: const [
          // Padding(
          //   padding: const EdgeInsets.only(right: 8.0),
          //   child: ShadBadge(
          //     text: Text(defaultPrinterType == PrinterType.bluetooth
          //         ? _currentStatus.name
          //         : _currentUsbStatus.name),
          //   ),
          // )
        ],
      ),
      body: const SizedBox(),
      // body: Center(
      //   child: Container(
      //     height: double.infinity,
      //     constraints: const BoxConstraints(maxWidth: 400),
      //     child: SingleChildScrollView(
      //       padding: EdgeInsets.zero,
      //       child: Column(
      //         children: [
      //           Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Row(
      //               children: [
      //                 Expanded(
      //                   child: ElevatedButton(
      //                     onPressed: selectedPrint == null || _isConnected
      //                         ? null
      //                         : () {
      //                             _connectDevice(selectedPrint);
      //                           },
      //                     child: const Text("Connect",
      //                         textAlign: TextAlign.center),
      //                   ),
      //                 ),
      //                 const SizedBox(width: 8),
      //                 Expanded(
      //                   child: ElevatedButton(
      //                     onPressed: selectedPrint == null || !_isConnected
      //                         ? null
      //                         : () {
      //                             if (selectedPrint.deviceName != null) {
      //                               printerManager.disconnect(
      //                                   type: selectedPrint.typePrinter);
      //                             }
      //                             setState(() => _isConnected = false);
      //                           },
      //                     child: const Text("Disconnect",
      //                         textAlign: TextAlign.center),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           DropdownButtonFormField<PrinterType>(
      //             value: defaultPrinterType,
      //             decoration: const InputDecoration(
      //               prefixIcon: Icon(
      //                 Icons.print,
      //                 size: 24,
      //               ),
      //               labelText: "Type Printer Device",
      //               labelStyle: TextStyle(fontSize: 18.0),
      //               focusedBorder: InputBorder.none,
      //               enabledBorder: InputBorder.none,
      //             ),
      //             items: <DropdownMenuItem<PrinterType>>[
      //               if (Platform.isAndroid || Platform.isIOS)
      //                 const DropdownMenuItem(
      //                   value: PrinterType.bluetooth,
      //                   child: Text("bluetooth"),
      //                 ),
      //               if (Platform.isAndroid || Platform.isWindows)
      //                 const DropdownMenuItem(
      //                   value: PrinterType.usb,
      //                   child: Text("usb"),
      //                 ),
      //             ],
      //             onChanged: (PrinterType? value) {
      //               setState(() {
      //                 if (value != null) {
      //                   getIt.get<SellingController>().selectedPrint.value =
      //                       null;
      //                   setState(() {
      //                     defaultPrinterType = value;
      //                     _isBle = false;
      //                     _isConnected = false;
      //                     _scan();
      //                   });
      //                 }
      //               });
      //             },
      //           ),
      //           Visibility(
      //             visible: defaultPrinterType == PrinterType.bluetooth &&
      //                 Platform.isAndroid,
      //             child: SwitchListTile.adaptive(
      //               contentPadding:
      //                   const EdgeInsets.only(bottom: 20.0, left: 20),
      //               title: const Text(
      //                 "This device supports ble (low energy)",
      //                 textAlign: TextAlign.start,
      //                 style: TextStyle(fontSize: 19.0),
      //               ),
      //               value: _isBle,
      //               onChanged: (bool? value) {
      //                 getIt.get<SellingController>().selectedPrint.value = null;
      //                 setState(() {
      //                   _isBle = value ?? false;
      //                   _isConnected = false;
      //                   _scan();
      //                 });
      //               },
      //             ),
      //           ),
      //           Visibility(
      //             visible: defaultPrinterType == PrinterType.bluetooth &&
      //                 Platform.isAndroid,
      //             child: SwitchListTile.adaptive(
      //               contentPadding:
      //                   const EdgeInsets.only(bottom: 20.0, left: 20),
      //               title: const Text(
      //                 "reconnect",
      //                 textAlign: TextAlign.start,
      //                 style: TextStyle(fontSize: 19.0),
      //               ),
      //               value: _reconnect,
      //               onChanged: (bool? value) {
      //                 setState(() {
      //                   _reconnect = value ?? false;
      //                 });
      //               },
      //             ),
      //           ),
      //           Column(
      //               children: devices
      //                   .map(
      //                     (device) => ListTile(
      //                       title: Text('${device.deviceName}'),
      //                       subtitle: Platform.isAndroid &&
      //                               defaultPrinterType == PrinterType.usb
      //                           ? null
      //                           : Visibility(
      //                               visible: !Platform.isWindows,
      //                               child: Text("${device.address}")),
      //                       onTap: () {
      //                         // do something
      //                         selectDevice(device, selectedPrint);
      //                       },
      //                       leading: selectedPrint != null &&
      //                               ((device.typePrinter == PrinterType.usb &&
      //                                           Platform.isWindows
      //                                       ? device.deviceName ==
      //                                           selectedPrint.deviceName
      //                                       : device.vendorId != null &&
      //                                           selectedPrint.vendorId ==
      //                                               device.vendorId) ||
      //                                   (device.address != null &&
      //                                       selectedPrint.address ==
      //                                           device.address))
      //                           ? const Icon(
      //                               Icons.check,
      //                               color: Colors.green,
      //                             )
      //                           : null,
      //                       // trailing: OutlinedButton(
      //                       //   onPressed: selectedPrinter == null ||
      //                       //           device.deviceName !=
      //                       //               selectedPrinter?.deviceName
      //                       //       ? null
      //                       //       : () async {
      //                       //           _printReceiveTest();
      //                       //         },
      //                       //   child: const Padding(
      //                       //     padding: EdgeInsets.symmetric(
      //                       //         vertical: 2, horizontal: 20),
      //                       //     child: Text("Print test ticket",
      //                       //         textAlign: TextAlign.center),
      //                       //   ),
      //                       // ),
      //                     ),
      //                   )
      //                   .toList()),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  // void _scan() {
  //   devices.clear();
  //   _subscription = printerManager
  //       .discovery(type: defaultPrinterType, isBle: _isBle)
  //       .listen((device) {
  //     devices.add(PrinterModel(
  //       deviceName: device.name,
  //       address: device.address,
  //       isBle: _isBle,
  //       vendorId: device.vendorId,
  //       productId: device.productId,
  //       typePrinter: defaultPrinterType,
  //     ));
  //     setState(() {});
  //   });
  // }

  // _connectDevice(PrinterModel? selectedPrinter) async {
  //   _isConnected = false;
  //   if (selectedPrinter == null) return;
  //   switch (selectedPrinter.typePrinter) {
  //     case PrinterType.usb:
  //       await printerManager.connect(
  //           type: selectedPrinter.typePrinter,
  //           model: UsbPrinterInput(
  //               name: selectedPrinter.deviceName,
  //               productId: selectedPrinter.productId,
  //               vendorId: selectedPrinter.vendorId));
  //       _isConnected = true;
  //       break;
  //     case PrinterType.bluetooth:
  //       await printerManager.connect(
  //           type: selectedPrinter.typePrinter,
  //           model: BluetoothPrinterInput(
  //               name: selectedPrinter.deviceName,
  //               address: selectedPrinter.address!,
  //               isBle: selectedPrinter.isBle ?? false,
  //               autoConnect: _reconnect));
  //       break;
  //     default:
  //   }

  //   setState(() {});
  // }

  // void selectDevice(PrinterModel device, PrinterModel? selectedPrinter) async {
  //   if (selectedPrinter != null) {
  //     if ((device.address != selectedPrinter.address) ||
  //         (device.typePrinter == PrinterType.usb &&
  //             selectedPrinter.vendorId != device.vendorId)) {
  //       await PrinterManager.instance
  //           .disconnect(type: selectedPrinter.typePrinter);
  //     }
  //   }

  //   getIt.get<SellingController>().selectedPrint.value = device;
  //   setState(() {});
  // }
}
