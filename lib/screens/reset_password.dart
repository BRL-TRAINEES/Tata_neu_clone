import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneu_clone/provider.dart';

class ResetPasswordScreen extends ConsumerWidget {
  ResetPasswordScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> resetPassword() async {
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF5B2B91),
              Color(0xFFC22B8E),
              Color(0xFFF66C22), 
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Tata Neu logo at the center above the input field
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/tata neu logo.png'),  
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 150, 
                    width: 150, 
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

                  // Reset Password button with gradient
                  Container(
                    width: double.infinity, 
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF5B2B91), 
                          Color(0xFFC22B8E),
                          Color(0xFFF66C22),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, 
                        shadowColor: Colors.transparent, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: resetPassword,
                      child: const Text(
                        'Reset Password',
                        style: TextStyle(color: Colors.white), 
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

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
      ),
    );
  }
}
