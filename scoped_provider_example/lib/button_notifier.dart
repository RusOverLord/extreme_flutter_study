import 'package:hooks_riverpod/hooks_riverpod.dart';

final buttonStateScopedProvider = ScopedProvider<ButtonState>(
      (ref) => throw UnimplementedError(),
);

final buttonNotifierScopedProvider = ScopedProvider<ButtonNotifier>(
      (ref) => throw UnimplementedError(),
);

final buttonNotifierProvider = StateNotifierProvider.autoDispose.family<ButtonNotifier, ButtonState, int>(
  (ref, index) => ButtonNotifier(0),
);

class ButtonNotifier extends StateNotifier<ButtonState> {
  int tapsNumber;

  ButtonNotifier(this.tapsNumber) : super(ButtonState.fromInt(tapsNumber));

  void onTap() {
    tapsNumber++;
    state = ButtonState.fromInt(tapsNumber);
  }
}

class ButtonState {
  final String tapsNumber;

  const ButtonState(this.tapsNumber);

  ButtonState.fromInt(int tapsNumber) : tapsNumber = tapsNumber.toString();
}
