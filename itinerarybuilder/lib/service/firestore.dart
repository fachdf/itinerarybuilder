import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:itinerarybuilder/models/itinerary.dart';
import 'package:itinerarybuilder/models/place.dart';
import 'package:rxdart/rxdart.dart';


class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Reads all documments from the topics collection
  Future<List<Place>> getPlace() async {
    var ref = _db.collection('places');
    var snapshot = await ref.get();
    var places = snapshot.docs.map((DocumentSnapshot document) {
      final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id; // Retrieve the document's ID
      data['Id'] = document.id;
      return Place.fromJson(data); // Pass the 'id' to the 'fromJson' constructor
    }).toList();

    return places;
  }

  /// Retrieves a single quiz document
  Future<Place> getPlaceById(String Id) async {
    var ref = _db.collection('places').doc(Id);
    var snapshot = await ref.get();
    var data = snapshot.data();
    
    if (data != null && data is Map<String, dynamic>) {
      data['Id'] = Id;
      return Place.fromJson(data);
    } else {
      // Handle the case where no data is found for the given ID
      return Place(Id: 'unknown', Name: 'unknown');
    }
  }

  Future<String> addPlace(String Name, String Address, String Description, String GoogleMapUrl, List<String> PhotoUrls) async {
    CollectionReference ref = _db.collection('places');
    
    await ref.add({
      "Name" : Name,
      "Address": Address,
      "Description": Description,
      "PhotoUrls": PhotoUrls
    });
    
    return "Ok";
  }

  Future<List<Itinerary>> getAllItinerary() async {
    var ref = _db.collection('itineraries');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var itineraries = snapshot.docs.map((DocumentSnapshot document) {
      final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String id = document.id; // Retrieve the document's ID
      data['Id'] = document.id;
      return Itinerary.fromJson(data); // Pass the 'id' to the 'fromJson' constructor
    }).toList();
    return itineraries;
  }

  Future<Itinerary> getItineraryById(String Id) async {
    var ref = _db.collection('itineraries').doc(Id);
    var snapshot = await ref.get();
    var data = snapshot.data();

    if (data != null && data is Map<String, dynamic>) {
      data['Id'] = Id;
      return Itinerary.fromJson(data);
    } else {
      // Handle the case where no data is found for the given ID
      return Itinerary(Id: "Unknown", Name: 'Unknown');
    }
  }

  Future<String> addItinerary(String Name) async {
    CollectionReference ref = _db.collection('itineraries');
    
    await ref.add({
      "Name" : Name,
    });
    
    return "Ok";
  }

  Future<String> addItineraryPlace(int Number, int VisitTime, int IsVisited, String PlaceId, String ItineraryId) async {
    CollectionReference ref = _db.collection('itineraryplace');
    
    await ref.add({
      "Number" : Number,
      "VisitTime" : VisitTime,
      "IsVisited" : IsVisited,
      "PlaceId" : PlaceId,
      "ItineraryId" : ItineraryId
    });
    
    return "Ok";
  }


  Future<List<Place>> getPlacesForItinerary(String Id) async {
    try {
      List<Place> places = [];
     // print(Id);
      final itineraryPlacesQuery = await _db
          .collection('itineraryplace')
          .where('ItineraryId', isEqualTo: Id)
          .get();
      //print(itineraryPlacesQuery.docs[0]['PlaceId']);
      for(var itineraryPlaceDoc in itineraryPlacesQuery.docs){
        
        String placeId = itineraryPlaceDoc['PlaceId'];
        
        // Fetch the corresponding Place document
        var placeSnapshot = await _db
            .collection('places')
            .doc(placeId)
            .get();
        
        var data = placeSnapshot.data();
        //print(placeSnapshot.id);
        if (data != null && data is Map<String, dynamic>) {
          data['Id'] = placeSnapshot.id;
          
          Place place = Place.fromJson(data);
          places.add(place);
        }

      }

      return places;
    } catch (e) {
      throw Exception('Failed to get places for the itinerary: $e');
    }
  }

  Future<void> deleteItineraryPlace(String itineraryId, String placeId) async {
  try {
    var collectionReference = FirebaseFirestore.instance.collection('itineraryplace');
    
    // Query the 'itineraryplace' collection to find documents that match the criteria
    var query = collectionReference.where('ItineraryId', isEqualTo: itineraryId).where('PlaceId', isEqualTo: placeId);
    
    // Get the documents that match the query
    var querySnapshot = await query.get();
    
    // Iterate through the documents and delete them
    for (var doc in querySnapshot.docs) {
      await collectionReference.doc(doc.id).delete();
    }
  } catch (e) {
    // Handle errors, e.g., show an error message
    print('Failed to delete itineraryplace: $e');
  }
}

}

