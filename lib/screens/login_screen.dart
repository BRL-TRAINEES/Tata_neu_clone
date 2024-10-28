import 'package:firebase_auth/firebase_auth.dart';
import 'reset_password.dart';
import 'signup_scree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tataneu_clone/main.dart';
import 'googlesignin.dart';


final signInProvider = Provider((ref) => SignInProvider());

class SignInProvider {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<String?> signIn(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        if (userCredential.user?.emailVerified ?? false) {
          return null; 
        } else {
          await FirebaseAuth.instance.signOut();
          return 'Please verify your mail before signing in';
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          return 'No user found for this email';
        } else if (e.code == 'wrong-password') {
          return 'Wrong password';
        } else {
          return 'Something went wrong. Please try again';
        }
      }
    }
    return null;
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}

class SigninScreen extends ConsumerWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    final signInProviderInstance = ref.read(signInProvider);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200.0),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/pic reg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 20),
              Form(
                key: signInProviderInstance.formKey,
                child: Column(
                  children: [
                    // Email input
                    Container(
                      width: 300,
                      child: TextFormField(
                        controller: signInProviderInstance.emailController,
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
                    ),
                    const SizedBox(height: 20),
                    // Password input
                    Container(
                      width: 300,
                      child: TextFormField(
                        controller: signInProviderInstance.passwordController,
                        decoration: InputDecoration(
                          labelText: 'Enter Your Password',
                          prefixIcon: const Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
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
                          if (!RegExp(r'[A-Z]').hasMatch(value)) {
                            return 'Password requires at least one uppercase letter';
                          }
                          if (!RegExp(r'[a-z]').hasMatch(value)) {
                            return 'Password must contain at least one lowercase letter';
                          }
                          if (!RegExp(r'[0-9]').hasMatch(value)) {
                            return 'Password must contain at least one digit';
                          }
                          if (!RegExp('[!@#%\\\$^&*(),.?":{}|<>]').hasMatch(value)) {
                            return 'Password must contain at least one special character';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Sign In button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final errorMessage = await signInProviderInstance.signIn(context);
                            if (errorMessage == null) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const MainScreen()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(errorMessage)),
                              );
                            }
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        // Forgot Password button
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                            );
                          },
                          child: const Text('Forgot Password'),
                        ),
                      ],
                    ),
                    // Sign Up prompt
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const SignupScreen()),
                        );
                      },
                      child: const Text("Don't have an account? Sign up"),
                    ),
                    const SizedBox(height: 20.0),
                    // Google Sign-In button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const GoogleSigninScreen()),
                        );
                      },
                      child: const Text('Sign in with Google'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
