import 'package:due_kasir/pages/drawer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Salaries extends StatefulWidget {
  const Salaries({super.key});

  @override
  State<Salaries> createState() => _SalariesState();
}

class _SalariesState extends State<Salaries> {
  final forSalariesmKey = GlobalKey<ShadFormState>();
  String? password;
  bool obscure = true;
  var invoices = [
    (
      invoice: "INV001",
      name: "Zila",
      date: "Now",
      paymentStatus: "Paid",
      totalAmount: r"$250.00",
      paymentMethod: "Credit Card",
      option: "Credit Card",
    ),
    (
      invoice: "INV002",
      name: "Zula",
      date: "Now",
      paymentStatus: "Pending",
      totalAmount: r"$150.00",
      paymentMethod: "PayPal",
      option: "PayPal",
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                  footer: ShadButton(
                    text: const Text('Access'),
                    onPressed: () {
                      if (forSalariesmKey.currentState!.value['password'] ==
                          '242309') {
                        setState(() {
                          password =
                              forSalariesmKey.currentState!.value['password'];
                        });
                      }
                    },
                  ),
                ),
              ),
            )
          : ShadTable.list(
              header: const [
                ShadTableCell.header(child: Text('Invoice')),
                ShadTableCell.header(child: Text('Status')),
                ShadTableCell.header(child: Text('Name')),
                ShadTableCell.header(child: Text('Date')),
                ShadTableCell.header(child: Text('Method')),
                ShadTableCell.header(child: Text('Amount')),
                ShadTableCell.header(
                  alignment: Alignment.centerRight,
                  child: Text('Options'),
                ),
              ],
              columnSpanExtent: (index) {
                if (index == 6) return const RemainingTableSpanExtent();
                return null;
              },
              children: invoices.map(
                (invoice) => [
                  ShadTableCell(
                    child: Text(
                      invoice.invoice,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ShadTableCell(child: Text(invoice.name)),
                  ShadTableCell(child: Text(invoice.date)),
                  ShadTableCell(child: Text(invoice.paymentStatus)),
                  ShadTableCell(child: Text(invoice.paymentMethod)),
                  ShadTableCell(child: Text(invoice.totalAmount)),
                  ShadTableCell(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ShadButton.outline(
                          text: const Text('Print'),
                          onPressed: () {},
                        ),
                        ShadButton(
                          text: const Text('Edit'),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
