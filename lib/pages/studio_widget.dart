import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:coep/widget/describe_your_prompt.dart';

import '../enums/show_case_enum.dart';
import '../main.dart';
import '../widget/custom_type_widget.dart';
import '../widget/select_style.dart';

class StudioWidget extends StatefulWidget {
  const StudioWidget({super.key, this.onShowIntro, this.showScrollIntro});

  final Function(Rect? rect, ShowCaseState? showcase)? onShowIntro;
  final VoidCallback? showScrollIntro;

  @override
  State<StudioWidget> createState() => StudioWidgetState();
}

class StudioWidgetState extends State<StudioWidget> {
  final GlobalKey<_AiCreationWidgetState> _artCreationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AiCreationWidget(
          key: _artCreationKey,
          onShowIntro: widget.onShowIntro,
        )
      ],
    );
  }
}

class AiCreationWidget extends StatefulWidget {
  const AiCreationWidget({
    super.key,
    this.onShowIntro,
  });
  final Function(Rect? rect, ShowCaseState? showcase)? onShowIntro;

  @override
  State<AiCreationWidget> createState() => _AiCreationWidgetState();
}

class _AiCreationWidgetState extends State<AiCreationWidget> {
  bool get _isTutorialActive => _tutorialState != null;
  ShowCaseState? _tutorialState;
  final GlobalKey _ctaAreaKey = GlobalKey();
  final GlobalKey _selectStyleAreaKey = GlobalKey();
  final GlobalKey<TypeWidgetState> _artFieldKey = GlobalKey<TypeWidgetState>();
  final GlobalKey<DescribePromptState> _describeFieldKey =
      GlobalKey<DescribePromptState>();
  void _removeShowcase() {
    widget.onShowIntro!(null, null);
    // PrefUtils.setTutorialDone();
  }

  // final GlobalKey _aspectRatioAreaKey = GlobalKey();
  _nextStepIfApplicable(ShowCaseState? showCaseState,
      {bool isSuggestions = false}) {
    if (showCaseState == null) return;
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (!isSuggestions) {
        // AnalyticsManager.instance
        //     .recordOnboardingEvent(showCaseState.eventLabel);
      } else {
        // AnalyticsManager.instance.recordOnboardingEvent('PromptSelected');
      }
      switch (showCaseState) {
        case ShowCaseState.prompt:
          _tutorialState = ShowCaseState.describe;
          setState(() {});
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            _showOnly(_describeFieldKey, _tutorialState!);
          });
          break;
        case ShowCaseState.describe:
          _tutorialState = ShowCaseState.styles;
          setState(() {});
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            _showOnly(_selectStyleAreaKey, _tutorialState!);
          });
          break;
        case ShowCaseState.styles:
          Scrollable.ensureVisible(
            _ctaAreaKey.currentContext!,
            alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
          );
          _tutorialState = ShowCaseState.cta;
          _showOnly(_ctaAreaKey, _tutorialState!);
          break;
        case ShowCaseState.cta:
          _tutorialState = null;
          _removeShowcase();
          break;
      }
    });
  }

  void _showOnly(GlobalKey widgetKey, ShowCaseState showcase) {
    RenderBox renderBox =
        widgetKey.currentContext!.findRenderObject() as RenderBox;
    Offset topLeftPosition = renderBox.localToGlobal(Offset.zero);
    Size widgetSize = renderBox.size;
    Rect widgetRect = Rect.fromLTWH(topLeftPosition.dx, topLeftPosition.dy,
        widgetSize.width, widgetSize.height);
    widget.onShowIntro!(widgetRect, showcase);
    setState(() {});
  }

  void _checkInternet() async {
    // bool hasInternet = await ConnectivityHelper.instance.hasInternet;

    if (currentUser.isOnboardingSession && widget.onShowIntro != null) {
      if (true) {
        SchedulerBinding.instance.addPostFrameCallback(
          (timeStamp) => _startTutorial(),
        );
      }
    }
    // if (!hasInternet) {
    //   AppToast.showToast('No Internet Connection');
    // }
  }

  void _startTutorial() async {
    if (Platform.isIOS) {
      showDialog(
        context: context,
        builder: (context) => const SizedBox.expand(),
        barrierDismissible: false,
        barrierColor: Colors.transparent,
      );
      await Future.delayed(const Duration(seconds: 1));
      Navigator.of(context).pop();
      Timer timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        setState(() {});
      });
      Future.delayed(const Duration(seconds: 3), () {
        timer.cancel();
      });
    }
    _tutorialState = ShowCaseState.prompt;
    _showOnly(_artFieldKey, ShowCaseState.prompt);
  }

  @override
  void initState() {
    // TODO: implement initState
    _checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.center,
      children: [
        Column(
          children: [
            // SizedBox(
            //   height: 500,
            // ),
            FocusScope(
              child: Focus(
                onFocusChange: (_focus) {
                  if (_focus) {}
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TypeWidget(
                    key: _artFieldKey,
                    isIntro: _isTutorialActive,
                    onSubmit: () {
                      if (_isTutorialActive) {
                        _nextStepIfApplicable(_tutorialState);
                      }
                    },
                    onTextChanged: () {
                      if (_isTutorialActive) {
                        _showOnly(_artFieldKey, ShowCaseState.prompt);
                      }
                    },
                  ),
                ),
              ),
            ),
            FocusScope(
              child: Focus(
                onFocusChange: (_focus) {
                  if (_focus) {}
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DescribePrompt(
                    key: _describeFieldKey,
                    isIntro: _isTutorialActive,
                    onSubmit: () {
                      if (_isTutorialActive) {
                        _nextStepIfApplicable(_tutorialState);
                      }
                    },
                    onTextChanged: () {
                      if (_isTutorialActive) {
                        _showOnly(_artFieldKey, ShowCaseState.prompt);
                      }
                    },
                  ),
                ),
              ),
            ),

            Visibility(
              visible: _isTutorialActive && _tutorialState != ShowCaseState.cta,
              child: Align(
                alignment: Alignment.center,
                child: IgnorePointer(
                  ignoring: _tutorialState != ShowCaseState.styles,
                  child: AnimatedOpacity(
                    opacity: _tutorialState == ShowCaseState.styles ? 1 : 0,
                    duration: const Duration(milliseconds: 500),
                    child: SelectStyle(
                      key: _selectStyleAreaKey,
                      stylesList: onboardingStyles,
                      onStyleSelected: (style) {
                        print("hi");
                        _nextStepIfApplicable(_tutorialState);
                      },

                      // key: _selectStyleAreaKey,
                      // onSubmit: () {

                      // },
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: 362,
            // ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                decoration: _isTutorialActive
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        // border: GradientBoxBorder(
                        //   gradient: appTheme.linearGradientBluish,
                        //   width: 1,
                        // ),
                      )
                    : null,
                padding: _isTutorialActive ? const EdgeInsets.all(4) : null,
                child: PrimaryButton(
                    key: _ctaAreaKey, onPressed: () {}, text: 'Create QR'),
              ),
            )
          ],
        ),
      ],
    );
  }
}

const Map<String, String> _imagineData = {
  '3D Render': '3d_render.jpeg',
  'Anime Girl': 'anime_girl.jpeg',
  'Anime': 'anime_man.jpeg',
  'Baroque': 'baroque.jpeg',
  'Mural': 'mural.jpeg',
  'Steampunk': 'steampunk_imagine.jpeg',
  'Studio Lighting': 'studio_lighting.jpeg',
  'Visual Novel': 'magical_academy.jpeg',
  'Authentic': 'authentic.jpeg',
};

List<dynamic> get onboardingStyles {
  List<dynamic> styles = [];
  for (var element in _imagineData.entries) {
    styles.add(OnboardArtStyle(name: element.key, assetPath: element.value));
  }
  return styles;
}

class OnboardArtStyle {
  final String name;
  final String assetPath;
  OnboardArtStyle({
    required this.name,
    required this.assetPath,
  });
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool hasImage;
  final String? imagePath;

  const PrimaryButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.hasImage = false,
      this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Color(0xff4E459B),
          fixedSize: Size(
            MediaQuery.of(context).size.width,
            50,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasImage) ...[
              Image(
                image: AssetImage(imagePath!),
                height: 20,
                width: 20,
              ),
              SizedBox(
                width: 5,
              ),
            ],
            Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ));
  }
}
