import 'show_case_arrow_type_enum.dart';

enum ShowCaseState { prompt, describe, styles, cta }

extension ShowCaseEnumExtension on ShowCaseState {
  String get title {
    switch (this) {
      case ShowCaseState.prompt:
        return "Enter URL/Text";
      case ShowCaseState.describe:
        return "Enter Prompt";
      case ShowCaseState.styles:
        return "Choose Style";
      case ShowCaseState.cta:
        return "Start Creating";
    }
  }

  String get desc {
    switch (this) {
      case ShowCaseState.prompt:
        return "Enter the text or URL for which the QR Code is to be generated ";
      case ShowCaseState.describe:
        return "The artwork will be inspired by your prompt";
      case ShowCaseState.styles:
        return "Select unique styles for the artistic QR";
      case ShowCaseState.cta:
        return "Start the creation and modify colour, background, frame as required.";
    }
  }

  ShowCaseArrowType get arrowType {
    switch (this) {
      case ShowCaseState.prompt:
        return ShowCaseArrowType.up;
      case ShowCaseState.describe:
        return ShowCaseArrowType.up;
      case ShowCaseState.styles:
        return ShowCaseArrowType.down;
      case ShowCaseState.cta:
        return ShowCaseArrowType.down;
    }
  }

  int get step {
    switch (this) {
      case ShowCaseState.prompt:
        return 1;
      case ShowCaseState.describe:
        return 2;
      case ShowCaseState.styles:
        return 3;
      case ShowCaseState.cta:
        return 4;
    }
  }

  String get eventLabel {
    switch (this) {
      case ShowCaseState.prompt:
        return 'EnteredPrompt';
      case ShowCaseState.describe:
        return 'EnteredDescription';
      case ShowCaseState.styles:
        return 'SelectedStyles';
      case ShowCaseState.cta:
        return 'ClickedOnCreate';
    }
  }
}
