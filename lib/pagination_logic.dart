import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'api_service.dart'; // Importa el servicio de datos
import 'info_card_model.dart'; // Importa el modelo de tarjeta de información

class PaginationLogic {
  final DataService _dataService = DataService();
  final PagingController<int, InfoCardModel> pagingController;
  final DataService dataService;

  PaginationLogic(this.pagingController, this.dataService);

  Future<List<InfoCardModel>> fetchPage(int pageKey) async {
    try {
      final List<InfoCardModel> pageData = await _dataService.fetchDataFromFirestore();
      return pageData;
    } catch (error) {
      // Manejar errores, como cuando no se pueden cargar los datos.
      rethrow;
    }
  }
}