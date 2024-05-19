import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:due_kasir/controller/presence_controller.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/pages/presence/presence_form.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class Presence extends StatelessWidget {
  const Presence({super.key});

  @override
  Widget build(BuildContext context) {
    final dateRange = presenceController.dateRange.watch(context);
    final presense = presenceController.presence.watch(context);
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Presence'),
        centerTitle: false,
        actions: [
          ShadButton.ghost(
            onPressed: () {
              presenceController.presence.refresh();
            },
            text: const Text('Refresh'),
            icon: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.refresh,
                size: 16,
              ),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (item) async {
              if (item == 'sync') {
                await Database().presenseSync();
                await presenceController.presence.refresh();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'sync',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.restore),
                    SizedBox(width: 8),
                    Text('Sync'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ShadButton.outline(
                    text: Text(
                        'Filter Date: ${dateWithoutTime.format(dateRange.first)} - ${dateWithoutTime.format(dateRange.last)}'),
                    onPressed: () async {
                      var results = await showCalendarDatePicker2Dialog(
                        context: context,
                        config: CalendarDatePicker2WithActionButtonsConfig(
                          calendarType: CalendarDatePicker2Type.range,
                        ),
                        dialogSize: const Size(325, 400),
                        value: dateRange,
                        borderRadius: BorderRadius.circular(15),
                      );
                      if (results != null) {
                        presenceController.dateRange.value = [
                          results.first!,
                          results.last!
                        ];
                      }
                    }),
                ShadButton(
                  text: const Text('Reset'),
                  onPressed: () => presenceController.dateRange.value = [
                    DateTime.now().subtract(const Duration(days: 30)),
                    DateTime.now()
                  ],
                )
              ],
            ),
            presense.map(
              data: (data) {
                if (data.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text('There is no Data'),
                    ),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DataTable(
                        columns: const [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Note')),
                          DataColumn(label: Text('Date Time')),
                        ],
                        rows: data
                            .map((val) => DataRow(cells: [
                                  DataCell(Text(val.id.toString())),
                                  DataCell(
                                    val.status == 'checkin'
                                        ? ShadBadge(
                                            text:
                                                Text(val.status.toUpperCase()),
                                          )
                                        : ShadBadge.destructive(
                                            text:
                                                Text(val.status.toUpperCase()),
                                          ),
                                  ),
                                  DataCell(
                                    FutureBuilder<UserModel?>(
                                        future:
                                            Database().getUserById(val.user),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                                snapshot.data?.nama ?? 'Admin');
                                          }
                                          return const Text('Admin');
                                        }),
                                  ),
                                  DataCell(Text(val.note ?? '')),
                                  DataCell(
                                      Text(dateWithTime.format(val.createdAt))),
                                ]))
                            .toList()),
                  ],
                );
              },
              error: (e, __) => Text('$e'),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
      // body: presense.hasValue && presense.value?.isNotEmpty == true
      //     ? ShadTable.list(
      //         header: const [
      //           ShadTableCell.header(child: Text('ID')),
      //           ShadTableCell.header(child: Text('Status')),
      //           ShadTableCell.header(child: Text('Name')),
      //           ShadTableCell.header(child: Text('Note')),
      //           ShadTableCell.header(
      //             alignment: Alignment.centerRight,
      //             child: Text('Date Time'),
      //           ),
      //         ],
      //         columnSpanExtent: (index) {
      //           if (index == 1) return const FixedTableSpanExtent(200);
      //           if (index == 4) {
      //             return const MaxTableSpanExtent(
      //               FixedTableSpanExtent(120),
      //               RemainingTableSpanExtent(),
      //             );
      //           }
      //           // uses the default value
      //           return null;
      //         },
      //         children: presense.value!.map(
      //           (p) => [
      //             ShadTableCell(
      //               child: Text(
      //                 p.id.toString(),
      //                 style: const TextStyle(
      //                   fontWeight: FontWeight.w500,
      //                 ),
      //               ),
      //             ),
      //             ShadTableCell(
      //               child: p.status == 'checkin'
      //                   ? ShadBadge(
      //                       text: Text(p.status.toUpperCase()),
      //                     )
      //                   : ShadBadge.destructive(
      //                       text: Text(p.status.toUpperCase()),
      //                     ),
      //             ),
      //             ShadTableCell(
      //               child: FutureBuilder<UserModel?>(
      //                   future: Database().getUserById(p.user),
      //                   builder: (context, snapshot) {
      //                     if (snapshot.hasData) {
      //                       return Text(snapshot.data?.nama ?? 'Admin');
      //                     }
      //                     return const Text('Admin');
      //                   }),
      //             ),
      //             ShadTableCell(child: Text(p.note ?? '-')),
      //             ShadTableCell(
      //               alignment: Alignment.centerRight,
      //               child: Text(dateWithTime.format(p.createdAt)),
      //             ),
      //           ],
      //         ),
      //       )
      //     : const Center(
      //         child: Text('There is no data'),
      //       ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showShadSheet(
          side: ShadSheetSide.right,
          context: context,
          builder: (context) => const PresenceForm(),
        ),
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
