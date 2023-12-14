import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';

class SideMenu extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    // NO SERIA NECESARIO ESTE CONDICIONAL PORQUE LO ESTOY EMULANDO SOLO EN ANDROID,
    // PERO LO DEJO PARA SABER QUE EXISTE
    if (Platform.isAndroid) {
      print('$hasNotch');
    }

    return NavigationDrawer(
        selectedIndex: navDrawerIndex,
        onDestinationSelected: (value) {
          setState(() {
            navDrawerIndex = value;
          });

          // ESTO DIRIGE EL TAP AL ITEM
          final menuItem = appMenuItems[value];
          // SI EN LUGAR DE PUSH PONDRIA GO, MOVERIA LA RUTA PERO SIN STACK
          // (ME QUEDO SIN EL BOTON PARA VOLVER QUE SE ENCUENTRA EN EL APPBAR)
          context.push(menuItem.link);
          // PARA ACCEDER AL WIDGET SIDEMENU, NO AL STATE DEL MISMO (PORQUE
          // ES UN STATEFULWIDGET) USAMOS WIDGET PARA REFERIRNOS AL STATEFULWIDGET
          widget.scaffoldKey.currentState?.closeDrawer();
        },
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, hasNotch ? 10 : 30, 16, 10),
            child: const Text('Main'),
          ),
          // NavigationDrawerDestination(
          //     icon: Icon(Icons.add), label: const Text('Home Screen')),
          // NavigationDrawerDestination(
          //     icon: Icon(Icons.add_shopping_cart_rounded),
          //     label: const Text('Otra Screen')),

          ...appMenuItems
              // SUBLIST BARRE DEL 0 AL 3 DE LA LISTA, QUE SERIAN LOS 3 PRIMEROS ELEMENTOS
              .sublist(0, 3)
              .map(
                (e) => NavigationDrawerDestination(
                    icon: Icon(e.icon), label: Text(e.title)),
              ),

          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 16, 10),
            child: Text('Secondary'),
          ),

          ...appMenuItems
              // SUBLIST BARRE DEL 3 EN ADELANTE
              .sublist(3)
              .map(
                (e) => NavigationDrawerDestination(
                    icon: Icon(e.icon), label: Text(e.title)),
              ),
        ]);
  }
}
