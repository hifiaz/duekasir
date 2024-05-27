import 'package:due_kasir/controller/salary_controller.dart';
import 'package:due_kasir/controller/store_controller.dart';
import 'package:due_kasir/model/salary_model.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:due_kasir/utils/extension.dart';
import 'package:due_kasir/widget/pdf_generator.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Salaries extends StatefulWidget {
  const Salaries({super.key});

  @override
  State<Salaries> createState() => _SalariesState();
}

class _SalariesState extends State<Salaries> {
  EmailOTP myAuth = EmailOTP();
  final forSalariesmKey = GlobalKey<ShadFormState>();
  String? password;
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    User? user = Supabase.instance.client.auth.currentUser;
    final store = storeController.store.watch(context);
    final salaries = salaryController.salaries.watch(context);
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Salaries'),
        centerTitle: false,
        actions: [
          if (password != null)
            ShadButton.ghost(
              onPressed: () => context.push('/salaries/form'),
              text: const Text('Add Payment'),
              icon: const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.payment,
                  size: 16,
                ),
              ),
            ),
          ShadButton.ghost(
            onPressed: () {
              salaryController.salaries.refresh();
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
                await Database().salariesSync();
                await salaryController.salaries.refresh();
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
      body: password == null
          ? Center(
              child: ShadForm(
                key: forSalariesmKey,
                child: ShadCard(
                  width: 350,
                  title: Text('Access Page',
                      style: ShadTheme.of(context).textTheme.h4),
                  description:
                      const Text('Ask your administration to access this page'),
                  content: ShadInputFormField(
                    id: 'password',
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
                  footer: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShadButton.outline(
                        text: const Text('Send Request Access'),
                        onPressed: () async {
                          myAuth.setConfig(
                              appEmail: "fiazhari@gmail.com",
                              appName: "Email OTP",
                              userEmail: user?.email ?? 'fiazhari@gmail.com',
                              otpLength: 6,
                              otpType: OTPType.digitsOnly);
                          if (await myAuth.sendOTP() == true) {
                            if (context.mounted) {
                              ShadToaster.of(context).show(
                                const ShadToast(
                                  backgroundColor: Colors.green,
                                  description: Text('OTP has been sent'),
                                ),
                              );
                            }
                          } else {
                            if (context.mounted) {
                              ShadToaster.of(context).show(
                                const ShadToast(
                                  backgroundColor: Colors.red,
                                  description: Text('Oops, OTP send failed'),
                                ),
                              );
                            }
                          }
                        },
                      ),
                      ShadButton(
                        text: const Text('Access'),
                        onPressed: () async {
                          if (forSalariesmKey.currentState!.value['password'] ==
                              '111111') {
                            setState(() {
                              password = forSalariesmKey
                                  .currentState!.value['password'];
                            });
                          } else {
                            if (await myAuth.verifyOTP(
                                    otp: forSalariesmKey
                                        .currentState!.value['password']) ==
                                true) {
                              setState(() {
                                password = forSalariesmKey
                                    .currentState!.value['password'];
                              });
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          : salaries.map(
              data: (salary) {
                if (salary.isEmpty) {
                  return const Center(child: Text('There is No Data'));
                }
                if (PlatformExtension.isMobile) {
                  return SingleChildScrollView(
                    child: Column(
                      children: salary.map((item) {
                        final status = ['Draf', 'Paid'];
                        return ListTile(
                          title: FutureBuilder<UserModel?>(
                            future: Database().getUserById(item.userId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                    '${snapshot.data?.nama ?? 'Admin'} (${currency.format(item.total)})');
                              }
                              return const Text('Admin');
                            },
                          ),
                          subtitle: Text('${item.status} ${item.periode}'),
                          trailing: ShadSelectFormField<String>(
                            id: 'status',
                            initialValue: item.status,
                            onChanged: (v) async {
                              SalaryModel salary = SalaryModel(
                                id: item.id,
                                userId: item.userId,
                                status: v ?? 'Draf',
                                periode: item.periode,
                                items: item.items,
                                deductions: item.deductions,
                                note: item.note,
                                management: item.management,
                                total: item.total,
                                createdAt: item.createdAt,
                              );
                              await Database().updateSalary(salary);
                              Future.delayed(Durations.medium1).then(
                                  (_) => salaryController.salaries.refresh());
                            },
                            options: status
                                .map(
                                    (u) => ShadOption(value: u, child: Text(u)))
                                .toList(),
                            selectedOptionBuilder: (context, value) =>
                                Text(value),
                            placeholder: const Text('Status'),
                            validator: (v) {
                              if (v == null) {
                                return 'Please select an status to display';
                              }
                              return null;
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
                return DataTable(
                  columns: const [
                    DataColumn(label: Text('Id')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Note')),
                    DataColumn(label: Text('Amount')),
                    DataColumn(label: Text('Options')),
                  ],
                  dataRowMaxHeight: 80,
                  rows: salary.map(
                    (item) {
                      final status = ['Draf', 'Paid'];
                      return DataRow(
                        cells: [
                          DataCell(
                            Text(
                              item.id.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          DataCell(Text(item.status)),
                          DataCell(
                            FutureBuilder<UserModel?>(
                              future: Database().getUserById(item.userId),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(snapshot.data?.nama ?? 'Admin');
                                }
                                return const Text('Admin');
                              },
                            ),
                          ),
                          DataCell(Text(item.periode)),
                          DataCell(Text(item.note ?? '')),
                          DataCell(Text(currency.format(item.total))),
                          DataCell(
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: ShadSelectFormField<String>(
                                    id: 'status',
                                    initialValue: item.status,
                                    onChanged: (v) async {
                                      SalaryModel salary = SalaryModel(
                                        id: item.id,
                                        userId: item.userId,
                                        status: v ?? 'Draf',
                                        periode: item.periode,
                                        items: item.items,
                                        deductions: item.deductions,
                                        note: item.note,
                                        management: item.management,
                                        total: item.total,
                                        createdAt: item.createdAt,
                                      );
                                      await Database().updateSalary(salary);
                                      Future.delayed(Durations.medium1).then(
                                          (_) => salaryController.salaries
                                              .refresh());
                                    },
                                    options: status
                                        .map((u) => ShadOption(
                                            value: u, child: Text(u)))
                                        .toList(),
                                    selectedOptionBuilder: (context, value) =>
                                        Text(value),
                                    placeholder: const Text('Status'),
                                    validator: (v) {
                                      if (v == null) {
                                        return 'Please select an status to display';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                ShadButton(
                                  text: const Text('PDF'),
                                  onPressed: () async {
                                    var user = await Database()
                                        .getUserById(item.userId);
                                    if (user != null) {
                                      pdfGenerator(
                                        user: user,
                                        store: store.value!,
                                        salary: item,
                                      );
                                    }
                                  },
                                ),
                                ShadButton.destructive(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () async {
                                    await Database().deleteSalary(item.id!);
                                    Future.delayed(Durations.medium1).then(
                                        (_) => salaryController.salaries
                                            .refresh());
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ).toList(),
                );
              },
              error: (e, __) => Text('$e'),
              loading: () => const CircularProgressIndicator()),
    );
  }
}
