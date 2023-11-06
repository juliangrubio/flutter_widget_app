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
  Colors.blue,
  Colors.purple,
  Colors.deepPurple,
  Colors.pink,
  Colors.pinkAccent
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert(selectedColor > 0, 'Selected color must be greater than 0'),
        assert(selectedColor < colorList.length, 'Selected color must be less than ${colorList.length - 1}');

  ThemeData getTheme() =>
      ThemeData(
        useMaterial3: true, 
        colorSchemeSeed: colorList[selectedColor],
        // DESDE ACA PUEDO CAMBIAR TODAS LAS PROPIEDADES DE FORMA 
        // GENERAL SIN TENER QUE PONERLE A CADA PANTALLA LO MISMO
        appBarTheme: const AppBarTheme(
          centerTitle: false
        ),
      );
}
