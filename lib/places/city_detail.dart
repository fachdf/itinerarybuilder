import 'package:flutter/material.dart';
import 'package:itinerarybuilder/places/place.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:itinerarybuilder/places/place_detail.dart';

class CityDetailsScreen extends StatelessWidget {
  final City city;

  CityDetailsScreen({required this.city});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(city.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // CarouselSlider for city images (as shown in a previous answer)
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 16/9, // You can adjust the aspect ratio
              enlargeCenterPage: true,
            ),
            items: city.imgUrls.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('Details: ${city.details}'),
          ),
          Text(
            'Places in ${city.name}',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: city.places.length,
              itemBuilder: (BuildContext context, int index) {
                final Place place = city.places[index];
                return ListTile(
                  leading: Container(
                    width: 60.0, // Width of the thumbnail
                    height: 60.0, // Height of the thumbnail
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          place.imgUrls[0], // Display the thumbnail image
                        ),
                        fit: BoxFit.cover, // Crop the image to fit the container
                      ),
                    ),
                  ),
                  title: Text(place.name),
                  subtitle: Text('Price: \$${place.price}'),
                  onTap: () {
                    // Handle place tap, e.g., navigate to the place details screen
                    // You can pass the selected place to the details screen.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaceDetailsScreen(place: place),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}