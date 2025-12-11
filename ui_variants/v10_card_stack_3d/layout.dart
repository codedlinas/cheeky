import 'package:flutter/material.dart';
import 'colors.dart';

class V10Layout {
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(horizontal: 20);
  static const EdgeInsets cardPadding = EdgeInsets.all(20);
  static const double spacingS = 8;
  static const double spacingM = 16;
  static const double spacingL = 24;
  static const double radiusS = 10;
  static const double radiusM = 14;
  static const double radiusL = 20;
  static const double radiusXL = 28;
  static double cardHeight(BuildContext context) => MediaQuery.of(context).size.height * 0.62;
  static const double actionButtonSmall = 50;
  static const double actionButtonMedium = 58;
  static const double actionButtonLarge = 68;
  static const double bottomNavHeight = 66;
  static const double avatarSmall = 42;
  static const double avatarMedium = 56;
  static const double avatarLarge = 84;
}

class V10Scaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  const V10Scaffold({super.key, required this.body, this.appBar, this.bottomNavigationBar});
  @override
  Widget build(BuildContext context) => Scaffold(backgroundColor: V10Colors.background, extendBody: true, appBar: appBar, body: body, bottomNavigationBar: bottomNavigationBar);
}

class V10Container extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const V10Container({super.key, required this.child, this.padding});
  @override
  Widget build(BuildContext context) => Container(padding: padding ?? V10Layout.cardPadding, decoration: BoxDecoration(color: V10Colors.surface, borderRadius: BorderRadius.circular(V10Layout.radiusL), boxShadow: V10Colors.depth3d), child: child);
}

class V10SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  const V10SectionHeader({super.key, required this.title, this.trailing});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: V10Layout.spacingM), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(title, style: const TextStyle(fontFamily: 'Space Grotesk', fontSize: 20, fontWeight: FontWeight.w600, color: V10Colors.textPrimary)), if (trailing != null) trailing!]));
}

