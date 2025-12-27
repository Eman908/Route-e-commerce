import 'package:flutter/material.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({required this.email, super.key});
  final String email;

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  TextEditingController code = TextEditingController();
  @override
  void dispose() {
    code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        spacing: 24,
        children: [
          const SizedBox(height: 100),
          TextField(
            controller: code,
            decoration: const InputDecoration(hintText: "enter code"),
          ),
          TextButton(
            onPressed: () {
              //todo call resend email api
            },
            child: const Text('resend code'),
          ),
          FilledButton(
            onPressed: () {
              //todo call confirm code api
              //if code confirmed nav to reset password
            },
            child: const Text('confirm'),
          ),
        ],
      ),
    );
  }
}
