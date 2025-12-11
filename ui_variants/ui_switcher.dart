/// Cheeky UI Variant Switcher
/// 
/// This file allows developers to easily switch between different UI variants
/// for preview and testing purposes.
/// 
/// Usage:
/// 1. Import this file in your main.dart or preview file
/// 2. Set [activeVariant] to the desired UIVariant enum value
/// 3. Use [getActiveTheme()] to get the theme for the active variant
/// 
/// IMPORTANT: This file does NOT modify core app logic or runtime state.

import 'package:flutter/material.dart';

// Import all variant themes
import 'v1_classic_tinder/theme.dart' as v1;
import 'v2_modern_glassblur/theme.dart' as v2;
import 'v3_dark_neon/theme.dart' as v3;
import 'v4_minimal_soft/theme.dart' as v4;
import 'v5_luxury_gold_black/theme.dart' as v5;
import 'v6_playful_pastel/theme.dart' as v6;
import 'v7_high_contrast_red/theme.dart' as v7;
import 'v8_blue_corporate/theme.dart' as v8;
import 'v9_rounded_bubbles/theme.dart' as v9;
import 'v10_card_stack_3d/theme.dart' as v10;

/// Enum representing all available UI variants
enum UIVariant {
  /// V1: Classic Tinder - Card stack with slide left/right, subtle tilt
  v1ClassicTinder,
  
  /// V2: Modern Glassblur - Glassmorphism with blur, elastic animations
  v2ModernGlassblur,
  
  /// V3: Dark Neon - Dark mode neon borders, pulse animations
  v3DarkNeon,
  
  /// V4: Minimal Soft - Minimalistic, straight-flat card slide, no rotation
  v4MinimalSoft,
  
  /// V5: Luxury Gold Black - Premium slow-easing swipe with gold highlight
  v5LuxuryGoldBlack,
  
  /// V6: Playful Pastel - Playful exaggerated bounce + pastel gradients
  v6PlayfulPastel,
  
  /// V7: High Contrast Red - High contrast harsh snap animation + sharp shadows
  v7HighContrastRed,
  
  /// V8: Blue Corporate - Corporate blue swipe, Microsoft-like motion curves
  v8BlueCorporate,
  
  /// V9: Rounded Bubbles - Bubble rounded shapes + spring physics
  v9RoundedBubbles,
  
  /// V10: Card Stack 3D - 3D perspective swipe (rotation on Z/Y axis)
  v10CardStack3D,
}

/// ============================================
/// CHANGE THIS TO SWITCH THE ACTIVE UI VARIANT
/// ============================================
const UIVariant activeVariant = UIVariant.v1ClassicTinder;

/// Get the theme data for the currently active variant
ThemeData getActiveTheme() {
  switch (activeVariant) {
    case UIVariant.v1ClassicTinder:
      return v1.V1Theme.theme;
    case UIVariant.v2ModernGlassblur:
      return v2.V2Theme.theme;
    case UIVariant.v3DarkNeon:
      return v3.V3Theme.theme;
    case UIVariant.v4MinimalSoft:
      return v4.V4Theme.theme;
    case UIVariant.v5LuxuryGoldBlack:
      return v5.V5Theme.theme;
    case UIVariant.v6PlayfulPastel:
      return v6.V6Theme.theme;
    case UIVariant.v7HighContrastRed:
      return v7.V7Theme.theme;
    case UIVariant.v8BlueCorporate:
      return v8.V8Theme.theme;
    case UIVariant.v9RoundedBubbles:
      return v9.V9Theme.theme;
    case UIVariant.v10CardStack3D:
      return v10.V10Theme.theme;
  }
}

/// Get the theme data for a specific variant
ThemeData getThemeForVariant(UIVariant variant) {
  switch (variant) {
    case UIVariant.v1ClassicTinder:
      return v1.V1Theme.theme;
    case UIVariant.v2ModernGlassblur:
      return v2.V2Theme.theme;
    case UIVariant.v3DarkNeon:
      return v3.V3Theme.theme;
    case UIVariant.v4MinimalSoft:
      return v4.V4Theme.theme;
    case UIVariant.v5LuxuryGoldBlack:
      return v5.V5Theme.theme;
    case UIVariant.v6PlayfulPastel:
      return v6.V6Theme.theme;
    case UIVariant.v7HighContrastRed:
      return v7.V7Theme.theme;
    case UIVariant.v8BlueCorporate:
      return v8.V8Theme.theme;
    case UIVariant.v9RoundedBubbles:
      return v9.V9Theme.theme;
    case UIVariant.v10CardStack3D:
      return v10.V10Theme.theme;
  }
}

/// Get human-readable name for a variant
String getVariantName(UIVariant variant) {
  switch (variant) {
    case UIVariant.v1ClassicTinder:
      return 'V1: Classic Tinder';
    case UIVariant.v2ModernGlassblur:
      return 'V2: Modern Glassblur';
    case UIVariant.v3DarkNeon:
      return 'V3: Dark Neon';
    case UIVariant.v4MinimalSoft:
      return 'V4: Minimal Soft';
    case UIVariant.v5LuxuryGoldBlack:
      return 'V5: Luxury Gold & Black';
    case UIVariant.v6PlayfulPastel:
      return 'V6: Playful Pastel';
    case UIVariant.v7HighContrastRed:
      return 'V7: High Contrast Red';
    case UIVariant.v8BlueCorporate:
      return 'V8: Blue Corporate';
    case UIVariant.v9RoundedBubbles:
      return 'V9: Rounded Bubbles';
    case UIVariant.v10CardStack3D:
      return 'V10: Card Stack 3D';
  }
}

/// Get description for a variant
String getVariantDescription(UIVariant variant) {
  switch (variant) {
    case UIVariant.v1ClassicTinder:
      return 'Classic card stack with slide left/right and subtle tilt. Uses SF Pro/Inter fonts.';
    case UIVariant.v2ModernGlassblur:
      return 'Glassmorphism with blur effects and elastic animations. Uses Poppins/Sora fonts.';
    case UIVariant.v3DarkNeon:
      return 'Dark mode with neon borders and pulse animations. Uses Orbitron/Rajdhani fonts.';
    case UIVariant.v4MinimalSoft:
      return 'Clean minimalistic design with straight-flat card slide. Uses Nunito/Roboto fonts.';
    case UIVariant.v5LuxuryGoldBlack:
      return 'Premium design with slow-easing swipes and gold highlights. Uses Playfair Display/Inter fonts.';
    case UIVariant.v6PlayfulPastel:
      return 'Fun and playful with exaggerated bounces and pastel gradients. Uses Quicksand/Fredoka fonts.';
    case UIVariant.v7HighContrastRed:
      return 'Bold and aggressive with harsh snap animations. Uses Montserrat ExtraBold.';
    case UIVariant.v8BlueCorporate:
      return 'Professional corporate design with Microsoft-like motion. Uses Segoe UI/Inter fonts.';
    case UIVariant.v9RoundedBubbles:
      return 'Soft bubble shapes with spring physics animations. Uses Rounded Mplus/Nunito fonts.';
    case UIVariant.v10CardStack3D:
      return '3D perspective swipe with rotation on Z/Y axis. Uses Space Grotesk font.';
  }
}

/// Check if a variant uses dark mode
bool isVariantDark(UIVariant variant) {
  switch (variant) {
    case UIVariant.v2ModernGlassblur:
    case UIVariant.v3DarkNeon:
    case UIVariant.v5LuxuryGoldBlack:
    case UIVariant.v10CardStack3D:
      return true;
    default:
      return false;
  }
}

/// Get all variants as a list (useful for iteration)
List<UIVariant> get allVariants => UIVariant.values;

