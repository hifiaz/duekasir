import 'package:due_kasir/pages/drawer.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Rent extends StatefulWidget {
  const Rent({super.key});

  @override
  State<Rent> createState() => _RentState();
}

class _RentState extends State<Rent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Rent'),
        centerTitle: false,
      ),
      body: const SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: ShadCard(
                title: Text('Ready to Rent'),
                description: Text('Available item to rent'),
                content: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Stroller Baby Elle'),
                      subtitle: Text('Rp. 120.000,- /month'),
                      trailing: Icon(Icons.arrow_right),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Car Seat Joie'),
                      subtitle: Text('Rp. 200.000,- /month'),
                      trailing: Icon(Icons.arrow_right),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Baby Seat to Eat'),
                      subtitle: Text('Rp. 60.000,- /month'),
                      trailing: Icon(Icons.arrow_right),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ShadCard(
                title: Text('Rental Periode'),
                description: Text('List customer who rent our item'),
                content: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Williem'),
                      subtitle: Text('Baby Seat to Eat - Expired on 20 days'),
                      trailing: Icon(Icons.check_circle, color: Colors.green),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Jose'),
                      subtitle: Text('Car Seat Joie - Expired on 5 days'),
                      trailing: Icon(Icons.check_circle, color: Colors.green),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Brad'),
                      subtitle: Text('Car Seat Joie - Expired on -2 days'),
                      trailing: Icon(Icons.close, color: Colors.red),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
