// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Place _$PlaceFromJson(Map<String, dynamic> json) => Place(
      Id: json['Id'] as String,
      Name: json['Name'] as String,
      Address: json['Address'] as String?,
      Description: json['Description'] as String?,
      GoogleMapUrl: json['GoogleMapUrl'] as String?,
      PhotoUrls: (json['PhotoUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PlaceToJson(Place instance) => <String, dynamic>{
      'Id': instance.Id,
      'Name': instance.Name,
      'Address': instance.Address,
      'Description': instance.Description,
      'GoogleMapUrl': instance.GoogleMapUrl,
      'PhotoUrls': instance.PhotoUrls,
    };
