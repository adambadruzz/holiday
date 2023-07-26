import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../constant/constant.dart';
import '../../model/Favorite.dart';
import '../../model/Place.dart';
import '../../model/User.dart';

import '../../viewmodel/holiday_services.dart';
import '../profile/profile.dart';

class DetailPlace extends StatefulWidget {
  final PlaceModel place;
  int user;
  Future<List<PlaceModel>> fetchplace;
  DetailPlace(
      {Key? key,
      required this.place,
      required this.user,
      required this.fetchplace})
      : super(key: key);

  @override
  State<DetailPlace> createState() => _DetailPlaceState();
}

class _DetailPlaceState extends State<DetailPlace> {
  Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    Widget IconFavoriteModels = FutureBuilder<List<FavoriteModelDetail>>(
        future: PlaceService()
            .fetchDataFavorite(widget.place.id_place, widget.user),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              Color favcolor = Color.fromARGB(255, 124, 192, 23);

              if (snapshot.data!.length > 0) {
                favcolor = Colors.red;
                return IconButton(
                  icon: Icon(
                    Icons.bookmark,
                    color: favcolor,
                  ),
                  onPressed: () async {
                    dio.delete(
                        '${PlaceService().baseUrlApi}/bookmark/${snapshot.data![0].id_bookmark}');

                    setState(() {
                      favcolor = Colors.black;
                    });

                    // Restart.restartApp();
                  },
                );
              } else {
                favcolor = Color.fromARGB(255, 255, 255, 255);
                return IconButton(
                  icon: Icon(
                    Icons.bookmark_add,
                    color: favcolor,
                  ),
                  onPressed: () async {
                    Map<String, dynamic> uploadBookmark = {
                      "place_id": widget.place.id_place,
                      "user_id": widget.user,
                    };

                    var responseApi = await dio.post(
                        '${PlaceService().baseUrlApi}/bookmark',
                        data: uploadBookmark);
                    debugPrint(responseApi.data.toString());

                    setState(() {
                      favcolor = Colors.red;
                    });
                    // Restart.restartApp();
                  },
                );
              }
            }
          }
        });

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: <Widget>[IconFavoriteModels],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(5),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text("${widget.place.place_name}",
                            style: Theme.of(context).textTheme.headline6),
                      ),
                      Text(
                        "${widget.place.short_description}",
                        style:
                            TextStyle(color: Color.fromARGB(255, 49, 49, 49)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${widget.place.asal}",
                        style:
                            TextStyle(color: Color.fromARGB(255, 49, 49, 49)),
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 395,
              height: 470,
              child: Image.network(
                widget.place.cover,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                "${widget.place.description}",
                style: Theme.of(context).textTheme.bodyText2,
                softWrap: true,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        )));
  }
}
