enum ShowCaseArrowType { up, down }

extension ShowCaseArrowTypeExtension on ShowCaseArrowType {
  String get asset {
    switch (this) {
      case ShowCaseArrowType.up:
        return 'ic_hand_up.png';
      case ShowCaseArrowType.down:
        return 'ic_hand_down.png';
    }
  }
}
