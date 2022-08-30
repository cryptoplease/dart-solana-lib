import 'package:flutter/material.dart';

abstract class CpColors {
  CpColors._();

  static const primaryColor = Color(0xfff46640); // red primary color

  static const strokeColor = Color(0xffff8956); // stroke color

  static const yellowColor = Color(0xfffacf48); // yellow primary color
  static const translucentYellowColor = Color(0x30e7b11f);

  static const primaryTextColor = Color(0xff231f20); // black primary color
  static const secondaryTextColor = Color(0xff909090);
  static const disabledTabColor = Color(0xffbababa);
  static const placeholderLightColor = Color(0xffC2C2C2);
  static const listDividerColor = Color(0xffF5F5F5);

  static const lightGreyBackground = Color(0xffF5F5F5); // for menu buttons

  static const lightButtonBackgroundColor = Color(0xffffffff);

  static const lightTextFieldBackgroundColor = Color(0xfff0f0f0);

  static const purple = Color(0xffA695FF);

  static const darkBackground = Color(0xff2d2b2b);
  static const shadowPrimaryColor = Color(0xffeb5f3a);
  static const accentDarkBackground = Color(0xff2c2d31);
  static const darkPrimaryColor = Color(0xffd74924);

  static const backgroundAccentColor = Color(0xffff9551);
  static const greyBackground = Color(0xfff4f4f4);
  static const menuPrimaryTextColor = Color(0xff34393c);
  static const greyIconBackgroundColor = Color(0xfff0efe7);

  static const primaryAccentColor = Color(0xfffce4da);

  static const successBackgroundColor = Color(0xff62d58f);
  static const errorBackgroundColor = Color(0xffff6640);
  static const pendingBackgroundColor = Color(0xfff2bd1a);
}

const bgGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.centerLeft,
  colors: [Color(0xfff45440), Color(0xffff8b49)],
  stops: [0.1, 1.0],
);
