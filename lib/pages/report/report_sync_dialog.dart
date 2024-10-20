import 'package:due_kasir/controller/report_controller.dart';
import 'package:due_kasir/model/penjualan_model.dart';
import 'package:due_kasir/service/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ReportSyncDialog extends StatefulWidget {
  final int id;
  final Report detail;
  const ReportSyncDialog({super.key, required this.id, required this.detail});

  @override
  State<ReportSyncDialog> createState() => _ReportSyncDialogState();
}

class _ReportSyncDialogState extends State<ReportSyncDialog> {
  final reportFormKey = GlobalKey<ShadFormState>();
  final TextEditingController _password = TextEditingController();
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: reportFormKey,
      child: ShadDialog(
        title: const Text('Sync Item Penjualan'),
        description: const Text(
            "Are you sure to sync this Item, this action can't be undo"),
        actions: [
          ShadButton(
              onPressed: () => context.pop(), child: const Text('Cancel')),
          ShadButton(
              onPressed: () async {
                if (reportFormKey.currentState!.validate()) {
                  if (_password.text == '111111') {
                    await SupabaseHelper().addReport(widget.detail.toMap());
                    await reportController.report.refresh();
                    await reportController.reportToday.refresh();
                    await reportController.reportYesterday.refresh();
                    if (context.mounted) {
                      context.pop();
                    }
                  } else {
                    ShadToaster.of(context).show(
                      const ShadToast(
                        backgroundColor: Colors.red,
                        description: Text(
                          'Incorrect Password!',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                }
              },
              child: const Text('Sync'))
        ],
        child: Container(
          width: 375,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ShadInputFormField(
            controller: _password,
            label: const Text('Password'),
            placeholder: const Text('Enter your password'),
            validator: (v) {
              if (v.length < 2) {
                return 'Password must be at least 2 characters.';
              }
              return null;
            },
            obscureText: obscure,
            prefix: const Padding(
              padding: EdgeInsets.all(4.0),
              child: ShadImage.square(size: 16, LucideIcons.lock),
            ),
            suffix: ShadButton(
              width: 24,
              height: 24,
              padding: EdgeInsets.zero,
              decoration: ShadDecoration.none,
              icon: ShadImage.square(
                size: 16,
                obscure ? LucideIcons.eyeOff : LucideIcons.eye,
              ),
              onPressed: () {
                setState(() => obscure = !obscure);
              },
            ),
          ),
        ),
      ),
    );
  }
}
