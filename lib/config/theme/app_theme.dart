import 'package:flutter/material.dart';

// PUEDO HACERLO ASI:
// const List<Color> colorList = [
//   Colors.blue,
//   Colors.teal,
//   Colors.green,
//   Colors.purple,
//   Colors.deepPurple,
//   Colors.pink,
//   Colors.pinkAccent
// ];
// O ASI:
const colorList = <Color>[
  // PARA COLORES CUSTOM
  Color(0xFFb71c1c),
  Color.fromARGB(255, 0, 140, 255),
  Color.fromARGB(255, 194, 0, 228),
  Colors.deepPurple,
  Color.fromARGB(255, 156, 118, 131),
  Color.fromARGB(255, 42, 81, 126)
];

class AppTheme {
  final int selectedColor;
  final bool isDarkmode;

  AppTheme({this.selectedColor = 0, this.isDarkmode = false})
      // SIN RIVERPOD ESTE ASSERT
      // : assert(selectedColor > 0, 'Selected color must be greater than 0'),
      : assert(selectedColor < colorList.length,
            'Selected color must be less than ${colorList.length - 1}');

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        // SIMPLEMENTE CON ESTO PONE EL TEMA DARK
        // brightness: Brightness.dark,
        brightness: isDarkmode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: colorList[selectedColor],
        // DESDE ACA PUEDO CAMBIAR TODAS LAS PROPIEDADES DE FORMA
        // GENERAL SIN TENER QUE PONERLE A CADA PANTALLA LO MISMO
        appBarTheme: const AppBarTheme(centerTitle: false),
      );
}
