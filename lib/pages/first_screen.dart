import 'dart:ui';

import 'package:coep/pages/create_screen.dart';
import 'package:flutter/material.dart';

import '../enums/show_case_arrow_type_enum.dart';
import '../enums/show_case_enum.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Rect? _rect;
  bool _isKeyboardVisible = false;
  final GlobalKey<CreateScreenState> _createKey = GlobalKey();

  ShowCaseState? _showCaseState;

  onShowIntro(Rect? rect, ShowCaseState? showCaseState) {
    _rect = rect;
    _showCaseState = showCaseState;
    setState(() {});
    if (_rect == null && _showCaseState == null) {
      // _requestNotificationPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        body: CreateScreen(
          key: _createKey,
          onShowIntro: onShowIntro,
          showCaseState: _showCaseState,
        ),
      ),
      if (_rect != null)
        Positioned.fill(
          child: ClipPath(
            clipper: _CustomClipper(_rect!),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 8.0,
                sigmaY: 8.0,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.75),
              ),
            ),
          ),
        ),
      if (_rect != null && _showCaseState != null)
        Positioned(
          top: _showCaseState!.arrowType == ShowCaseArrowType.up
              ? _rect!.bottom
              : null,
          bottom: _showCaseState!.arrowType == ShowCaseArrowType.down
              ? MediaQuery.of(context).size.height - _rect!.top
              : null,
          left: 0,
          right: 0,
          child: ShowcaseDescriptionWidget(
            showCaseState: _showCaseState!,
          ),
        ),
    ]);
  }
}

class _CustomClipper extends CustomClipper<Path> {
  final Rect rect;

  _CustomClipper(this.rect);

  @override
  Path getClip(Size size) {
    final path = Path();
    final pathEntireArea = Path();
    pathEntireArea.addRect(Offset.zero & size);
    //Extra padding around the widget while clipping
    path.addRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(12)),
    ); // Add the entire area
    return Path.combine(
      PathOperation.difference,
      pathEntireArea,
      path,
    ); // Take the difference between the two paths
  }

  @override
  bool shouldReclip(_CustomClipper oldClipper) {
    return true;
  }
}

class ShowcaseDescriptionWidget extends StatefulWidget {
  final ShowCaseState showCaseState;

  const ShowcaseDescriptionWidget({
    super.key,
    required this.showCaseState,
  });

  @override
  State<ShowcaseDescriptionWidget> createState() =>
      _ShowcaseDescriptionWidgetState();
}

class _ShowcaseDescriptionWidgetState extends State<ShowcaseDescriptionWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _animation = Tween<double>(begin: -15.0, end: 15.0).animate(_controller);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.dismissed:
          _controller.forward();
          break;
        case AnimationStatus.completed:
          _controller.reverse();
          break;
        default:
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final appTheme = context.appTheme;
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.translate(
              offset: Offset(0, _animation.value),
              child: Image.asset(
                "assets/${widget.showCaseState.arrowType.asset}",
                height: 70,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // const GapBox(gap: Gap.xs),
            Text(
              "Step ${widget.showCaseState.step}",
              // style: Styles.ts700Xxs.copyWith(
              //   color: appTheme.colorTextPrimary,
              // ),
            ),
            Text(
              widget.showCaseState.title,
              // style: Styles.ts700Xxs.copyWith(
              //   color: appTheme.colorTextPrimary,
              // ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.showCaseState.desc,
              // style: Styles.ts500Xxxxs.copyWith(
              //   color: appTheme.colorTextPrimary,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
