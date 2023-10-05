import 'package:flutter/material.dart';
import 'package:itinerarybuilder/places/place.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:itinerarybuilder/places/place_detail.dart';

class CityDetailsScreen extends StatefulWidget {
  final City city;

  CityDetailsScreen({required this.city});

  @override
  _CityDetailsScreenState createState() => _CityDetailsScreenState();
}

class _CityDetailsScreenState extends State<CityDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.city.name,
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFF5900),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8, // Adjust the width as needed
              height: 256.0, // Adjust the aspect ratio as needed
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                ),
                items: widget.city.imgUrls.map((imageUrl) {
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
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Details: ${widget.city.details}'),
            ),
            Text(
              'Places in ${widget.city.name}',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            ListView.builder(
              shrinkWrap: true, // Important to allow the ListView to scroll within a SingleChildScrollView
              physics: NeverScrollableScrollPhysics(), // Disable scrolling for the inner ListView
              itemCount: widget.city.places.length,
              itemBuilder: (BuildContext context, int index) {
                final Place place = widget.city.places[index];
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
                  trailing: IconButton(
                    icon: Icon(
                      place.isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: place.isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        // Toggle the favorite status
                        place.isFavorite = !place.isFavorite;
                      });
                    },
                  ),
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
          ],
        ),
      ),
    );
  }
}
