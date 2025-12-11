# Cheeky 💕

A modern, swipe-based dating app built with Flutter and Supabase.

## Features

- 🔐 Email/password authentication
- 👤 Profile creation with photo upload
- 💘 Swipe deck (like/pass)
- 💬 Real-time chat with matches
- 🎨 **10 unique UI theme variants**

## Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Supabase (PostgreSQL, Auth, Storage, Realtime)
- **State Management**: Riverpod
- **Navigation**: go_router

## UI Variants

This project includes 10 independent UI/UX theme variations:

| Variant | Style | Swipeflow |
|---------|-------|-----------|
| V1 | Classic Tinder | Card tilt rotation |
| V2 | Modern Glassblur | Elastic bounce with blur |
| V3 | Dark Neon | Neon pulse & glow |
| V4 | Minimal Soft | Flat slide, no rotation |
| V5 | Luxury Gold Black | Slow premium easing |
| V6 | Playful Pastel | Exaggerated bounce |
| V7 | High Contrast Red | Harsh snap animation |
| V8 | Blue Corporate | Microsoft-like motion |
| V9 | Rounded Bubbles | Spring physics |
| V10 | Card Stack 3D | 3D Z/Y axis rotation |

## Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- Dart SDK
- Supabase account

### Installation

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/cheeky.git
cd cheeky
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Supabase:
   - Update `lib/main.dart` with your Supabase URL and anon key

4. Run the app:
```bash
flutter run
```

### Preview UI Variants

To preview all 10 UI variants:
```bash
flutter run -t dev_preview/main_preview.dart
```

## Project Structure

```
cheeky/
├── lib/
│   ├── main.dart
│   ├── core/              # Theme, router, services
│   ├── common/            # Models, repositories
│   └── features/          # Auth, profile, swipe, matches
├── ui_variants/           # 10 UI theme variations
│   ├── v1_classic_tinder/
│   ├── v2_modern_glassblur/
│   └── ... (v3-v10)
├── dev_preview/           # Developer preview tools
└── supabase/
    └── migrations/        # Database schema
```

## Deployment

### Web (Cloudflare Pages)

1. Build for web:
```bash
flutter build web --release
```

2. Deploy `build/web` to Cloudflare Pages

## License

MIT License
