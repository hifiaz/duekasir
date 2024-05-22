import 'package:due_kasir/controller/salary_controller.dart';
import 'package:due_kasir/controller/store_controller.dart';
import 'package:due_kasir/model/user_model.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/pages/salaries/salaries_form.dart';
import 'package:due_kasir/service/database.dart';
import 'package:due_kasir/utils/constant.dart';
import 'package:due_kasir/widget/pdf_generator.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

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
                              userEmail: "fiazhari@gmail.com",
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
                          if (await myAuth.verifyOTP(
                                  otp: forSalariesmKey
                                      .currentState!.value['password']) ==
                              true) {
                            setState(() {
                              password = forSalariesmKey
                                  .currentState!.value['password'];
                            });
                          }
                          // if (forSalariesmKey.currentState!.value['password'] ==
                          //     '111111') {
                          //   setState(() {
                          //     password = forSalariesmKey
                          //         .currentState!.value['password'];
                          //   });
                          // }
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
                return ShadTable.list(
                  header: const [
                    ShadTableCell.header(child: Text('Id')),
                    ShadTableCell.header(child: Text('Status')),
                    ShadTableCell.header(child: Text('Name')),
                    ShadTableCell.header(child: Text('Date')),
                    ShadTableCell.header(child: Text('Note')),
                    ShadTableCell.header(child: Text('Amount')),
                    ShadTableCell.header(
                      alignment: Alignment.centerRight,
                      child: Text('Options'),
                    ),
                  ],
                  columnSpanExtent: (index) {
                    if (index == 5) return const FixedTableSpanExtent(200);
                    if (index == 6) return const RemainingTableSpanExtent();
                    return null;
                  },
                  children: salary.map(
                    (item) {
                      return [
                        ShadTableCell(
                          child: Text(
                            item.id.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        ShadTableCell(child: Text(item.status)),
                        ShadTableCell(
                          child: FutureBuilder<UserModel?>(
                            future: Database().getUserById(item.userId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data?.nama ?? 'Admin');
                              }
                              return const Text('Admin');
                            },
                          ),
                        ),
                        ShadTableCell(child: Text(item.periode)),
                        ShadTableCell(child: Text(item.note ?? '')),
                        ShadTableCell(child: Text(currency.format(item.total))),
                        ShadTableCell(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ShadButton.outline(
                                text: const Text('Export PDF'),
                                onPressed: () async {
                                  var user =
                                      await Database().getUserById(item.userId);
                                  if (user != null) {
                                    pdfGenerator(
                                      user: user,
                                      store: store.value!,
                                      salary: item,
                                    );
                                  }
                                },
                              ),
                              ShadButton(
                                text: const Text('Edit'),
                                onPressed: () async {
                                  var user =
                                      await Database().getUserById(item.userId);
                                  if (context.mounted) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SalariesForm(
                                          salary: item,
                                          selectedUser: user,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              ShadButton.destructive(
                                text: const Text('Delete'),
                                onPressed: () async {
                                  await Database().deleteSalary(item.id!);
                                  Future.delayed(Durations.medium1).then((_) =>
                                      salaryController.salaries.refresh());
                                },
                              ),
                            ],
                          ),
                        ),
                      ];
                    },
                  ),
                );
              },
              error: (e, __) => Text('$e'),
              loading: () => const CircularProgressIndicator()),
    );
  }
}
