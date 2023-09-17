import 'package:flutter/material.dart';

navigate(BuildContext context, Widget screen) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
      settings: RouteSettings(
        name: screen.toString(),
      ),
    ),
  );
}

navigateNamed(BuildContext context, String screenName) {
  return Navigator.pushNamed(
    context,
    screenName,
  );
}

navigateNamedReplacement(BuildContext context, String routeName) {
  return Navigator.pushReplacementNamed(
    context,
    routeName,
  );
}

navigateReplacement(BuildContext context, Widget screen) {
  return Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
      settings: RouteSettings(
        name: screen.toString(),
      ),
    ),
  );
}

navigateNamedUntil(BuildContext context, Widget screen) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
      settings: RouteSettings(
        name: screen.toString(),
      ),
    ),
    (route) => false,
  );
}

navigateUntil(BuildContext context, Widget screen) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
      settings: RouteSettings(
        name: screen.toString(),
      ),
    ),
    (route) => false,
  );
}
