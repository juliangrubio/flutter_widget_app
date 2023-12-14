import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

// class ThemeScreen extends StatelessWidget {
class ThemeScreen extends ConsumerWidget {
  static const name = 'theme_screen';
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isDarkmode = ref.watch(isDarkmodeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme changer'),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(isDarkmodeProvider.notifier).update((state) => !state);
              },
              icon: Icon(isDarkmode
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined))
          // icon: const Icon(Icons.dark_mode_outlined))
        ],
      ),
      body: const _ThemeChangerView(),
    );
  }
}

class _ThemeChangerView extends ConsumerWidget {
  const _ThemeChangerView();

  @override
  Widget build(BuildContext context, ref) {
    final List<Color> colors = ref.watch(colorListProvider);
    final int selectedOption = ref.watch(selectedColorProvider);
    final bool isDarkmode = ref.watch(isDarkmodeProvider);

    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final color = colors[index];
        return RadioListTile(
            title: Text(
              'Este color',
              style: TextStyle(color: color),
            ),
            subtitle: Text('${color.value}'),
            activeColor: color,
            value: index,
            groupValue: selectedOption,
            onChanged: (value) {
              ref.read(selectedColorProvider.notifier).update((state) => index);
              // print('$value');
            });
      },
    );
  }
}
