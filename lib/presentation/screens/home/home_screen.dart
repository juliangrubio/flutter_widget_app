import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_app/config/menu/menu_items.dart';
import 'package:widgets_app/presentation/screens/buttons/buttons_screen.dart';
import 'package:widgets_app/presentation/screens/cards/cards_screen.dart';
import 'package:widgets_app/presentation/widgets/drawers/side_menu.dart';

class HomeScreen extends StatelessWidget {
  // ESTE NAME ES SOLO A LOS EFECTOS DE LA PROPIEDAD ROUTER
  // SI USO PATH EN EL ROUTER ESTO NO IRIA, EL STATIC ES PARA
  // NO TENER QUE INSTANCIAR LA CLASE PARA ACCEDER A ESTA CONST
  static const String name = 'home_screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      // ESTE KEY QUE ES DEL SUPER KEY, TIENE LA REFERENCIA DEL 
      // ESTADO ACTUAL DEL SCAFFOLD Y VA A SER RECIBIDA POR ARGS EN SIDEMENU
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Flutter + Material 3'),
      ),
      body: const _HomeView(),
      // COMO RECIBE UN WIDGET, PODRIA DEJARLO ASI:
      // drawer: const Placeholder(),
      // PERO TIENE UN WIDGET ESPECIALIZADO PARA EL DRAWER COMUN, 
      // PERO PARA PERSONALIZACIONES EL DE ARRIBA VA BIEN
      drawer: SideMenu(scaffoldKey: scaffoldKey),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: appMenuItems.length,
      itemBuilder: (context, index) {
        final menuItem = appMenuItems[index];
        // UNA POSIBILIDAD DE HACER LAS OPCIONES AQUI DENTRO:
        // return Text(menuItem.title);
        // PERO AUN MEJOR:
        return _CustomListTile(menuItem: menuItem);
      },
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(
        menuItem.icon,
        color: colors.primary,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: colors.primary,
      ),
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subTitle),
      onTap: () {
        // ESTO PARA HACERLO EN DURO Y SIN LAS ROUTES DE MAIN, ESTOS DOS DE ABAJO
        // SON PROPIOS DE FLUTTER
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => const ButtonsScreen(),
        //   ),
        // );
        // Navigator.pushNamed(context, menuItem.link);

        // ESTAS DE ACA SON PROPIAS DEL GO_ROUTER
        // SE PUEDE HACER ASI CON ESTE METODO PARA LOS NOMBRES,
        // Y PODRIA METERSELO AL MENUITEM
        // context.pushNamed(CardsScreen.name);
        context.push(menuItem.link);
      },
    );
  }
}
