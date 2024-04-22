// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:due_kasir/controller/selling_controller.dart';
import 'package:due_kasir/service/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart';
import 'package:flutter_thermal_printer/utils/printer.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class PrintSetting extends StatefulWidget {
  const PrintSetting({super.key});

  @override
  State<PrintSetting> createState() => _PrintSettingState();
}

class _PrintSettingState extends State<PrintSetting> {
  final _flutterThermalPrinterPlugin = FlutterThermalPrinter.instance;

  List<Printer> printers = [];

  StreamSubscription<List<Printer>>? _devicesStreamSubscription;

  // Get Printer List
  void startScan() async {
    _devicesStreamSubscription?.cancel();
    try {
      await _flutterThermalPrinterPlugin.getPrinters();
      _devicesStreamSubscription = _flutterThermalPrinterPlugin.devicesStream
          .listen((List<Printer> event) {
        log(event.map((e) => e.name).toList().toString());
        setState(() {
          printers = event;
        });
      });
    } catch (e) {
      log('Failed to start scanning for devices $e');
    }
  }

  void getUsbDevices() async {
    await _flutterThermalPrinterPlugin.getUsbDevices();
  }

  @override
  Widget build(BuildContext context) {
    final selectedPrint =
        getIt.get<SellingController>().selectedPrint.watch(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Print Setting'),
        centerTitle: false,
        actions: [
          ShadButton(
            text: const Text('Get Printers'),
            onPressed: () {
              if (Platform.isWindows) {
                getUsbDevices();
              } else {
                startScan();
              }
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (selectedPrint != null)
            ShadButton(
              onPressed: () async {
                await _flutterThermalPrinterPlugin.connect(selectedPrint);
              },
              text: Text('Connect to ${selectedPrint.name ?? ''}'),
              icon: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.mail_outlined,
                  size: 16,
                ),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: printers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () async {
                    if (printers[index].isConnected ?? false) {
                      await _flutterThermalPrinterPlugin
                          .disconnect(printers[index]);
                    } else {
                      final isConnected = await _flutterThermalPrinterPlugin
                          .connect(printers[index]);
                      log("Devices: $isConnected");
                      setState(() {});
                    }
                  },
                  title: Text(printers[index].name ?? 'No Name'),
                  subtitle: Text(
                      "VendorId: ${printers[index].address} - Connected: ${printers[index].isConnected}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.bluetooth),
                    onPressed: () async {
                      getIt.get<SellingController>().selectedPrint.value =
                          printers[index];
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
