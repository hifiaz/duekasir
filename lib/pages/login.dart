import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          ShadButton(
            icon: const Padding(
                padding: EdgeInsets.only(right: 8), child: Icon(Icons.store)),
            text: const Text('Register'),
            onPressed: () {
              context.push('/register');
            },
          ),
        ],
      ),
      body: Center(
        child: ShadForm(
          key: formKey,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShadInputFormField(
                  id: 'email',
                  label: const Text('Email'),
                  placeholder: const Text('Enter your email'),
                  validator: (v) {
                    if (v.length < 2) {
                      return 'Email must be valid';
                    }
                    return null;
                  },
                ),
                ShadInputFormField(
                  id: 'password',
                  label: const Text('Password'),
                  placeholder: const Text('Enter your password'),
                  obscureText: true,
                  validator: (v) {
                    if (v.length < 2) {
                      return 'Email must be valid';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ShadButton(
                  text: const Text('Login'),
                  onPressed: () async {
                    if (formKey.currentState!.saveAndValidate()) {
                      try {
                        final credential = await Supabase.instance.client.auth
                            .signInWithPassword(
                          email: formKey.currentState!.value['email'],
                          password: formKey.currentState!.value['password'],
                        );
                        if (credential.user != null) {
                          if (context.mounted) {
                            ShadToaster.of(context).show(
                              ShadToast(
                                title: const Text('Login Success'),
                                description: const Text('Enjoy Due Kasir!'),
                                action: ShadButton.outline(
                                  text: const Text('Back!'),
                                  onPressed: () =>
                                      ShadToaster.of(context).hide(),
                                ),
                              ),
                            );
                            Future.delayed(const Duration(seconds: 2))
                                .then((_) => context.go('/'));
                          }
                        }
                      } on AuthException catch (e) {
                        if (context.mounted) {
                          ShadToaster.of(context).show(
                            ShadToast(
                              backgroundColor: Colors.red,
                              title: const Text('Error'),
                              description: Text(e.message),
                            ),
                          );
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
