import 'package:itinerarybuilder/models/itinerary_place.dart';
import 'package:json_annotation/json_annotation.dart';
part 'itinerary.g.dart';
@JsonSerializable()
class Itinerary {
  String Id;
  String Name;
  List<ItineraryPlace> itineraryPlaces;

  Itinerary({
    required this.Id,
    required this.Name,
    this.itineraryPlaces = const []
  });

    factory Itinerary.fromJson(Map<String, dynamic> json) => _$ItineraryFromJson(json);
    Map<String, dynamic> toJson() => _$ItineraryToJson(this);
}