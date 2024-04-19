import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final currency =
    NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 2);

ButtonStyle active = ElevatedButton.styleFrom(
  minimumSize: const Size.fromHeight(50),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);

ButtonStyle nonActive = ElevatedButton.styleFrom(
  elevation: 0,
  backgroundColor: Colors.transparent,
  shadowColor: Colors.transparent,
  minimumSize: const Size.fromHeight(50),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);
