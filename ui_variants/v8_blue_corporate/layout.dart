import 'package:flutter/material.dart';
import 'colors.dart';
import 'fonts.dart';

class V8Layout {
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets cardPadding = EdgeInsets.all(16);
  static const double spacingS = 8;
  static const double spacingM = 16;
  static const double spacingL = 24;
  static const double radiusS = 4;
  static const double radiusM = 8;
  static const double radiusL = 12;
  static double cardHeight(BuildContext context) => MediaQuery.of(context).size.height * 0.58;
  static const double actionButtonSmall = 44;
  static const double actionButtonMedium = 52;
  static const double actionButtonLarge = 60;
  static const double bottomNavHeight = 56;
  static const double avatarSmall = 36;
  static const double avatarMedium = 48;
  static const double avatarLarge = 72;
}

class V8Scaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  const V8Scaffold({super.key, required this.body, this.appBar, this.bottomNavigationBar});
  @override
  Widget build(BuildContext context) => Scaffold(backgroundColor: V8Colors.background, appBar: appBar, body: body, bottomNavigationBar: bottomNavigationBar);
}

class V8Container extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const V8Container({super.key, required this.child, this.padding});
  @override
  Widget build(BuildContext context) => Container(padding: padding ?? V8Layout.cardPadding, decoration: BoxDecoration(color: V8Colors.surface, borderRadius: BorderRadius.circular(V8Layout.radiusS), border: Border.all(color: V8Colors.border)), child: child);
}

class V8SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const V8SectionHeader({super.key, required this.title, this.trailing});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: V8Layout.spacingM), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: V8Fonts.headlineMedium), if (trailing != null) trailing!]));
}

