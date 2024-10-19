import 'dart:io';
import 'package:due_kasir/model/salary_model.dart';
import 'package:due_kasir/model/store_model.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:file_saver/file_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<dynamic> pdfGenerator(
    {required StoreModel store, required Users user, required Salary salary}) async {
  final Document pdf = Document(deflate: zlib.encode);
  pdf.addPage(
    Page(
        pageFormat:
            PdfPageFormat.letter.copyWith(marginBottom: 1.5 * PdfPageFormat.cm),
        margin: const EdgeInsets.all(20),
        orientation: PageOrientation.portrait,
        theme: ThemeData.base(),
        build: (Context context) {
          return ListView(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                child: Text("Salary Report",
                    style:
                        const TextStyle(color: PdfColors.blue, fontSize: 25)),
              ),
              Container(
                  height: 1.0,
                  width: 600.0,
                  color: PdfColors.blue,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10)),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(store.title,
                              style: const TextStyle(color: PdfColors.blue)),
                        ),
                        Container(child: Text(store.description ?? '')),
                        Container(
                            child: Text(
                                "Date : ${dateWithoutTime.format(DateTime.now())}")),
                        Container(child: Text("Refrence : ${salary.periode}")),
                      ],
                    ),
                  ]),
              Container(
                  height: 1.0,
                  width: 600.0,
                  color: PdfColors.blue,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 10)),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Name",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(child: Text(user.nama)),
                          SizedBox(width: 10, height: 10),
                          Container(
                            child: Text(
                              "Jabatan",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(child: Text(user.keterangan ?? '-')),
                        ]),
                  ]),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomLeft,
                child: Text('Salary Details',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              Container(
                color: PdfColors.grey200,
                child: Table(
                    border: const TableBorder(
                        horizontalInside: BorderSide(
                            width: 1,
                            color: PdfColors.black,
                            style: BorderStyle.solid),
                        top: BorderSide(
                            width: 1,
                            color: PdfColors.black,
                            style: BorderStyle.solid),
                        bottom: BorderSide(
                            width: 1,
                            color: PdfColors.black,
                            style: BorderStyle.solid),
                        verticalInside: BorderSide(
                            width: 1,
                            color: PdfColors.black,
                            style: BorderStyle.solid),
                        left: BorderSide(
                            width: 1,
                            color: PdfColors.black,
                            style: BorderStyle.solid),
                        right: BorderSide(
                            width: 1,
                            color: PdfColors.black,
                            style: BorderStyle.solid)),
                    tableWidth: TableWidth.max,
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: Text("Description"),
                        ),
                        Container(
                            padding: const EdgeInsets.all(5),
                            child: Text("Total")),
                      ]),
                      for (ItemSalary i in salary.items ?? [])
                        TableRow(children: <Widget>[
                          Container(
                              padding: const EdgeInsets.all(5),
                              child: Text(i.description ?? '')),
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Text(
                                currency.format(int.parse(i.amount ?? '0'))),
                          ),
                        ]),
                    ]),
              ),
              if (salary.deductions?.isNotEmpty == true) ...[
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text('Deductions Details',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                SizedBox(height: 10),
                Container(
                  color: PdfColors.grey200,
                  child: Table(
                      border: const TableBorder(
                          horizontalInside: BorderSide(
                              width: 1,
                              color: PdfColors.black,
                              style: BorderStyle.solid),
                          top: BorderSide(
                              width: 1,
                              color: PdfColors.black,
                              style: BorderStyle.solid),
                          bottom: BorderSide(
                              width: 1,
                              color: PdfColors.black,
                              style: BorderStyle.solid),
                          verticalInside: BorderSide(
                              width: 1,
                              color: PdfColors.black,
                              style: BorderStyle.solid),
                          left: BorderSide(
                              width: 1,
                              color: PdfColors.black,
                              style: BorderStyle.solid),
                          right: BorderSide(
                              width: 1,
                              color: PdfColors.black,
                              style: BorderStyle.solid)),
                      tableWidth: TableWidth.max,
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        TableRow(children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Text("Description"),
                          ),
                          Container(
                              padding: const EdgeInsets.all(5),
                              child: Text("Total")),
                        ]),
                        for (ItemSalary i in salary.deductions ?? [])
                          TableRow(children: <Widget>[
                            Container(
                                padding: const EdgeInsets.all(5),
                                child: Text(i.description ?? '')),
                            Container(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                  currency.format(int.parse(i.amount ?? '0'))),
                            ),
                          ]),
                      ]),
                ),
              ],
              SizedBox(height: 10),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(child: Text("Grand Total")),
                        SizedBox(width: 15),
                        Container(child: Text(currency.format(salary.total))),
                      ],
                    ),
                    SizedBox(height: 15),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(child: Text("Management")),
                          SizedBox(height: 40),
                          Container(
                            child: Text(salary.management ?? store.title),
                          ),
                        ])
                  ]),
              Row(children: [
                Text('Note:'),
                SizedBox(width: 5),
                Text(
                  salary.note ?? '-',
                  style: TextStyle(fontStyle: FontStyle.italic),
                )
              ])
            ],
          );
        }),
  );
  final output = await getApplicationDocumentsDirectory();
  final file = File("${output.path}/example.pdf");
  // print(output.path);
  await file.writeAsBytes(await pdf.save());
  if (Platform.isWindows) {
    FileSaver.instance.saveFile(
        name: 'salary-kasir-${DateTime.now().millisecondsSinceEpoch}.csv',
        file: file);
  } else {
    await FileSaver.instance.saveAs(
        name:
            'salary-kasir-${user.nama.trim()}-${DateTime.now().millisecondsSinceEpoch}',
        file: file,
        ext: 'pdf',
        mimeType: MimeType.pdf);
  }
}
