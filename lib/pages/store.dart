import 'package:due_kasir/controller/store_controller.dart';
import 'package:due_kasir/model/store_model.dart';
import 'package:due_kasir/pages/drawer.dart';
import 'package:due_kasir/service/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:signals/signals_flutter.dart';

class Store extends HookWidget {
  Store({super.key});
  final _storeFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final store = storeController.store.watch(context);
    final theme = ShadTheme.of(context);
    final title = useTextEditingController(text: store.value?.title ?? '');
    final description =
        useTextEditingController(text: store.value?.description ?? '');
    final phone = useTextEditingController(text: store.value?.phone ?? '');
    final footer = useTextEditingController(text: store.value?.footer ?? '');
    final subFooter =
        useTextEditingController(text: store.value?.subFooter ?? '');
    useListenable(title);
    useListenable(description);
    useListenable(phone);
    useListenable(footer);
    useListenable(subFooter);
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text('Store'),
        centerTitle: false,
      ),
      body: Form(
        key: _storeFormKey,
        child: store.isLoading
            ? const Center(child: Text('Loading...'))
            : SingleChildScrollView(
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
                        content: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ShadInputFormField(
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
                                placeholder: const Text(
                                    'Whatsapp/Phone: +6285111222333'),
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
                        footer: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ShadButton(
                              text: const Text('Save'),
                              onPressed: () {
                                if (_storeFormKey.currentState!.validate()) {
                                  if (store.hasValue) {
                                    final val = StoreModel()
                                      ..id = store.value!.id
                                      ..title = title.text
                                      ..description = description.text
                                      ..phone = phone.text
                                      ..footer = footer.text
                                      ..subFooter = subFooter.text;
                                    Database().addStore(val).whenComplete(
                                          () => storeController.store.refresh(),
                                        );
                                  } else {
                                    final val = StoreModel()
                                      ..title = title.text
                                      ..description = description.text
                                      ..phone = phone.text
                                      ..footer = footer.text
                                      ..subFooter = subFooter.text;
                                    Database().addStore(val).whenComplete(
                                          () => storeController.store.refresh(),
                                        );
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
