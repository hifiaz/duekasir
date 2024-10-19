import 'package:due_kasir/controller/expenses_controller.dart';
import 'package:due_kasir/service/supabase_service.dart';
import 'package:due_kasir/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ExpensesForm extends HookWidget {
  final ShadSheetSide? side;
  const ExpensesForm({super.key, this.side});

  @override
  Widget build(BuildContext context) {
    final expensesFormKey = useMemoized(GlobalKey<FormState>.new);
    final title = useTextEditingController();
    final note = useTextEditingController();
    final date = useState<DateTime?>(null);
    final amount = useTextEditingController();
    return SafeArea(
      child: ShadSheet(
        title: const Text('Expenses'),
        description: const Text("Make every money out, write here"),
        actions: [
          ShadButton(
              onPressed: () async {
                if (expensesFormKey.currentState!.validate()) {
                  final newItem = {
                    'id': DateTime.now().microsecondsSinceEpoch,
                    'title': title.text,
                    'amount': int.parse(amount.text),
                    'note': note.text,
                    'createdAt': date.value
                  };
                  await SupabaseHelper().addExpenses(newItem).whenComplete(() {
                    expensesController.expenses.refresh();
                    if (context.mounted) context.pop();
                  });
                }
              },
              child: const Text('Save changes')),
        ],
        child: Form(
          key: expensesFormKey,
          child: SizedBox(
            width: side == ShadSheetSide.bottom || side == ShadSheetSide.top
                ? MediaQuery.sizeOf(context).width
                : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShadInputFormField(
                  controller: title,
                  validator: (val) =>
                      val.isEmpty == true ? 'Title is required' : null,
                  label: const Text('Title'),
                  placeholder: const Text('ex. uang makan'),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ShadInputFormField(
                        controller: amount,
                        validator: (val) =>
                            val.isEmpty == true ? 'Amount is required' : null,
                        label: const Text('Amount'),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        placeholder: const Text('ex. 25000'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: ShadButton(
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));
                          date.value = pickedDate!;
                        },
                        icon: const Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Icon(
                            Icons.date_range,
                            size: 16,
                          ),
                        ),
                        child: Text(date.value == null
                            ? 'Pick Date'
                            : dateWithoutTime.format(date.value!)),
                      ),
                    ),
                  ],
                ),
                ShadInputFormField(
                  controller: note,
                  label: const Text('Note'),
                  maxLines: 3,
                  placeholder: const Text('ex. kurir jne'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
