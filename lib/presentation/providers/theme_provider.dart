
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/config/theme/app_theme.dart';

// Listado de colores inmutable
final colorListProvider = Provider((ref) => colorList);

// Un simple bool
final isDarkmodeProvider = StateProvider<bool>((ref) => false);
// Un simple int
final selectedColorProvider = StateProvider((ref) => 1);