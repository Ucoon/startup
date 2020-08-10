import 'package:flutter/material.dart';
import 'package:startup/ui/page/detail.dart';
import 'package:startup/ui/page/favoriteList.dart';
import 'package:startup/ui/page/home.dart';

//配置路由规则
final routes = {
  '/': (context) => HomePage(),
  '/favorite': (context, {arguments}) =>
      FavoriteListPage(favoriteList: arguments),
  '/detail': (context, {arguments}) => DetailPage(detail: arguments)
};

//固定写法-路由传参
var onGenerateRoute = (RouteSettings settings) {
  //统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
