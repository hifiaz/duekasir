import 'package:collection/collection.dart';
import 'package:due_kasir/controller/salary_controller.dart';
import 'package:due_kasir/controller/user_controller.dart';
import 'package:due_kasir/model/salary_model.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/service/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

final itemSalary = listSignal<ItemSalary>([], autoDispose: true);
final itemDeductions = listSignal<ItemSalary>([], autoDispose: true);

class SalariesForm extends StatefulWidget {
  final UserModel? selectedUser;
  final SalaryModel? salary;
  const SalariesForm({super.key, this.selectedUser, this.salary});

  @override
  State<SalariesForm> createState() => _SalariesFormState();
}

class _SalariesFormState extends State<SalariesForm> {
  TextEditingController total = TextEditingController();
  TextEditingController periode = TextEditingController();
  TextEditingController note = TextEditingController();
  TextEditingController management = TextEditingController();
  List<Widget> formItems = [];
  List<Widget> formDeductions = [];
  int itemsCount = 0;
  int deductionCount = 0;
  int? tempTotal;
  final salariesFormKey = GlobalKey<ShadFormState>();
  final status = ['Draf', 'Paid'];
  UserModel? user;

  @override
  void initState() {
    super.initState();
    if (widget.salary != null && widget.selectedUser != null) {
      user = widget.selectedUser;
      periode = TextEditingController(text: widget.salary?.periode);
      total = TextEditingController(text: widget.salary?.total.toString());
      note = TextEditingController(text: widget.salary?.note);
      initialItem();
      initialDeduction();
    } else {
      formItems.add(buildItemField(itemsCount));
    }
  }

  Future<void> initialDeduction() async {
    itemDeductions.value = widget.salary?.deductions ?? [];
    if (widget.salary?.deductions != null) {
      deductionCount = (widget.salary?.deductions ?? []).length;
      await Future.forEach(widget.salary!.deductions!, (item) async {
        formDeductions.add(buildDeductionField(item.id!, item: item));
      });
    }
  }

  Future<void> initialItem() async {
    itemSalary.value = widget.salary?.items ?? [];
    if (widget.salary?.items != null) {
      itemsCount = (widget.salary?.items ?? []).length;
      await Future.forEach(widget.salary!.items, (item) async {
        formItems.add(buildItemField(item.id!, item: item));
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = itemSalary.watch(context);
    final deductions = itemDeductions.watch(context);
    final users = userController.users.watch(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ShadForm(
              key: salariesFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  Text('Information',
                      style: ShadTheme.of(context).textTheme.h4),
                  const SizedBox(height: 10),
                  Wrap(
                    children: [
                      if (users.hasValue && users.value?.isNotEmpty == true)
                        ShadSelectFormField<UserModel>(
                          id: 'user',
                          initialValue: widget.selectedUser,
                          label: const Text('User'),
                          onChanged: (v) => setState(() => user = v),
                          options: users.value!
                              .map((u) =>
                                  ShadOption(value: u, child: Text(u.nama)))
                              .toList(),
                          selectedOptionBuilder: (context, value) =>
                              Text(value.nama),
                          placeholder: const Text('User'),
                          validator: (v) {
                            if (v == null) {
                              return 'Please select an user to display';
                            }
                            return null;
                          },
                        ),
                      ShadSelectFormField<String>(
                        id: 'status',
                        initialValue: widget.salary?.status,
                        label: const Text('Status'),
                        onChanged: (v) {},
                        options: status
                            .map((u) => ShadOption(value: u, child: Text(u)))
                            .toList(),
                        selectedOptionBuilder: (context, value) => Text(value),
                        placeholder: const Text('Status'),
                        validator: (v) {
                          if (v == null) {
                            return 'Please select an status to display';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        width: 320,
                        child: ShadInputFormField(
                          controller: periode,
                          id: 'periode',
                          label: const Text('Periode'),
                          placeholder: const Text('Ex: Mei 2024'),
                          validator: (v) {
                            if (v.length < 2) {
                              return 'Must be at least 2 characters.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Detail Salary',
                      style: ShadTheme.of(context).textTheme.h4),
                  const SizedBox(height: 10),
                  ListView.builder(
                    itemCount: formItems.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, i) => buildItemField(i),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ShadButton.secondary(
                      text: const Text('Add'),
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.add,
                          size: 16,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          itemsCount++;
                          formItems.add(buildItemField(itemsCount));
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text('Deductions', style: ShadTheme.of(context).textTheme.h4),
                  const SizedBox(height: 10),
                  ListView.builder(
                    itemCount: formDeductions.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, i) => buildDeductionField(i),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ShadButton.secondary(
                      text: const Text('Add Deduction'),
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Icon(
                          Icons.add,
                          size: 16,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          deductionCount++;
                          formDeductions
                              .add(buildDeductionField(deductionCount));
                        });
                      },
                    ),
                  ),
                  ShadInputFormField(
                    controller: total,
                    label: const Text('Total'),
                    placeholder: const Text('ex: 10000'),
                    description: ShadButton.outline(
                      text: Text('Count Total: ${tempTotal ?? ''}'),
                      onPressed: () {
                        int itemTotal = 0;
                        int deductionsTotal = 0;
                        if (items.isNotEmpty) {
                          itemTotal = items.fold(
                              0, (p, c) => p + int.parse(c.amount ?? '0'));
                        }
                        if (deductions.isNotEmpty) {
                          deductionsTotal = deductions.fold(
                              0, (p, c) => p + int.parse(c.amount ?? '0'));
                        }
                        setState(() {
                          tempTotal = itemTotal - deductionsTotal;
                        });
                      },
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (v) {
                      if (v.length < 2) {
                        return 'Must be at least 2 characters.';
                      }
                      return null;
                    },
                  ),
                  ShadInputFormField(
                    controller: management,
                    label: const Text('Management'),
                  ),
                  ShadInputFormField(
                    controller: note,
                    label: const Text('Note'),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ShadButton(
                      text: const Text('Save'),
                      onPressed: () {
                        if (salariesFormKey.currentState!.saveAndValidate()) {
                          SalaryModel salary = SalaryModel(
                            userId: user!.id!,
                            status:
                                salariesFormKey.currentState!.value['status'],
                            periode:
                                salariesFormKey.currentState!.value['periode'],
                            items: items,
                            deductions: deductions,
                            note: note.text,
                            management: management.text,
                            total: int.parse(total.text),
                          );

                          Database().addSalary(salary).whenComplete(() {
                            salaryController.salaries.refresh();
                            Navigator.of(context).pop(false);
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemField(int i, {ItemSalary? item}) {
    return Row(
      children: [
        Expanded(
          child: ShadInputFormField(
            label: const Text('Description'),
            initialValue: item?.description,
            onChanged: (data) => storeValue(i: i + 1, description: data),
            placeholder: const Text('ex: Bonus'),
            validator: (v) {
              if (v.length < 2) {
                return 'Must be at least 2 characters.';
              }
              return null;
            },
          ),
        ),
        Expanded(
          child: ShadInputFormField(
            label: const Text('Amount'),
            initialValue: item?.amount,
            placeholder: const Text('ex: Rp 10.000.000,-'),
            onChanged: (data) => storeValue(i: i + 1, amount: data),
            validator: (v) {
              if (v.length < 2) {
                return 'Must be at least 2 characters.';
              }
              return null;
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 25.0),
          child: ShadButton.outline(
            icon: const Icon(
              Icons.delete,
              size: 16,
            ),
            size: ShadButtonSize.icon,
            onPressed: () {
              setState(() {
                itemsCount--;
                itemSalary.value.removeAt(i);
                formItems.removeAt(i);
              });
            },
          ),
        ),
      ],
    );
  }

  Widget buildDeductionField(int i, {ItemSalary? item}) {
    return Row(
      children: [
        Expanded(
          child: ShadInputFormField(
            label: const Text('Description'),
            onChanged: (data) => storeDeducton(i: i + 1, description: data),
            placeholder: const Text('ex: Bonus'),
            validator: (v) {
              if (v.length < 2) {
                return 'Must be at least 2 characters.';
              }
              return null;
            },
          ),
        ),
        Expanded(
          child: ShadInputFormField(
            label: const Text('Amount'),
            placeholder: const Text('ex: Rp 10.000.000,-'),
            onChanged: (data) => storeDeducton(i: i + 1, amount: data),
            validator: (v) {
              if (v.length < 2) {
                return 'Must be at least 2 characters.';
              }
              return null;
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 25.0),
          child: ShadButton.outline(
            icon: const Icon(
              Icons.delete,
              size: 16,
            ),
            size: ShadButtonSize.icon,
            onPressed: () {
              setState(() {
                deductionCount--;
                itemDeductions.value.removeAt(i);
                formDeductions.removeAt(i);
              });
            },
          ),
        ),
      ],
    );
  }

  dynamic storeValue({required int i, String? description, String? amount}) {
    if (amount != null || amount?.isEmpty == true) {
      final ItemSalary? item =
          itemSalary.lastWhereOrNull((item) => item.id == i);
      var temp = ItemSalary(id: i, description: item!.description);
      if (item.id == i) {
        itemSalary.removeWhere((e) => e.id == i);
      }
      itemSalary.add(
          ItemSalary(id: i, description: temp.description, amount: amount));
    } else {
      itemSalary.add(ItemSalary(id: i, description: description));
    }
  }

  dynamic storeDeducton({required int i, String? description, String? amount}) {
    if (amount != null || amount?.isEmpty == true) {
      final ItemSalary? item =
          itemDeductions.value.lastWhereOrNull((item) => item.id == i);
      var temp = ItemSalary(id: i, description: item!.description);
      if (item.id == i) {
        itemDeductions.value.removeWhere((e) => e.id == i);
      }
      itemDeductions.value.add(
          ItemSalary(id: i, description: temp.description, amount: amount));
    } else {
      itemDeductions.value.add(ItemSalary(id: i, description: description));
    }
  }
}
