import 'package:itinerarybuilder/models/place.dart';
import 'package:json_annotation/json_annotation.dart';
part 'itinerary_place.g.dart';
@JsonSerializable()
class ItineraryPlace {
  String Id;
  int Number;
  int VisitTime;
  int IsVisited;
  String PlaceId;
  String ItineraryId;

  ItineraryPlace({
    required this.Id,
    required this.Number,
    required this.VisitTime,
    required this.IsVisited,
    required this.PlaceId,
    required this.ItineraryId
  });

  factory ItineraryPlace.fromJson(Map<String, dynamic> json) => _$ItineraryPlaceFromJson(json);
  Map<String, dynamic> toJson() => _$ItineraryPlaceToJson(this);
}