import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'api_service.dart';
import 'info_card_model.dart';
import 'home_bloc.dart';
import 'LoginForm/login_form.dart';
import 'card_builder.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PagingController<int, InfoCardModel> _pagingController =
      PagingController(firstPageKey: 0);
  final DataService _dataService = DataService();

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      // Escuchar las solicitudes de página y cargar datos
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _dataService.fetchDataFromJson();
      if (newItems.isEmpty) {
        _pagingController.appendLastPage([]);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  void handleLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginForm()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        actions: [
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              handleLogin(context);
            },
          ),
        ],
      ),
      body: PagedListView<int, InfoCardModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<InfoCardModel>(
          itemBuilder: (context, item, index) {
            return CardBuilder().buildInfoCard(item, () {
              // Aquí colocas la lógica que deseas ejecutar cuando se presiona el botón "Unirme"
              // Por ejemplo, mostrar un mensaje de éxito
              final successMessage = 'Te has unido a ${item.title}';
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(successMessage),
                duration: const Duration(seconds: 2),
              ));
            });
          },
          firstPageErrorIndicatorBuilder: (_) =>
              const Text('Error al cargar la primera página'),
          noItemsFoundIndicatorBuilder: (_) => const Text('No se encontraron elementos'),
        ),
      ),
    );
  }
}