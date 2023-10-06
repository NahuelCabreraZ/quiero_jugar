import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'api_service.dart'; // Importa el servicio de datos
import 'info_card_model.dart'; // Importa el modelo de tarjeta de información
import 'LoginForm/login_form.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PagingController<int, InfoCardModel> _pagingController = PagingController(firstPageKey: 0);
  final DataService _dataService = DataService(); // Crea una instancia de DataService

  @override
  void initState() {
    super.initState();
    _fetchPage(0); // Cargar la primera página de datos al inicio
  }

 Future<void> _fetchPage(int pageKey) async {
  try {
    final newItems = await _dataService.fetchDataFromJson(); // Cargar datos desde el archivo JSON
    final isLastPage = newItems.isEmpty;
    if (isLastPage) {
      _pagingController.appendLastPage(newItems);
    } else {
      final nextPageKey = pageKey + 1;
      _pagingController.appendPage(newItems, nextPageKey);
    }
  } catch (error) {
    _pagingController.error = error;
  }
}

  @override
  void dispose() {
    _pagingController.dispose(); // Liberar recursos cuando la página se descarte
    super.dispose();
  }
  Card buildInfoCard(InfoCardModel item) {
  return Card(
    elevation: 5, // Elevación para sombrear la tarjeta
    margin: EdgeInsets.all(0.8), // Margen alrededor de la tarjeta
    color: Colors.white.withOpacity(0.3), // Fondo con transparencia
    child: Column(
      children: [
        Image.network(item.imageUrl),
        ListTile(
          title: Text(
            item.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0), // Espaciado interno
          child: Text(
            item.description,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            Text(
              '${item.likes} Likes',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ],
    ),
  );
}

  @override
  void handleLogin(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => LoginForm()), // Navega a la pantalla de inicio de sesión
  );
}

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        actions: [
          IconButton(
            icon: Icon(Icons.login), // Icono para iniciar sesión
            onPressed: () {
            // Llama a la función handleLogin cuando se presiona el botón
            handleLogin(context);
          }
          ),
        ],
      ),
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/backgroundhomepage.jpg'), // Ruta de tu imagen de fondo
          fit: BoxFit.cover, // Ajusta la imagen para que cubra toda la pantalla
        ),
      ),
      child: PagedListView<int, InfoCardModel>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<InfoCardModel>(
          itemBuilder: (context, item, index) {
            // Envuelve la tarjeta en un Container con ancho limitado y estilos personalizados
            return Container(
              width: 300, // Ancho deseado para la tarjeta
              margin: EdgeInsets.all(16), // Márgenes de la tarjeta
              child: Card(
                color: Colors.white.withOpacity(0.8), // Fondo con transparencia
                child: Column(
                  children: [
                  Image.network(
                    (item.imageUrl == "https://via.placeholder.com/150")
                        ? 'https://www.hiveworkshop.com/media/lba2-twinsen-ss.16279/full?d=1465593323' // Usa imagen por defecto si la URL es igual a la URL de marcador de posición
                        : item.imageUrl, // De lo contrario, utiliza la URL proporcionada en el modelo
                  ),
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0), // Espaciado inferior para el título
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(bottom: 16.0), // Espaciado inferior para la descripción
                        child: Text(item.description),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            Text(
                              '${item.likes} Likes',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          firstPageErrorIndicatorBuilder: (_) => Text('Error al cargar la primera página'),
          noItemsFoundIndicatorBuilder: (_) => Text('No se encontraron elementos'),
        ),
      ),
    ),
  );
}
}