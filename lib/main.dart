import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:pokedex/core/config/injection.dart';
import 'package:pokedex/routes/router.gr.dart';
import 'package:pokedex/shared/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await serviceLocator();
  Loggy.initLoggy();

  runApp(ProviderScope(child: PokedexApp()));
}

class PokedexApp extends StatelessWidget {
  PokedexApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return StyledToast(
      locale: const Locale('en', 'US'),
      textStyle: const TextStyle(fontSize: 16.0, color: Colors.white),
      backgroundColor: Colors.black,
      borderRadius: BorderRadius.circular(10),
      toastPositions: StyledToastPosition.bottom,
      toastAnimation: StyledToastAnimation.slideFromLeft,
      reverseAnimation: StyledToastAnimation.slideToRightFade,
      curve: Curves.easeIn,
      reverseCurve: Curves.linear,
      duration: const Duration(seconds: 2),
      dismissOtherOnShow: true,
      animDuration: Duration.zero,
      fullWidth: true,
      isHideKeyboard: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Pokedex',
        theme: AppTheme.themeData,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
