import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tataneu_clone/models/item_model.dart';
import 'package:tataneu_clone/ItemsLists/item_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Navigation provider
final navigationProvider =
    StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier();
});

// Navigation state
class NavigationState {
  final bool isLogoVisible; // This can be useful if you want to show/hide a logo
  final int pageIndex; // Currently selected index for bottom navigation

  NavigationState({
    required this.isLogoVisible,
    required this.pageIndex,
  });
}

// Navigation notifier
class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier()
      : super(NavigationState(isLogoVisible: true, pageIndex: 0)) {
    _startLogoTimer();
    // Removed automatic slide functionality
  }

  Timer? _logoTimer;
  Timer? _autoSlideTimer;

  void _startLogoTimer() {
    _logoTimer = Timer(const Duration(seconds: 3), () {
      print('Logo timer finished');
      state = NavigationState(isLogoVisible: false, pageIndex: state.pageIndex);
      _startAutoSlide();
    });
  }

  // Automatic slide between pages
  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      final nextIndex = (state.pageIndex + 1) % 5; //%5 for 5 pages
      state = NavigationState(
        isLogoVisible: state.isLogoVisible,
        pageIndex: nextIndex,
      );
    });
  }

  // Set the page index based on user interaction
  void setPageIndex(int index) {
    state = NavigationState(isLogoVisible: false, pageIndex: index);
  }

  @override
  void dispose() {
    _logoTimer?.cancel();
    _autoSlideTimer?.cancel();
    super.dispose();
  }
}

// Profile page providers
final usernameProvider = StateProvider<String>((ref) => '');
final emailProvider = StateProvider<String>((ref) => '');
final profileImageProvider = StateProvider<File?>((ref) => null);

final usernameControllerProvider = Provider((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

final emailControllerProvider = Provider((ref) {
  final controller = TextEditingController();
  ref.onDispose(controller.dispose);
  return controller;
});

// Search screen providers
final searchTextProvider = StateProvider<String>((ref) => '');

// Filtered items provider
final filteredItemsProvider = Provider<List<Item>>((ref) {
  final searchText = ref.watch(searchTextProvider).toLowerCase();
  final items = ref.watch(itemDataProvider);

  return items
      .where((item) => item.name.toLowerCase().contains(searchText))
      .toList();
});

// Reset password provider
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

// Signup provider
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
