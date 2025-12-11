import 'package:flutter/material.dart';
import 'colors.dart';

class V9Layout {
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets cardPadding = EdgeInsets.all(20);
  static const double spacingS = 8;
  static const double spacingM = 16;
  static const double spacingL = 24;
  static const double radiusS = 16;
  static const double radiusM = 24;
  static const double radiusL = 32;
  static const double radiusXL = 50;
  static double cardHeight(BuildContext context) => MediaQuery.of(context).size.height * 0.58;
  static const double actionButtonSmall = 52;
  static const double actionButtonMedium = 60;
  static const double actionButtonLarge = 70;
  static const double bottomNavHeight = 70;
  static const double avatarSmall = 44;
  static const double avatarMedium = 60;
  static const double avatarLarge = 88;
}

class V9Scaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  const V9Scaffold({super.key, required this.body, this.appBar, this.bottomNavigationBar});
  @override
  Widget build(BuildContext context) => Scaffold(backgroundColor: V9Colors.background, appBar: appBar, body: body, bottomNavigationBar: bottomNavigationBar);
}

class V9Container extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const V9Container({super.key, required this.child, this.padding});
  @override
  Widget build(BuildContext context) => Container(padding: padding ?? V9Layout.cardPadding, decoration: BoxDecoration(color: V9Colors.surface, borderRadius: BorderRadius.circular(V9Layout.radiusL), boxShadow: V9Colors.softShadow), child: child);
}

class V9SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const V9SectionHeader({super.key, required this.title, this.trailing});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: V9Layout.spacingM), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(fontFamily: 'Nunito', fontSize: 18, fontWeight: FontWeight.w700, color: V9Colors.textPrimary)), if (trailing != null) trailing!]));
}

