import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_app/presentation/providers/counter_provider.dart';
import 'package:widgets_app/presentation/providers/theme_provider.dart';

// CONSUMER WIDGET ES PARA EL USO DE RIVERPOD, ESTE ES EL REEMPLAZO DE STATELESSWIDGET
// PARA UN STATEFULLWIDGET SERIA CONSUMERSTATEFULWIDGET
class CounterScreen extends ConsumerWidget {
  static const String name = 'counter_screen';
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int clickCounter = ref.watch(counterProvider);
    final bool darkMode = ref.watch(isDarkmodeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(isDarkmodeProvider.notifier).update((state) => !state);
            }, 
            // icon: darkMode ? const Icon(Icons.dark_mode_outlined) : const Icon(Icons.light_mode_outlined)
            icon: Icon(darkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined)
          )
        ],
      ),
      body: Center(
          child: Text(
        // 'Valor: 10',
        'Valor: $clickCounter',
        // style: TextStyle(fontSize: 30),
        style: Theme.of(context).textTheme.titleLarge,
      )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // EL WATCH NO SE DEBE USAR EN METODOS, ES UNA MALA PRACTICA,
            // PODEMOS LEER EL VALOR CON READ, Y LE PONEMOS EL NOTIFIER
            // AL PROVEEDOR, ESTO NOS HABILITA EL METODO STATE PARA GUARDAR
            // UN VALOR, EN RESUMEN, EL NOTIFIER, NOTIFICA AL PROVIDER DE
            // UN NUEVO ESTADO EN ESTE CASO.
            ref.read(counterProvider.notifier).state++;
            // Ó
            // ref.read(counterProvider.notifier).update((state) => state + 1);

            /* 
               1. ref.read(counterProvider.notifier).state++;
                  En este caso, estás accediendo directamente al estado del 
                  proveedor a través de ref.read(counterProvider.notifier).state 
                  y luego incrementándolo directamente con el operador de 
                  incremento (++). Esto funciona, pero es importante tener en 
                  cuenta que esta forma de modificar el estado no notificará 
                  automáticamente a los widgets que están escuchando ese 
                  proveedor. Es decir, los widgets que dependen de este proveedor 
                  no se volverán a construir automáticamente para reflejar el 
                  cambio en el estado.

               2. ref.read(counterProvider.notifier).update((state) => state + 1);
                  En este caso, estás utilizando el método update proporcionado 
                  por el notificador del proveedor. El método update toma una 
                  función que se aplica al estado actual y luego notifica a los 
                  oyentes sobre el cambio. Esto asegura que cualquier widget que 
                  dependa de este proveedor se vuelva a construir automáticamente 
                  cuando el estado cambie.

                  El uso de update es preferido cuando trabajas con proveedores 
                  en Flutter, ya que garantiza un manejo adecuado de la 
                  notificación de cambios y ayuda a mantener la consistencia en 
                  la interfaz de usuario.

                  En resumen, mientras que ambas formas pueden funcionar, la 
                  segunda (update) es preferida en el contexto de Riverpod y 
                  Flutter porque proporciona un mecanismo más robusto para 
                  gestionar los cambios de estado y notificar a los widgets 
                  afectados.
             */
          },
          child: const Icon(Icons.add_rounded)),
    );
  }
}
