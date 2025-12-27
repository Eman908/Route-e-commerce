class Banners {
  String? imagePath;
  String? title;
  String? categoryName;
  String? alignment;
  int? btnColor;
  int? textColor;

  Banners({
    this.imagePath,
    this.title,
    this.categoryName,
    this.alignment,
    this.btnColor,
    this.textColor,
  });

  factory Banners.fromJson(Map<String, dynamic> json) => Banners(
    imagePath: json['image_path'] as String?,
    title: json['title'] as String?,
    categoryName: json['category_name'] as String?,
    alignment: json['alignment'] as String?,
    btnColor: json['btn_color'] as int?,
    textColor: json['text_color'] as int?,
  );

  Map<String, dynamic> toJson() => {
    'image_path': imagePath,
    'title': title,
    'category_name': categoryName,
    'alignment': alignment,
    'btn_color': btnColor,
    'text_color': textColor,
  };
}
