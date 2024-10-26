import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigationProvider = StateNotifierProvider<NavigationNotifier ,bool>((ref){
  return NavigationNotifier();
});

class NavigationNotifier extends StateNotifier<bool> {
    NavigationNotifier() : super(false){
      _startTimer();
    }


void _startTimer() {
  Future.delayed(const Duration(seconds: 3),(){
      state = true;

  });
}
}