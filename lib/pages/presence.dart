import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:due_kasir/controller/presence_controller.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/pages/presence/presence_form.dart';
import 'package:due_kasir/service/supabase_service.dart';
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
            icon: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.refresh,
                size: 16,
              ),
            ),
            child: const Text('Refresh'),
          ),
          // PopupMenuButton<String>(
          //   onSelected: (item) async {
          //     if (item == 'sync') {
          //       await Database().presenseSync();
          //       await presenceController.presence.refresh();
          //     }
          //   },
          //   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
          //     const PopupMenuItem<String>(
          //       value: 'sync',
          //       child: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Icon(Icons.restore),
          //           SizedBox(width: 8),
          //           Text('Sync'),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ShadButton.outline(
                    child: Text(
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
                  child: const Text('Reset'),
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
                                            child:
                                                Text(val.status!.toUpperCase()),
                                          )
                                        : ShadBadge.destructive(
                                            child:
                                                Text(val.status!.toUpperCase()),
                                          ),
                                  ),
                                  DataCell(
                                    FutureBuilder<Users?>(
                                        future: SupabaseHelper()
                                            .getUserById(val.user!),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                                snapshot.data?.nama ?? 'Admin');
                                          }
                                          return const Text('Admin');
                                        }),
                                  ),
                                  DataCell(Text(val.note ?? '')),
                                  DataCell(Text(dateWithTime
                                      .format(DateTime.parse(val.createdAt)))),
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
