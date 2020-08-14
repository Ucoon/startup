import 'package:flutter/material.dart';
import 'package:startup/ui/provider/pages/cart.dart';
import 'package:startup/ui/provider/pages/cartlog.dart';
import 'package:startup/ui/provider/pages/login.dart';
import 'package:startup/ui/state/parentWidgetC.dart';
import 'package:startup/ui/route/detail.dart';
import 'package:startup/ui/route/favorite_list.dart';

//配置路由规则
final routes = {
  '/': (context) => Login(),
  '/route/favorite': (context, {arguments}) =>
      FavoriteListPage(favoriteList: arguments),
  '/route/detail': (context, {arguments}) => DetailPage(detail: arguments),
  '/provider/cartlogo': (context) => MyCatalog(),
  '/provider/cart': (context) => MyCart()
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
