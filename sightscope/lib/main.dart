import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/eye_wellness/data/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Registers the notification channel; does not itself request the
  // permission or show anything — that only happens if the user opts in
  // under Eye Wellness settings.
  await NotificationService.instance.init();
  runApp(const ProviderScope(child: SightScopeApp()));
}

class SightScopeApp extends StatelessWidget {
  const SightScopeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SightScope',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: appRouter,
    );
  }
}
