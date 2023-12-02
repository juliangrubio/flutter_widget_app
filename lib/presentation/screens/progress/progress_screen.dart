import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  static const String name = 'progress_screen';
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress indicators'),
      ),
      body: const _ProgressView(),
    );
  }
}

class _ProgressView extends StatelessWidget {
  const _ProgressView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          SizedBox(height: 30),
          Text('Circular progress indicator'),
          SizedBox(height: 10),
          // ABAJO EL SEGUNDO PARAMETRO DE COLORS LOS ULTIMOS NUMEROS SON DE OPACIDAD
          // CircularProgressIndicator(strokeWidth: 2),
          CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: Colors.black12,
          ),
          SizedBox(height: 20),
          Text(
              'Circular y linear controlado'), // ESTO SERIA QUE NO ES INFINITO COMO EL ANTERIOR
          SizedBox(height: 10),
          _ControllerProgressIndicator(),
        ],
      ),
    );
  }
}

class _ControllerProgressIndicator extends StatelessWidget {
  // QUITO EL SUPER.KEY PORQUE ES PRIVADO, NO SE VA A UTILIZAR FUERA DE ESTO
  const _ControllerProgressIndicator();

  @override
  Widget build(BuildContext context) {
    // EL STREAMBUILDER SE CONSTRUYE EN TIEMPO DE EJECUCION
    //
    return StreamBuilder(
        stream: Stream.periodic(const Duration(milliseconds: 300), (value) {
          return (value * 2) / 100; // ESTO VA DE 0.0 A 1.0
          // ABAJO CUANDO LLEGA A 100 QUITA ESA SUSCRIPCION O LISTENER
          // TAMBIEN SI SALGO AL HOME VENDRIA A DESTRUIR EL STREAM, OSEA QUE NO QUEDA OCUPANDO MEMORIA
        }).takeWhile((value) => value < 1),
        builder: (context, snapshot) {
          
          final progressValue = snapshot.data ?? 0;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  value: progressValue,
                  strokeWidth: 4,
                  backgroundColor: Colors.black12,
                ),
                const SizedBox(width: 20),
                // SI PUSIERA EL LINEAR PROGRESS INDICATOR SIN EXPANDED RECIBIRIA ERROR
                // PORQUE EL LINEAR NECESITA SABER CUANTO ESPACIO DARLE PERO EN EL ROW NO LE
                // ESTOY DICIENDO CUAN GRANDE PUEDE SER, PARA ESO EL EXPANDED TOMA EL
                // ESPACIO DISPONIBLE QUE TIENE EL PADRE.
                Expanded(
                    child: LinearProgressIndicator(
                  value: progressValue,
                ))
              ],
            ),
          );
        });
  }
}
