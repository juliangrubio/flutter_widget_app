import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfiniteScrollScreen extends StatefulWidget {
  static const String name = 'infinite_screen';
  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {
  List<int> imagesIds = [1, 2, 3, 4, 5];
  bool isLoading = false;
  // bool isMounted = true;

  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels + 500 >=
          scrollController.position.maxScrollExtent) {
        loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    // isMounted = false;
    super.dispose();
  }

  Future loadNextPage() async {
    if (isLoading) return;
    isLoading = true;
    setState(() {});

    await Future.delayed(const Duration(seconds: 5));
    addFiveImages();

    isLoading = false;
    // TODO: Revisar si está montado el componente / widget porque si salgo de la pantalla y manda a llamar el setState de un widget no montado puede terminar la app con una exepcion
    if (!mounted) return;
    // if (!isMounted) return;
    setState(() {});
    moveScrollToBottom();
  }

  Future<void> onRefresh() async {
    isLoading = true;
    setState(() {});

    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    isLoading = false;
    final lastId = imagesIds.last;
    imagesIds.clear();
    imagesIds.add(lastId + 1);
    addFiveImages();
    setState(() {});
  }

  void moveScrollToBottom() {
    // ESTA LINEA DE ABAJO ES PARA QUE SE EVALUE SI ESTOY CERCA DE EL FINAL QUE SIGA SINO, RETURN.
    if (scrollController.position.pixels + 150 <=
        scrollController.position.maxScrollExtent) return;
    scrollController.animateTo(scrollController.position.pixels + 120,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn);
  }

  void addFiveImages() {
    final lastOneId = imagesIds.last;
    imagesIds.addAll([1, 2, 3, 4, 5].map((e) => lastOneId + e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //   title: const Text('InfiniteScroll'),
      // ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: RefreshIndicator(
          onRefresh: onRefresh,
          // ABAJO LA DISTANCIA DEL TOP DE LA RUEDA DEL PULL TO REFRESH
          edgeOffset: 150,
          backgroundColor: Colors.orange,
          color: Colors.white,
          // EL GROSOR
          strokeWidth: 9,
          child: ListView.builder(
            controller: scrollController,
            itemCount: imagesIds.length,
            itemBuilder: (context, index) {
              // return const Text('Hola');
              return FadeInImage(
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
                placeholder: const AssetImage('assets/Images/jar-loading.gif'),
                image: NetworkImage(
                    'https://picsum.photos/id/${imagesIds[index]}/500/300'),
                // ESTE DE ABAJO POR SI FALLA EL BACKEND ENVIA UNA IMAGEN 404
                imageErrorBuilder: (BuildContext context, error, stackTrace) =>
                    Image.asset('assets/Images/1.png', fit: BoxFit.cover),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => context.pop(),
          // child: const Icon(Icons.arrow_back_ios_new_outlined),
          // child: CircularProgressIndicator(),
          child: isLoading
              ? FadeInRight(
                  child: SpinPerfect(
                      infinite: true, child: Icon(Icons.refresh_rounded)))
              : FadeIn(child: const Icon(Icons.arrow_back_ios_new_outlined))),
    );
  }
}
