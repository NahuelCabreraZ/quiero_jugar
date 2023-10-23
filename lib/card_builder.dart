import 'package:flutter/material.dart';
import 'info_card_model.dart';



  Widget _buildImage(String imageUrl) {
    return Image.network(
      imageUrl,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
        return const Icon(Icons.error);
      },
    );
  }

class CardBuilder {
  Card buildInfoCard(InfoCardModel item, VoidCallback onJoinPressed) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(0.8),
      color: Colors.white.withOpacity(0.3),
      child: Column(
        children: [
            _buildImage(item.imageUrl), // Utiliza un método privado para construir la imagen
          ListTile(
            title: Text(
              item.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              item.description,
              style: TextStyle(fontSize: 16),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              item.location,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  Text(
                    '${item.likes} Likes',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: onJoinPressed, // Usa la función proporcionada para la acción "Unirme"
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Unirme'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


