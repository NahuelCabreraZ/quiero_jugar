import 'package:http/http.dart' as http;
import 'dart:convert';
import 'info_card_model.dart';
import 'package:flutter/services.dart';

class DataService {
  Future<List<InfoCardModel>> fetchDataFromJson() async {
    final String jsonString = await rootBundle.loadString('assets/fake_data.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    final List<InfoCardModel> infoCards = [];

    for (var jsonData in jsonList) {
      final infoCard = InfoCardModel(
        title: jsonData['title'],
        description: jsonData['description'],
        imageUrl: jsonData['imageUrl'],
        likes: jsonData['likes']
      );
      infoCards.add(infoCard);
    }

    return infoCards;
  }
}