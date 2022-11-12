import 'package:flutter/material.dart';
import 'package:pokedex/routes/router.gr.dart';
import 'package:pokedex/shared/theme.dart';

void main() => runApp(PokedexApp());

class PokedexApp extends StatelessWidget {
  PokedexApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Pokedex',
        theme: AppTheme.themeData,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      );
}
