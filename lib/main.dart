import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/router/app_router.dart';
import 'core/providers/theme_provider.dart';

// Hardcoded for web compatibility (flutter_dotenv has issues on web)
const String supabaseUrl = 'https://kxajigvwypgpkggyqhhp.supabase.co';
const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt4YWppZ3Z3eXBncGtnZ3lxaGhwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQzNDE4NzcsImV4cCI6MjA3OTkxNzg3N30.QVyUTeVc_1eeZP4SB6JrOvchOaaNFedZylnh9NgdFzA';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  runApp(
    const ProviderScope(
      child: CheekyApp(),
    ),
  );
}

class CheekyApp extends ConsumerWidget {
  const CheekyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentVariant = ref.watch(themeVariantProvider);
    final theme = buildThemeForVariant(currentVariant);
    final backgroundColor = getThemeBackgroundColor(currentVariant);

    return MaterialApp.router(
      title: 'Cheeky',
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: appRouter,
      builder: (context, child) {
        // Wrap in mobile-sized container for web
        return Container(
          color: backgroundColor,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}

