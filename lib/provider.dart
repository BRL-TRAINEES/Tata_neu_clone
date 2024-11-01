import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:tataneu_clone/models/item_model.dart';
import 'package:tataneu_clone/ItemsLists/item_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final navigationProvider =
    StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier();
});

class NavigationState {
  final bool isLogoVisible;
  final int pageIndex;

  NavigationState({
    required this.isLogoVisible,
    required this.pageIndex,
  });
}

class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier()
      : super(NavigationState(isLogoVisible: true, pageIndex: 0)) {
    _startLogoTimer();
    _startAutoSlide();
  }

  Timer? _logoTimer;
  Timer? _carouselTimer;

  void _startLogoTimer() {
    _logoTimer = Timer(const Duration(seconds: 3), () {
      print('Logo timer finished');
      state = NavigationState(isLogoVisible: false, pageIndex: state.pageIndex);
    });
  }

  void _startAutoSlide() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      print('Carousel slide to index: ${state.pageIndex}');
      state = NavigationState(
        isLogoVisible: false,
        pageIndex: (state.pageIndex + 1) % 3,
      );
    });
  }

  @override
  void dispose() {
    _logoTimer?.cancel();
    _carouselTimer?.cancel();
    super.dispose();
  }
}

//searchscreen provider
final searchTextProvider = StateProvider<String>((ref) => '');

final filteredItemsProvider = Provider<List<Item>>((ref) {
  final searchText = ref.watch(searchTextProvider).toLowerCase();
  final items = ref.watch(itemDataProvider);

  return items
      .where((item) => item.name.toLowerCase().contains(searchText))
      .toList();
});

final resetPasswordProvider = Provider((ref) => ResetPasswordService());

class ResetPasswordService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return null; // Indicates success
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for this email.';
      } else {
        return 'Something went wrong. Please try again.';
      }
    }
  }
}

final signupProvider = Provider((ref) => SignupService());

class SignupService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> signup(String username, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if (userCredential.user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': username,
          'email': email.trim(),
        });

        await userCredential.user?.sendEmailVerification();
        print("Verification email sent successfully.");
        return null;
      } else {
        throw Exception('User creation failed');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Weak password';
      } else if (e.code == 'email-already-in-use') {
        return 'An account exists with this email';
      } else {
        return 'Something went wrong. Please try again.';
      }
    }
  }
}
