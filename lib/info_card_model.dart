class InfoCardModel {
  final String title;
  final String description;
  final String imageUrl;
  final int likes; // Agregar la propiedad 'likes'

  InfoCardModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.likes, // Declarar 'likes'
  });
}