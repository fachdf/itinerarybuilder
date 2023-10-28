// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'itinerary_place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItineraryPlace _$ItineraryPlaceFromJson(Map<String, dynamic> json) =>
    ItineraryPlace(
      Id: json['Id'] as String,
      Number: json['Number'] as int,
      VisitTime: json['VisitTime'] as int,
      IsVisited: json['IsVisited'] as int,
      PlaceId: json['PlaceId'] as String,
      ItineraryId: json['ItineraryId'] as String,
    );

Map<String, dynamic> _$ItineraryPlaceToJson(ItineraryPlace instance) =>
    <String, dynamic>{
      'Id': instance.Id,
      'Number': instance.Number,
      'VisitTime': instance.VisitTime,
      'IsVisited': instance.IsVisited,
      'PlaceId': instance.PlaceId,
      'ItineraryId': instance.ItineraryId,
    };
