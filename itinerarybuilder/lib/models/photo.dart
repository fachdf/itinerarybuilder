class Photo {
  final int Id;
  final String Url;

  Photo({
    required this.Id,
    required this.Url
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      Id: json['id'],
      Url: json['url'],
    );
  }
}