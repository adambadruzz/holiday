class FavoriteModel {
  final String cover, place_name, short_description, description, asal;
  final int id_bookmark, place_id, user_id;

  FavoriteModel(
      {required this.id_bookmark,
      required this.user_id,
      required this.cover,
      required this.place_name,
      required this.asal,
      required this.place_id,
      required this.short_description,
      required this.description});

  factory FavoriteModel.fromJSON(Map parsedJson) {
    return FavoriteModel(
      id_bookmark: parsedJson['id_bookmark'],
      place_id: parsedJson['place_id'],
      place_name: parsedJson['place_name'],
      asal: parsedJson['asal'],
      short_description: parsedJson['short_description'],
      description: parsedJson['description'],
      user_id: parsedJson['user_id'],
      cover: parsedJson['cover'],
    );
  }
}

class FavoriteModelDetail {
  final int id_bookmark, place_id, user_id;

  FavoriteModelDetail({
    required this.id_bookmark,
    required this.place_id,
    required this.user_id,
  });

  factory FavoriteModelDetail.fromJSON(Map parsedJson) {
    return FavoriteModelDetail(
        id_bookmark: parsedJson['id_bookmark'],
        place_id: parsedJson['place_id'],
        user_id: parsedJson['user_id']);
  }
}
