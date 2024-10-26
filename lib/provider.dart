import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';


final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
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
