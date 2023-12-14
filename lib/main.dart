import 'package:flutter/material.dart';
import 'package:widgets_app/config/router/app_router.dart';
import 'package:widgets_app/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

void main() {
  // runApp(const MainApp());
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bool isDark = ref.watch(isDarkmodeProvider);
    final int seletedColor = ref.watch(selectedColorProvider);

    return MaterialApp.router(
      title: 'Flutter Widgets',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: seletedColor, isDarkmode: isDark).getTheme(),
      // PARA IR VIENDO SI ANDAN LOS TEMAS
      // home: Scaffold(
      //   body: Center(
      //     child: FilledButton(child: const Text('Hola'), onPressed: (){}),
      //   ),
      // ),

      // SACO ESTO PARA PONER EL ROUTER
      // home: const HomeScreen(),
      // routes: {
      //   '/buttons': (context) => ButtonsScreen(),
      //   '/cards': (context) => CardsScreen(),
      // },
    );
  }
}
