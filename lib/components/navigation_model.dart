import 'package:flutter/material.dart';

class NavigationModel {
  final Widget page;
  final GlobalKey<NavigatorState> navKey;

  NavigationModel({required this.page, required this.navKey});
}
