import 'package:cloud_firestore/cloud_firestore.dart';
import 'info_card_model.dart';

class DataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<InfoCardModel>> fetchDataFromFirestore() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('eventosDeportivos').get();

      List<InfoCardModel> infoCards = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        InfoCardModel infoCard = InfoCardModel(
          title: data['title'],
          description: data['description'],
          imageUrl: data['imageUrl'],
          likes: data['likes'],
          location: data['location']
        );

        infoCards.add(infoCard);
      }

      return infoCards;
    } catch (e) {
      throw Exception('Error al obtener datos de Firestore: $e');
    }
  }
}
