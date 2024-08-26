import 'package:due_kasir/controller/store_controller.dart';
import 'package:due_kasir/model/store_model.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/service/database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  final _storeFormKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController footer = TextEditingController();
  TextEditingController subFooter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final store = storeController.store.watch(context);
    final theme = ShadTheme.of(context);
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Store'),
        centerTitle: false,
        actions: [
          PopupMenuButton<String>(
            onSelected: (item) async {
              if (item == 'sync') {
                Database().syncStore();
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
      body: Form(
        key: _storeFormKey,
        child: store.map(
          data: (t) {
            title = TextEditingController(text: t?.title ?? '');
            description = TextEditingController(text: t?.description ?? '');
            phone = TextEditingController(text: t?.phone ?? '');
            footer = TextEditingController(text: t?.footer ?? '');
            subFooter = TextEditingController(text: t?.subFooter ?? '');

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ShadCard(
                      width: 350,
                      title: Text('Account Login', style: theme.textTheme.h4),
                      description: const Text(
                          'Make sure you have login with your account'),
                      footer: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ShadButton(
                            child: const Text('Save'),
                            onPressed: () {
                              if (_storeFormKey.currentState!.validate()) {
                                if (store.value != null) {
                                  final val = StoreModel(
                                    id: store.value!.id,
                                    title: title.text,
                                    description: description.text,
                                    phone: phone.text,
                                    footer: footer.text,
                                    subFooter: subFooter.text,
                                  );
                                  Database().addStore(val).whenComplete(
                                    () {
                                      storeController.store.refresh();
                                      context.pop();
                                      ShadToaster.of(context).show(
                                        const ShadToast(
                                          backgroundColor: Colors.green,
                                          description: Text(
                                            'Store Success Updated',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  final val = StoreModel(
                                    id: DateTime.now().microsecondsSinceEpoch,
                                    title: title.text,
                                    description: description.text,
                                    phone: phone.text,
                                    footer: footer.text,
                                    subFooter: subFooter.text,
                                  );
                                  Database().addStore(val).whenComplete(
                                    () {
                                      storeController.store.refresh();
                                      context.pop();
                                      ShadToaster.of(context).show(
                                        const ShadToast(
                                          backgroundColor: Colors.green,
                                          description: Text(
                                            'Store Success Saved',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ShadInputFormField(
                              initialValue: t?.title,
                              label: const Text('Title Store'),
                              placeholder: const Text('Store'),
                              controller: title,
                              validator: (v) {
                                if (v.length < 2) {
                                  return 'Title must be at least 2 characters.';
                                }
                                return null;
                              },
                            ),
                            ShadInputFormField(
                              label: const Text('Description/Location'),
                              placeholder: const Text('Texas, US'),
                              controller: description,
                              maxLines: 2,
                              validator: (v) {
                                if (v.length < 2) {
                                  return 'Description must be at least 2 characters.';
                                }
                                return null;
                              },
                            ),
                            ShadInputFormField(
                              label: const Text('Phone'),
                              placeholder:
                                  const Text('Whatsapp/Phone: +6285111222333'),
                              controller: phone,
                              validator: (v) {
                                if (v.length < 2) {
                                  return 'Phone must be at least 2 characters.';
                                }
                                return null;
                              },
                            ),
                            ShadInputFormField(
                              label: const Text('Footer'),
                              placeholder:
                                  const Text('Thanks for visiting us!'),
                              controller: footer,
                            ),
                            ShadInputFormField(
                              label: const Text('Sub Footer'),
                              placeholder:
                                  const Text('Follow us on social media'),
                              controller: subFooter,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, __) => Text('$error'),
          loading: () => const Center(
            child: Text('Loading...'),
          ),
        ),
      ),
    );
  }
}
