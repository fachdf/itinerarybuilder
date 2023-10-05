import 'package:flutter/material.dart';
import 'package:itinerarybuilder/places/place.dart';
import 'package:itinerarybuilder/places/city_detail.dart';


// class CityListScreen extends StatelessWidget {
//   final List<City> cityList;

//   CityListScreen({required this.cityList});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Place in Tokyo", 
//           style: TextStyle(
//             color: Color.fromARGB(255, 255, 255, 255),
//             fontWeight: FontWeight.bold, 
//             )
//         ),
//         backgroundColor: const Color(0xFFFF5900),
//       ),
//       body: ListView.builder(
//         itemCount: cityList.length,
//         itemBuilder: (BuildContext context, int index) {
//           final City city = cityList[index];
//           return ListTile(
//             leading: Image.network(city.imgUrls[0]), // Display the thumbnail image
//             title: Text(city.name),
//             onTap: () {
//               // Handle city tap, e.g., navigate to the city's details screen
//               // You can pass the selected city to the details screen.
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => CityDetailsScreen(city: city),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


class CityListScreen extends StatelessWidget {
  final List<City> cityList;

  CityListScreen({required this.cityList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Place in Tokyo", 
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold, 
            )
        ),
        backgroundColor: const Color(0xFFFF5900),
      ),
      body: ListView.builder(
        itemCount: cityList.length,
        itemBuilder: (BuildContext context, int index) {
          final City city = cityList[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      city.name,
                      style: TextStyle(
                        fontSize: 16.0, // Adjust font size as needed
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: 80.0, // Width of the thumbnail
                    height: 80.0, // Height of the thumbnail
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          city.imgUrls[0], // Display the thumbnail image
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                // Handle city tap, e.g., navigate to the city's details screen
                // You can pass the selected city to the details screen.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CityDetailsScreen(city: city),
                  ),
                );
              },
            ),
            color: const Color.fromARGB(255, 255, 255, 255), // Set the background color
          );
        },
      ),
    );
  }
}