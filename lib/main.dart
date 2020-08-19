import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:startup/generated/l10n.dart';
import 'package:startup/routes/routes.dart';
import 'package:startup/ui/provider/models/cart.dart';
import 'package:startup/ui/provider/models/catalog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CatalogModel()),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
            create: (context) => CartModel(),
            update: (context, catalog, cart) {
              cart.catalog = catalog;
              return cart;
            }),
      ],
      child: MaterialApp(
        title: 'Ucoon',
        initialRoute: '/',
        //路由钩子
        onGenerateRoute: onGenerateRoute,
        //路由守卫
        navigatorObservers: <NavigatorObserver>[RouteObserver()],
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}
