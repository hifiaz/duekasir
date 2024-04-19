enum TypePayment {
  cash,
  qris,
  transfer;

  String get message {
    return switch (this) {
      cash => 'Pembayaran Cash',
      qris => 'Pembayaran dengan Qris',
      transfer => 'Pembayaran melalui Transfer',
    };
  }
}