import 'package:due_kasir/controller/report_controller.dart';
import 'package:due_kasir/service/database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ReportDeleteDialog extends StatefulWidget {
  final int id;
  const ReportDeleteDialog({super.key, required this.id});

  @override
  State<ReportDeleteDialog> createState() => _ReportDeleteDialogState();
}

class _ReportDeleteDialogState extends State<ReportDeleteDialog> {
  final reportFormKey = GlobalKey<ShadFormState>();
  final TextEditingController _password = TextEditingController();
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: reportFormKey,
      child: ShadDialog(
        title: const Text('Delete Report'),
        description: const Text(
            "Are you sure to delete this report, this action can't be undo"),
        content: Container(
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
        actions: [
          ShadButton(
              onPressed: () => context.pop(), text: const Text('Cancel')),
          ShadButton(
              onPressed: () async {
                if (reportFormKey.currentState!.validate()) {
                  if (_password.text == '111111') {
                    await Database().removePenjualan(widget.id);
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
              text: const Text('Delete'))
        ],
      ),
    );
  }
}
