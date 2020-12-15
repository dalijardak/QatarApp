import "package:flutter/material.dart";

double getX(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getY(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
