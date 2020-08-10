import 'package:flutter/material.dart';

class RouteObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route previousRoute) {
    super.didPush(route, previousRoute);
    print(route);
    print(route.settings);
    print(previousRoute);
  }

  @override
  void didPop(Route route, Route previousRoute) {
    super.didPop(route, previousRoute);
    print(route);
    print(route.settings);
    print(previousRoute);
  }

  @override
  void didRemove(Route route, Route previousRoute) {
    super.didRemove(route, previousRoute);
    print(route);
    print(route.settings);
    print(previousRoute);
  }
}
