class ShopModel {
  String id;
  String name;
  String place;
  String image;

  ShopModel({
    required this.id,
    required this.name,
    required this.place,
    required this.image,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        id: json["id"],
        name: json["name"],
        place: json["place"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "place": place,
        "image": image,
      };
}
