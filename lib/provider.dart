import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

// Define the navigation provider
final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier();
});

// State class for navigation
class NavigationState {
  final bool isLogoVisible;
  final int pageIndex;

  NavigationState({
    required this.isLogoVisible,
    required this.pageIndex,
  });
}

// StateNotifier class to manage navigation state
class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier()
      : super(NavigationState(isLogoVisible: true, pageIndex: 0)) {
    _startLogoTimer();
    _startAutoSlide();
  }

  Timer? _logoTimer;
  Timer? _carouselTimer;

  // Timer for showing logo
  void _startLogoTimer() {
    _logoTimer = Timer(const Duration(seconds: 3), () {
      print('Logo timer finished'); // Debug print to track state change
      state = NavigationState(isLogoVisible: false, pageIndex: state.pageIndex);
    });
  }

  // Auto slide timer for the carousel
  void _startAutoSlide() {
    _carouselTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      print('Carousel slide to index: ${state.pageIndex}'); // Debug print to track page index
      state = NavigationState(
        isLogoVisible: false, // Ensure logo is hidden
        pageIndex: (state.pageIndex + 1) % 3, // Adjust this to match your number of images
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
