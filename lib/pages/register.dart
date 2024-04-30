import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Register extends StatefulWidget {
  const Register({
    super.key,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
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
                  // controller: email,
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
                  // controller: password,
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
                  text: const Text('Register'),
                  onPressed: () async {
                    if (formKey.currentState!.saveAndValidate()) {
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: formKey.currentState!.value['email'],
                          password: formKey.currentState!.value['password'],
                        );
                        if (credential.additionalUserInfo?.isNewUser == true) {
                          if (context.mounted) {
                            ShadToaster.of(context).show(
                              ShadToast(
                                title: const Text('Register Success'),
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
                        if (e.code == 'weak-password') {
                          const ShadAlert.destructive(
                            iconSrc: LucideIcons.circleAlert,
                            title: Text('Error'),
                            description:
                                Text('The password provided is too weak.'),
                          );
                        } else if (e.code == 'email-already-in-use') {
                          const ShadAlert.destructive(
                            iconSrc: LucideIcons.circleAlert,
                            title: Text('Error'),
                            description: Text(
                                'The account already exists for that email.'),
                          );
                        }
                      } catch (e) {
                         ShadAlert.destructive(
                          iconSrc: LucideIcons.circleAlert,
                          title: const Text('Error'),
                          description: Text('$e'),
                        );
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
