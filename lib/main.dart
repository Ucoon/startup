import 'package:flutter/material.dart';
import 'package:startup/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ucoon',
      initialRoute: '/',
      //路由钩子
      onGenerateRoute: onGenerateRoute,
      //路由守卫
      navigatorObservers: <NavigatorObserver>[RouteObserver()],
    );
  }
}
