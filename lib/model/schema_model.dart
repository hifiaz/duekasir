import 'package:powersync/powersync.dart';

const schema = Schema([
  Table('customer', [
    Column.text('nama'),
    Column.text('phone'),
    Column.text('ktp'),
    Column.text('dob'),
    Column.text('keterangan'),
    Column.integer('status'),
    Column.text('masuk'),
    Column.text('user'),
    Column.text('createdAt')
  ]),
  Table('due_payment', [
    Column.text('name'),
    Column.text('invoice'),
    Column.text('itemName'),
    Column.integer('itemAmount'),
    Column.integer('amount'),
    Column.text('status'),
    Column.text('note'),
    Column.text('dateIn'),
    Column.text('dueDate'),
    Column.text('createdAt'),
    Column.text('user')
  ]),
  Table('expenses', [
    Column.text('title'),
    Column.text('note'),
    Column.integer('amount'),
    Column.text('createdAt'),
    Column.text('user')
  ]),
  Table('inventory', [
    Column.text('nama'),
    Column.text('code'),
    Column.text('deskripsi'),
    Column.text('jumlahBarang'),
    Column.text('quantity'),
    Column.text('ukuran'),
    Column.text('hargaDasar'),
    Column.text('hargaJual'),
    Column.real('hargaJualPersen'),
    Column.real('diskonPersen'),
    Column.integer('isHargaJualPersen'),
    Column.text('barangMasuk'),
    Column.text('barangKeluar'),
    Column.text('createdAt'),
    Column.text('user')
  ]),
  Table('presense', [
    Column.integer('user'),
    Column.text('status'),
    Column.text('note'),
    Column.text('path'),
    Column.real('long'),
    Column.real('lat'),
    Column.text('createdAt'),
    Column.text('belong')
  ]),
  Table('rent', [
    Column.text('name'),
    Column.integer('item'),
    Column.text('note'),
    Column.integer('amount'),
    Column.integer('pinalty'),
    Column.integer('identity'),
    Column.integer('picture'),
    Column.text('rentDate'),
    Column.integer('paid'),
    Column.text('user'),
    Column.text('createdAt'),
    Column.text('updatedAt'),
    Column.integer('howManyDay')
  ]),
  Table('rent_items', [
    Column.text('name'),
    Column.text('code'),
    Column.text('note'),
    Column.integer('jumlahBarang'),
    Column.integer('rentThreeDay'),
    Column.integer('rentOneWeek'),
    Column.integer('rentOneMonth'),
    Column.text('user'),
    Column.text('createdAt')
  ]),
  Table('report', [
    Column.text('items'),
    Column.text('totalItem'),
    Column.real('totalHarga'),
    Column.real('diskon'),
    Column.text('kasir'),
    Column.text('pembeli'),
    Column.text('keterangan'),
    Column.text('createdAt'),
    Column.text('user')
  ]),
  Table('request', [
    Column.text('note'),
    Column.text('created_at'),
    Column.text('user'),
    Column.text('status'),
    Column.text('title')
  ]),
  Table('salary', [
    Column.integer('userId'),
    Column.text('status'),
    Column.text('periode'),
    Column.text('items'),
    Column.text('deductions'),
    Column.integer('total'),
    Column.text('note'),
    Column.text('createdAt'),
    Column.text('user'),
    Column.text('management')
  ]),
  Table('store', [
    Column.text('title'),
    Column.text('description'),
    Column.text('phone'),
    Column.text('footer'),
    Column.text('subFooter'),
    Column.text('user')
  ])
]);
