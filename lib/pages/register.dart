import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Register extends StatefulWidget {
  const Register({
    super.key,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<ShadFormState>();
  bool obscure = true;

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
                  placeholder: const Text('Password'),
                  obscureText: obscure,
                  prefix: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: ShadImage.square(size: 16, LucideIcons.lock),
                  ),
                  validator: (v) {
                    if (v.length < 5) {
                      return 'Password must more then 5';
                    }
                    return null;
                  },
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
                const SizedBox(height: 16),
                ShadButton(
                  text: const Text('Register'),
                  onPressed: () async {
                    if (formKey.currentState!.saveAndValidate()) {
                      try {
                        final credential =
                            await Supabase.instance.client.auth.signUp(
                          email: formKey.currentState!.value['email'],
                          password: formKey.currentState!.value['password'],
                        );
                        if (credential.user != null) {
                          if (context.mounted) {
                            ShadToaster.of(context).show(
                              ShadToast(
                                title: const Text('Register Success'),
                                description:
                                    const Text('Login and Enjoy Due Kasir!'),
                                action: ShadButton.outline(
                                  text: const Text('Back!'),
                                  onPressed: () =>
                                      ShadToaster.of(context).hide(),
                                ),
                              ),
                            );
                            Future.delayed(const Duration(seconds: 2))
                                .then((_) => context.go('/login'));
                          }
                        }
                      } on AuthException catch (e) {
                        ShadAlert.destructive(
                          iconSrc: LucideIcons.circleAlert,
                          title: const Text('Error'),
                          description: Text(e.message),
                        );
                      }
                    }
                  },
                ),
                Center(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Already Have Account?',
                        style: ShadTheme.of(context).textTheme.muted,
                      ),
                      TextSpan(
                        text: ' Login',
                        style: ShadTheme.of(context).textTheme.p,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.go('/login'),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
