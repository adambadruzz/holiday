import 'package:flutter/material.dart';
import 'package:holidaysmobile/constant/constant.dart';
import 'package:holidaysmobile/viewmodel/holiday_services.dart';

import '../../model/Favorite.dart';
import '../../model/User.dart';
import '../../navigator/drawer.dart';

import '../detail/detailBookmark.dart';

class Favourite extends StatefulWidget {
  // final UserModel user;
  int user;
  Favourite({Key? key, required this.user}) : super(key: key);

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  int _currentIndex = 0;
  var lastIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorite'),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        drawer: DrawerWidget(
          user: widget.user,
        ),
        body: FutureBuilder<List<FavoriteModel>>(
          future: PlaceService().fetchDataFavoriteplace(widget.user),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return Container(
                  color: white,
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailBookmark(
                                          favorite: snapshot.data![index],
                                          user: widget.user,
                                          fetchplace: PlaceService()
                                              .fetchDataFavoriteplace(
                                                  widget.user),
                                          // studio: StudioModel(id: s,name: )
                                        )));
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 190,
                                width: 400,
                                // decoration: BoxDecoration(
                                //     image: DecorationImage(
                                //   fit: BoxFit.fill,
                                //   image: AssetImage(snapshot.data![index].cover),
                                // )),
                                child: Image.network(
                                  snapshot.data![index].cover,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].place_name,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: black),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        snapshot.data![index].short_description,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: black,
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        );
                      }),
                );
              }
            }
          },
        ));
  }
}
