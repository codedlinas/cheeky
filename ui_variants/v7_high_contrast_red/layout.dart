import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

class V7Layout {
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets cardPadding = EdgeInsets.all(16);
  static const double spacingS = 8;
  static const double spacingM = 16;
  static const double spacingL = 24;
  static const double radiusS = 0;
  static const double radiusM = 0;
  static const double radiusL = 4;
  static double cardHeight(BuildContext context) => MediaQuery.of(context).size.height * 0.6;
  static const double actionButtonSmall = 48;
  static const double actionButtonMedium = 56;
  static const double actionButtonLarge = 64;
  static const double bottomNavHeight = 60;
  static const double avatarSmall = 40;
  static const double avatarMedium = 56;
  static const double avatarLarge = 80;
}

class V7Scaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;

  const V7Scaffold({super.key, required this.body, this.appBar, this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: V7Colors.background, appBar: appBar, body: body, bottomNavigationBar: bottomNavigationBar);
  }
}

class V7Container extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const V7Container({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? V7Layout.cardPadding,
      decoration: BoxDecoration(color: V7Colors.surface, border: Border.all(color: V7Colors.textPrimary, width: 2)),
      child: child,
    );
  }
}

class V7SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const V7SectionHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: V7Layout.spacingM),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title.toUpperCase(), style: V7Fonts.headlineMedium), if (trailing != null) trailing!],
      ),
    );
  }
}

