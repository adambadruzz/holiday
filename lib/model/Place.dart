class PlaceModel {
  final String cover, place_name, short_description, description, asal;
  final int id_place;

  PlaceModel({
    required this.cover,
    required this.place_name,
    required this.id_place,
    required this.short_description,
    required this.description,
    required this.asal,
  });

  factory PlaceModel.fromJSON(Map parsedJson) {
    return PlaceModel(
      cover: parsedJson['cover'],
      place_name: parsedJson['place_name'],
      id_place: parsedJson['id_place'],
      short_description: parsedJson['short_description'],
      description: parsedJson['description'],
      asal: parsedJson['asal'],
    );
  }
}
