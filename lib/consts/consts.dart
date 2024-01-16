import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color get primaryColor {
  return const Color(0x007f3dff);
}

Container containerWithRadius(Widget widget, Color color, Color borderColor,
    double height, double width) {
  return Container(
    height: height,
    width: width,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: color,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(15)),
    child: widget,
  );
}

TextStyle textStyle(Color color, double fonstSize) {
  return TextStyle(
      color: color,
      fontSize: fonstSize,
      overflow: TextOverflow.fade,
      fontWeight: FontWeight.w400);
}

Padding dPadding(Widget widget) {
  return Padding(
    padding: const EdgeInsets.only(left: 14, right: 14, top: 7, bottom: 7),
    child: widget,
  );
}

Widget getIcon(String type) {
  if (type == "Subscription") {
    return iconWidget(Icons.subscriptions_rounded, Colors.purple);
  } else if (type == "Food") {
    return iconWidget(Icons.food_bank_rounded, Colors.redAccent);
  } else if (type == "Shopping") {
    return iconWidget(Icons.shopping_bag_outlined, Colors.amber);
  } else if (type == "Travel") {
    return iconWidget(CupertinoIcons.car_detailed, Colors.blueAccent);
  } else {
    return iconWidget(Icons.money, Colors.green);
  }
}

Widget iconWidget(IconData iconData, Color color) {
  return Container(
    height: 60,
    width: 60,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: color.withOpacity(0.3), borderRadius: BorderRadius.circular(15)),
    child: Icon(
      iconData,
      color: color,
      size: 40,
    ),
  );
}

String getTime(String datetime) {
  return datetime.substring(10, 16);
}
