import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../model/Favorite.dart';
import '../../model/User.dart';

import '../../viewmodel/holiday_services.dart';
import '../login/login.dart';
import '../profile/profile.dart';

class DetailBookmark extends StatefulWidget {
  final FavoriteModel favorite;
  int user;
  Future<List<FavoriteModel>> fetchplace;
  DetailBookmark(
      {Key? key,
      required this.favorite,
      required this.user,
      required this.fetchplace})
      : super(key: key);

  @override
  State<DetailBookmark> createState() => _DetailBookmarkState();
}

class _DetailBookmarkState extends State<DetailBookmark> {
  Dio dio = Dio();
  // getStudio() async {
  //   var studioId = comic.studioId;
  //   var getstudio = await ComicService().fetchDataStudio(studioId);
  //   return getstudio.toString();
  // }

  @override
  Widget build(BuildContext context) {
    Widget IconFavoriteModels = FutureBuilder<List<FavoriteModelDetail>>(
        future: PlaceService()
            .fetchDataFavorite(widget.favorite.place_id, widget.user),
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
                      favcolor = Color.fromARGB(255, 255, 255, 255);
                    });
                    // Restart.restartApp();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                );
              } else {
                favcolor = Colors.black;
                return IconButton(
                  icon: Icon(
                    Icons.bookmark_add,
                    color: favcolor,
                  ),
                  onPressed: () async {
                    Map<String, dynamic> uploadBookmark = {
                      "comic_id": widget.favorite.id_bookmark,
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
              padding: const EdgeInsets.all(16),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text("${widget.favorite.place_name}",
                            style: Theme.of(context).textTheme.headline6),
                      ),
                      Text(
                        "${widget.favorite.short_description}",
                        style: TextStyle(
                            color: Color.fromARGB(255, 49, 49, 49),
                            fontSize: 12),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${widget.favorite.asal}",
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
                widget.favorite.cover,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                "${widget.favorite.description}",
                style: Theme.of(context).textTheme.bodyText2,
                softWrap: true,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        )));
  }
}
