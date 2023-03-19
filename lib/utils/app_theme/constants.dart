import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';


class AMUNETheme{
  static String appName = "AMUNET";

  static Color lightPrimary = const Color(0xfff3f4f9);
  static Color darkPrimary = const Color(0xff2B2B2B);

  static Color lightAccent = const Color(0xfff8256c);
  static Color darkAccent = const Color(0xffff518c);
  static Color lightSecondaryBG = const Color(0xFFFFFFFF);
  static Color darkSecondaryBG = const Color(0xFF101213);
  static Color lightBG = const Color(0xfff3f4f9);
  static Color darkBG = const Color(0xff2B2B2B);


  static TextStyle get title1 => const TextStyle(
    fontFamily: 'Sherlock',
    fontWeight: FontWeight.w600,
    fontSize: 40,
  );
  static TextStyle get title2 => const TextStyle(
    fontFamily: 'Raleway',
    fontWeight: FontWeight.w600,
    fontSize: 22,
  );
  static TextStyle get title3 => const TextStyle(
    fontFamily: 'Raleway',
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );
  static TextStyle get subtitle1 => const TextStyle(
    fontFamily: 'Raleway',
    fontWeight: FontWeight.w600,
    fontSize: 18,

  );
  static TextStyle get subtitle2 => const TextStyle(
    fontFamily: 'Raleway',
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );
  static TextStyle get bodyText1 => const TextStyle(
    fontFamily: 'Raleway',
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
  static TextStyle get bodyText2 => const TextStyle(
    fontFamily: 'Raleway',
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );


  static final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: const Color.fromRGBO(23, 171, 144, 0.4)),
    ),
  );
  static final cursor = Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      width: 21,
      height: 1,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(137, 146, 160, 1),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
  static final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: const
    Color.fromRGBO(114, 178, 238, 1)),
    borderRadius: BorderRadius.circular(8),
  );

  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    fontFamily: "Raleway",
    primaryColor: lightPrimary,
    canvasColor: lightSecondaryBG,
    accentColor: lightAccent,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: lightAccent,
    ),
    scaffoldBackgroundColor: lightBG,
    bottomAppBarTheme: BottomAppBarTheme(
      elevation: 0,
      color: lightBG,
    ),
    textTheme: TextTheme(
      headline3: TextStyle(
          color: darkBG,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: "Raleway"
      ),
    ),
    appBarTheme:  AppBarTheme(
      backgroundColor: lightSecondaryBG,
      titleTextStyle: TextStyle(
        color: darkBG,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w600,
        fontSize: 25,
      ),
      iconTheme: IconThemeData(
        color: darkBG
      ),
      elevation: 0,
    ),

  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: "Raleway",
    backgroundColor: darkBG,
    canvasColor: darkSecondaryBG,
    primaryColor: darkPrimary,
    accentColor: darkAccent,
    scaffoldBackgroundColor: darkBG,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: darkAccent,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      elevation: 0,
      color: darkBG,
    ),
    textTheme: TextTheme(
      headline3: TextStyle(
          color: lightBG,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: "Raleway"
      ),
    ),
    appBarTheme:  AppBarTheme(
      backgroundColor: darkSecondaryBG,
      titleTextStyle: TextStyle(
        color: lightBG,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w600,
        fontSize: 25,
      ),
      iconTheme: IconThemeData(
          color: lightBG
      ),
      elevation: 0,
    ),
  );

  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

}
extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      TextStyle(
        fontFamily: fontFamily ?? this.fontFamily,
        color: color ?? this.color,
        fontSize: fontSize ?? this.fontSize,
        fontWeight: fontWeight ?? this.fontWeight,
        fontStyle: fontStyle ?? this.fontStyle,
        decoration: decoration,
        height: lineHeight,
      );
}