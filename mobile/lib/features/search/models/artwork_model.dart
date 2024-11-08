class ArtworkModel {
  final Result result;

  ArtworkModel({required this.result});

  factory ArtworkModel.fromJson(Map<String, dynamic> json) {
    return ArtworkModel(
      result: Result.fromJson(json['result']),
    );
  }
}

class Result {
  final int total;
  final List<Artwork> results;

  Result({required this.total, required this.results});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      total: json['total'],
      results: (json['results'] as List)
          .map((item) => Artwork.fromJson(item))
          .toList(),
    );
  }
}

class Artwork {
  final int objectID;
  final String title;
  final String artistName;
  final String primaryImage;
  final String department;
  final String objectURL;

  Artwork({
    required this.objectID,
    required this.title,
    required this.artistName,
    required this.primaryImage,
    required this.department,
    required this.objectURL,
  });

  factory Artwork.fromJson(Map<String, dynamic> json) {
    return Artwork(
      objectID: json['objectID'],
      title: json['title'],
      artistName: json['artistName'],
      primaryImage: json['primaryImage'],
      department: json['department'],
      objectURL: json['objectURL'],
    );
  }
}