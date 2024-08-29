class CategoryModel {
  String id;
  String name;
  List<SubCategory> subCategories;

  CategoryModel({
    required this.id,
    required this.name,
    required this.subCategories,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        subCategories: List<SubCategory>.from(
            json["sub_categories"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sub_categories":
            List<dynamic>.from(subCategories.map((x) => x.toJson())),
      };
}

class SubCategory {
  String id;
  String name;

  SubCategory({
    required this.id,
    required this.name,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
