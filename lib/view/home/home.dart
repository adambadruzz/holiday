import 'package:flutter/material.dart';
import 'package:holidaysmobile/view/detail/detailPlace.dart';

import '../../constant/constant.dart';
import '../../model/Place.dart';
import '../../model/User.dart';
import '../../navigator/drawer.dart';
import '../../viewmodel/holiday_services.dart';

class Home extends StatefulWidget {
  // final UserModel user;
  int user;
  Home({Key? key, required this.user}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  var lastIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      drawer: DrawerWidget(
        user: widget.user,
      ),
      body: FutureBuilder<List<PlaceModel>>(
        future: PlaceService().fetchDataplace(),
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
                                  builder: (context) => DetailPlace(
                                        place: snapshot.data![index],
                                        user: widget.user,
                                        fetchplace:
                                            PlaceService().fetchDataplace(),
                                      )));
                        },
                        child: Column(
                          children: [
                            SizedBox(
                              height: 190,
                              width: 400,
                              child: Image.network(
                                snapshot.data![index].cover,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                    const SizedBox(height: 20),
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
      ),
    );
  }
}
