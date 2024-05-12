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
        ],
      ),
      body: presense.hasValue && presense.value?.isNotEmpty == true
          ? ShadTable.list(
              header: const [
                ShadTableCell.header(child: Text('ID')),
                ShadTableCell.header(child: Text('Status')),
                ShadTableCell.header(child: Text('Name')),
                ShadTableCell.header(child: Text('Note')),
                ShadTableCell.header(
                  alignment: Alignment.centerRight,
                  child: Text('Date Time'),
                ),
              ],
              columnSpanExtent: (index) {
                if (index == 1) return const FixedTableSpanExtent(200);
                if (index == 4) {
                  return const MaxTableSpanExtent(
                    FixedTableSpanExtent(120),
                    RemainingTableSpanExtent(),
                  );
                }
                // uses the default value
                return null;
              },
              children: presense.value!.map(
                (p) => [
                  ShadTableCell(
                    child: Text(
                      p.id.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ShadTableCell(
                    child: p.status == 'checkin'
                        ? ShadBadge(
                            text: Text(p.status.toUpperCase()),
                          )
                        : ShadBadge.destructive(
                            text: Text(p.status.toUpperCase()),
                          ),
                  ),
                  ShadTableCell(
                    child: FutureBuilder<UserModel?>(
                        future: Database().getUserById(p.user),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data?.nama ?? 'Admin');
                          }
                          return const Text('Admin');
                        }),
                  ),
                  ShadTableCell(child: Text(p.note ?? '-')),
                  ShadTableCell(
                    alignment: Alignment.centerRight,
                    child: Text(dateWithTime.format(p.createdAt)),
                  ),
                ],
              ),
            )
          : const Center(
              child: Text('There is no data'),
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
