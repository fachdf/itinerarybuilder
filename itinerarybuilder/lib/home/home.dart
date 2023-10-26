import 'package:flutter/material.dart';
import 'package:itinerarybuilder/models/place.dart';
import 'package:itinerarybuilder/places/place_detail.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Place> recommendedPlace = [];
  int numberSavedPlace = 0;


  @override
  void initState() {
    super.initState();
    // Calculate the saved places within the screen
    // recommendedPlace = getRandomPlaces(cityList, 2);
    // numberSavedPlace = getSavedPlace(cityList);
  }
  // int getSavedPlace(List<City> cityList){
  //   List<Place> savedPlaces = [];
  //   int counter = 0;
  //   for (City city in cityList) {
  //     for (Place place in city.places) {
  //       if (place.isFavorite) {
  //         counter++;
  //       }
  //     }
  //   }

  //   return counter;
  // }

  // List<Place> getRandomPlaces(List<City> cityList, int count) {
  //   List<Place> randomPlaces = [];
  //   final Random random = Random();
  //   int numberSavedPlace = 0;
  //   count = count.clamp(0, cityList.fold<int>(
  //     0,
  //     (sum, city) => sum + city.places.length,
  //   ));

  //   while (randomPlaces.length < count) {
  //     // Randomly select a city
  //     final City randomCity = cityList[random.nextInt(cityList.length)];

  //     // Randomly select a place from the selected city
  //     final Place randomPlace =
  //         randomCity.places[random.nextInt(randomCity.places.length)];

      
  //     // Add the selected place to the list if it's not already included
  //     if (!randomPlaces.contains(randomPlace)) {
  //       randomPlaces.add(randomPlace);
  //     }
  //   }

  //   return randomPlaces;
  // }

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 75.0,
                left: 32.0,
                right: 16.0,
              ),
              color: const Color(0xFFFF5900),
              width: MediaQuery.of(context).size.width,
              //height: 512,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello,',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Where are you going today?',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Recommended Places to Go',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                  // Column(
                  //   children: recommendedPlace.map((place) {
                  //     return Container(
                  //       margin: EdgeInsets.all(5),
                  //       child: ClipRRect(
                  //         borderRadius: BorderRadius.circular(10.0), 
                  //         child: ColoredBox(
                  //             color: Color.fromARGB(255, 179, 70, 7),
                  //           child: Ink(
                  //             color: Color.fromARGB(0, 0, 0, 0),
                  //             child: ListTile(
                  //               tileColor: Colors.blue,
                  //               leading: Container(
                  //                 width: 60.0,
                  //                 height: 60.0,
                  //                 decoration: BoxDecoration(
                  //                   image: DecorationImage(
                  //                     image: NetworkImage(place.imgUrls[0]),
                  //                     fit: BoxFit.cover,
                  //                   ),
                  //                 ),
                  //               ),
                  //               title: Text(place.name, 
                  //                 style: TextStyle(
                  //                 fontSize: 14.0,
                  //                 color: Colors.white,
                  //                 ),
                  //               ),
                  //               subtitle: Text('Price: ¥${place.price}', 
                  //                 style: TextStyle(
                  //                 fontSize: 14.0,
                  //                 color: Colors.white,
                  //                 ),),
                  //               onTap: () {
                  //                 Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                     builder: (context) =>
                  //                         PlaceDetailsScreen(place: place),
                  //                   ),
                  //                 );
                  //               },
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     );
                  //   }).toList(),
               //     
                //  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              
              decoration: BoxDecoration(
                  color: const Color(0xFFFF5900),
                  borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
                  border: Border.all(
                    color: const Color(0xFFFF5900), // Border color
                    width: 2.0, // Border width
                  ),
                ),
              //color: const Color(0xFFFF5900),
              width: MediaQuery.of(context).size.width * 0.95,
              height: 100,
              child: Center(
                child: 
                  Text("You've Saved ${numberSavedPlace} Places.", 
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),))
                    ,
              ),
              
          ],
        ),
      ),

    );
  }
}
