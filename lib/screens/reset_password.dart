import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneu_clone/provider.dart';

class ResetPasswordScreen extends ConsumerWidget {
  ResetPasswordScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    Future<void> _resetPassword() async {
      if (_formKey.currentState?.validate() ?? false) {
        final resetPasswordService = ref.read(resetPasswordProvider);
        final message = await resetPasswordService.sendPasswordResetEmail(
          _emailController.text,
        );

        if (message == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password reset link sent. Please check your email.'),
            ),
          );
          Navigator.of(context).pop();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message)),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/pic_reg.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 20),
                
                // Email input field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Enter your email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('.') || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Reset Password button
                ElevatedButton(
                  onPressed: _resetPassword,
                  child: const Text('Reset Password'),
                ),
                
                // Back to Sign In button
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Back to Sign In"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
