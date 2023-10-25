class InfoCardModel {
  final String title;
  final String description;
  final String? imageUrl;
  final int? likes; // Agregar la propiedad 'likes'
  final String location;

  InfoCardModel({
    required this.title,
    required this.description,
    this.imageUrl,
    this.likes, // Declarar 'likes'
    required this.location,
  });
}