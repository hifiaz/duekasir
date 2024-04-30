import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: formKey.currentState!.value['email'],
                          password: formKey.currentState!.value['password'],
                        );
                        if (credential.additionalUserInfo != null) {
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
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          if (context.mounted) {
                            ShadToaster.of(context).show(
                              const ShadToast(
                                backgroundColor: Colors.red,
                                title: Text('Error'),
                                description:
                                    Text('No user found for that email.'),
                              ),
                            );
                          }
                        } else if (e.code == 'wrong-password') {
                          if (context.mounted) {
                            ShadToaster.of(context).show(
                              const ShadToast(
                                backgroundColor: Colors.red,
                                title: Text('Error'),
                                description: Text(
                                    'Wrong password provided for that user.'),
                              ),
                            );
                          }
                        } else {
                          if (context.mounted) {
                            ShadToaster.of(context).show(
                              const ShadToast(
                                backgroundColor: Colors.red,
                                title: Text('Error'),
                                description:
                                    Text('Invalid credentials that user.'),
                              ),
                            );
                          }
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
