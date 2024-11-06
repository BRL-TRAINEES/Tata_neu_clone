import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tataneu_clone/screens/homescreen.dart';

final googleSignInProvider =
    StateNotifierProvider<GoogleSignInNotifier, bool>((ref) {
  return GoogleSignInNotifier();
});

class GoogleSignInNotifier extends StateNotifier<bool> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  GoogleSignInNotifier() : super(false);

  Future<void> signInWithGoogle(BuildContext context) async {
    state = true;
    try {
      // Attempt to sign in with Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        state = false;
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Check for a valid access token and id token
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Failed to retrieve authentication tokens')),
        );
        state = false;
        return;
      }

      // Obtain the auth credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase using the Google credential
      await _auth.signInWithCredential(credential);

      // Navigate to the HomeScreen after successful sign-in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Homescreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign in failed: $e')),
      );
    } finally {
      state = false;
    }
  }
}

class GoogleSigninScreen extends ConsumerWidget {
  const GoogleSigninScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(googleSignInProvider);

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo or Image
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/google logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 150,
                  width: 150,
                ),
                const SizedBox(height: 20),

                if (isLoading)
                  const CircularProgressIndicator()
                else
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
                      onPressed: () {
                        ref
                            .read(googleSignInProvider.notifier)
                            .signInWithGoogle(context);
                      },
                      child: const Text(
                        'Sign in with Google',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                const SizedBox(height: 20),

                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
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
