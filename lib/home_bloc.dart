import 'package:flutter_bloc/flutter_bloc.dart';
import 'api_service.dart'; // Importa tu servicio de datos
import 'info_card_model.dart'; // Importa el modelo de tarjeta de información

// Estados
abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<InfoCardModel> data;
  final bool hasReachedMax;

  HomeLoaded({required this.data, required this.hasReachedMax});
}

class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}

// Eventos
abstract class HomeEvent {}

class HomeLoadData extends HomeEvent {}

// Bloc
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DataService dataService;

  HomeBloc({required this.dataService}) : super(HomeLoading());


  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomeLoadData) {
      yield HomeLoading();
      try {
        final newItems = await dataService
            .fetchDataFromFirestore(); // Cargar datos desde el archivo JSON

        final isLastPage = newItems.isEmpty;
        if (isLastPage) {
          yield HomeLoaded(
            data: newItems,
            hasReachedMax: true,
          );
        } else {
          yield HomeLoaded(
            data: newItems,
            hasReachedMax: false,
          );
        }
      } catch (error) {
        yield HomeError(message: error.toString());
      }
    }
  }
}
