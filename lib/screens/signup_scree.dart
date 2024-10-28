import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneu_clone/provider.dart';
import 'package:tataneu_clone/screens/login_screen.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    Future<void> _signup() async {
      if (_formKey.currentState?.validate() ?? false) {
        // Use ref.read to access the signup provider
        final signupService = ref.read(signupProvider);
        
        final String? result = await signupService.signup(
          _usernameController.text.trim(),
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

        if (result != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result)),
          );
        } else {
          
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SigninScreen()),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Username field
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Email field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Password field
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Minimum 8 characters required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),

               
                ElevatedButton(
                  onPressed: _signup,
                  child: const Text('Sign Up'),
                ),
                const SizedBox(height: 20.0),

                
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); 
                  },
                  child: const Text("Already have an account? Sign in"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
