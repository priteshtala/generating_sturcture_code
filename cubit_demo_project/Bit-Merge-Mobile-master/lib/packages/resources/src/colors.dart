import 'dart:ui';

interface class CommonColor {
  static const textColor = Color(0xffF7FDFD);
  static const boardColor = Color(0xffF7FDFD);
  static const emptyTileColor = Color(0xFFE3E2E2);
  static const buttonColor = Color(0xff8f7a66);
  static const scoreColor = Color(0xffbbada0);
  static const overlayColor = Color.fromRGBO(238, 228, 218, 0.73);
  static const color2 = Color(0xff00B2A4);
  static const color4 = Color(0xffF693AF);
  static const color8 = Color(0xffED5472);
  static const color16 = Color(0xff368DC3);
  static const color32 = Color(0xffBA8170);
  static const color64 = Color(0xffE09637);
  static const color128 = Color(0xffBA61D9);
  static const color256 = Color(0xffab09ef);
  static const color512 = Color(0xfffd1600);
  static const color1024 = Color(0xff594f2d);
  static const color2048 = Color(0xff0800ff);
  static const tileColors = {
    2: color2,
    4: color4,
    8: color8,
    16: color16,
    32: color32,
    64: color64,
    128: color128,
    256: color256,
    512: color512,
    1024: color1024,
    2048: color2048,
  };
}
