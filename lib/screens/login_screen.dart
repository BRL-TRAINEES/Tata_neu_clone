import 'package:firebase_auth/firebase_auth.dart';
import 'package:tataneu_clone/screens/homescreen.dart';
import 'reset_password.dart';
import 'signup_scree.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final signInProviderInstance = ref.read(signInProvider);

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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100, top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 50),
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
                      color: Colors.transparent,
                      image: const DecorationImage(
                        image: AssetImage('assets/images/tata neu logo.png'),
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
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            obscureText: !_isPasswordVisible,
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
                        // Forgot Password button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 40),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
                                  );
                                },
                                child: const Text('Forgot Password'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Sign In button 
                        Container(
                          width: 270, 
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
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent, 
                              shadowColor: Colors.transparent, 
                            ),
                            onPressed: () async {
                              final errorMessage = await signInProviderInstance.signIn(context);
                              if (errorMessage == null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Homescreen()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(errorMessage)),
                                );
                              }
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Sign in with Google button 
                        Container(
                          width: 270, 
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
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const GoogleSigninScreen()),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              
                              children:  [Padding(padding: EdgeInsets.only(left: 20),
                              child:   Image.asset("assets/images/google logo.png"
                                , 
                                height: 50,
                                width: 50,),
                              ),
                                Text(
                                  'Sign in with Google',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), 
                                ),
                              
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        // Sign Up Button
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const SignupScreen()),
                            );
                          },
                          child: const Text("Don't have an account? Sign up"),
                        ),
                      ],
                    ),
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
