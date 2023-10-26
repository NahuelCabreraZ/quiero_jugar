import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'api_service.dart';
import 'info_card_model.dart';
// import 'home_bloc.dart';
import 'LoginForm/login_form.dart';
import 'card_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sports_events.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late String _userName;
  late bool _isLoggedIn = false;

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
    _loadFullNameFromLocalStorage();
  }

  // Para recuperar el nombre completo del almacenamiento local
  void _loadFullNameFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('fullName') ?? '';
      _isLoggedIn = _userName
          .isNotEmpty; // Verifica si el usuario ha iniciado sesión // Establece el nombre completo en _userName
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _dataService.fetchDataFromFirestore();
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginForm()),
    );
  }
  void handleCreateEvent(BuildContext context) {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const SportsEventForm()),
     );
   }

  void _handleLogout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(
        'fullName'); // Elimina el nombre completo del almacenamiento local al cerrar sesión
    setState(() {
      _userName = ''; // Borra el nombre de usuario al cerrar sesión
      _isLoggedIn = false; // Establece el estado de inicio de sesión en falso
    });
  }

  

  @override
  Widget build(BuildContext context) {
    // final homeBloc = BlocProvider.of<HomeBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          if (_isLoggedIn) ...[
            // Muestra el saludo y el botón de logout si el usuario ha iniciado sesión
            Row(
              children: [
                Text('Hello, $_userName'),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: _handleLogout,
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    handleCreateEvent(context);
                    // Aquí colocas la lógica para agregar un evento
                    print('voy a la pantalla de crear evento');
                  },
                ),
              ],
            ),
          ] else ...[
            // Muestra el botón de inicio de sesión si el usuario no ha iniciado sesión
            IconButton(
              icon: const Icon(Icons.login),
              onPressed: () {
                handleLogin(context);
              },
            ),
          ],
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
          noItemsFoundIndicatorBuilder: (_) =>
              const Text('No se encontraron elementos'),
        ),
      ),
    );
  }
}
