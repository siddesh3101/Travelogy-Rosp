import 'dart:io';
import 'dart:ui';

import 'package:coep/pages/studio_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../enums/show_case_enum.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen(
      {super.key, this.showCaseState, required this.onShowIntro});
  final ShowCaseState? showCaseState;
  final Function(Rect?, ShowCaseState?) onShowIntro;

  @override
  State<CreateScreen> createState() => CreateScreenState();
}

class CreateScreenState extends State<CreateScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<StudioWidgetState> _studioWidgetKey =
      GlobalKey<StudioWidgetState>();

  final _ctaKey = GlobalKey();
  bool _ctaVisible = false;
  void setCTAVisibility(bool visible) {
    if (mounted && _ctaVisible != visible) {
      setState(() {
        _ctaVisible = visible;
      });
    }
  }

  Future<void> _showScrollAnimation() async {
    await Future.delayed(const Duration(seconds: 1));
    await _scrollController.animateTo(
      250,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          RawScrollbar(
            controller: _scrollController,
            child: CTAVisibilityListener(
              ctaKey: _ctaKey,
              onVisibilityChange: setCTAVisibility,
              child: SingleChildScrollView(
                physics: widget.showCaseState != null
                    ? const NeverScrollableScrollPhysics()
                    : null,
                keyboardDismissBehavior: Platform.isIOS
                    ? ScrollViewKeyboardDismissBehavior.onDrag
                    : ScrollViewKeyboardDismissBehavior.manual,
                controller: _scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StudioWidget(
                      key: _studioWidgetKey,
                      onShowIntro: widget.onShowIntro,
                      showScrollIntro: _showScrollAnimation,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}

class CTAVisibilityListener extends StatelessWidget {
  final GlobalKey<State> ctaKey;
  final Widget child;
  final Function(bool) onVisibilityChange;

  const CTAVisibilityListener(
      {Key? key,
      required this.ctaKey,
      required this.child,
      required this.onVisibilityChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      child: child,
      onNotification: (ScrollNotification scroll) {
        var currentContext = ctaKey.currentContext;
        if (currentContext == null) return false;

        if (scroll.metrics.axisDirection == AxisDirection.left ||
            scroll.metrics.axisDirection == AxisDirection.right) return false;

        var renderObject = currentContext.findRenderObject()!;
        RenderAbstractViewport? viewport =
            RenderAbstractViewport.of(renderObject);
        var offsetToRevealBottom =
            viewport.getOffsetToReveal(renderObject, 1.0);
        if (offsetToRevealBottom.offset > scroll.metrics.pixels) {
          onVisibilityChange(true);
        } else {
          onVisibilityChange(false);
        }
        return false;
      },
    );
  }
}
