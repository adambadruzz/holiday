import 'dart:ffi';

import 'package:dio/dio.dart';

import '../model/Favorite.dart';
import '../model/Place.dart';
import '../model/User.dart';

class PlaceService {
  final String Emu = "http://10.0.2.2:3000";
  final String baseUrlApi = "http://192.168.0.123:3000/api";

  Future<List<PlaceModel>> fetchDataplace() async {
    Response response = await Dio().get("$baseUrlApi/places/all");
    List<PlaceModel> place =
        (response.data as List).map((v) => PlaceModel.fromJSON(v)).toList();
    return place;
  }

  Future<List<UserModel>> fetchDataUser(int idUser) async {
    Response response = await Dio().get("$baseUrlApi/user/$idUser");
    List<UserModel> user =
        (response.data as List).map((v) => UserModel.fromJSON(v)).toList();
    return user;
  }

  // Future<UserModel> fetchDataUser(int idUser) async {
  //   Response response = await Dio().get("$baseUrlApi/user/$idUser");
  //   UserModel user = UserModel.fromJSON(response.data);
  //   return user;
  // }
  Future<List<FavoriteModelDetail>> fetchDataFavorite(
      int placeId, int userId) async {
    Response response =
        await Dio().get("$baseUrlApi/bookmark/$placeId/$userId");

    List<FavoriteModelDetail> favorites = (response.data as List)
        .map((v) => FavoriteModelDetail.fromJSON(v))
        .toList();
    return favorites;
  }

  Future<List<FavoriteModel>> fetchDataFavoriteplace(int userId) async {
    Response response = await Dio().get("$baseUrlApi/bookmark/user/$userId");

    List<FavoriteModel> favoritelist =
        (response.data as List).map((v) => FavoriteModel.fromJSON(v)).toList();
    return favoritelist;
  }
}
