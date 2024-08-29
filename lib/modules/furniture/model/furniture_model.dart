class FurnitureModel {
  String name;
  String id;
  String image;
  String productNo;
  int stock;
  int price;
  int rows;
  FurnitureCategoryModel category;

  FurnitureModel({
    required this.name,
    required this.id,
    required this.image,
    required this.productNo,
    required this.stock,
    required this.price,
    required this.rows,
    required this.category,
  });

  factory FurnitureModel.fromJson(Map<String, dynamic> json) => FurnitureModel(
        name: json["name"],
        id: json["id"],
        image: json["image"],
        productNo: json["product_no"],
        stock: json["stock"],
        price: json["price"],
        rows: json["rows"],
        category: FurnitureCategoryModel.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "image": image,
        "product_no": productNo,
        "stock": stock,
        "price": price,
        "rows": rows,
        "category": category.toJson()
      };
}

class FurnitureCategoryModel {
  String id;
  String name;
  Category category;

  FurnitureCategoryModel({
    required this.id,
    required this.name,
    required this.category,
  });

  factory FurnitureCategoryModel.fromJson(Map<String, dynamic> json) =>
      FurnitureCategoryModel(
        id: json["id"],
        name: json["name"],
        category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category.toJson(),
      };
}

class Category {
  String id;
  String name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
