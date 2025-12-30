class Metadata {
  int? currentPage;
  int? numberOfPages;
  int? limit;
  int? nextPage;

  Metadata({this.currentPage, this.numberOfPages, this.limit, this.nextPage});

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    currentPage: json['currentPage'] as int?,
    numberOfPages: json['numberOfPages'] as int?,
    limit: json['limit'] as int?,
    nextPage: json['nextPage'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'currentPage': currentPage,
    'numberOfPages': numberOfPages,
    'limit': limit,
    'nextPage': nextPage,
  };
}
