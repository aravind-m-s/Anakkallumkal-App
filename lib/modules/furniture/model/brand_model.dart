import 'package:anakallumkal_app/modules/furniture/model/shop_model.dart';

class BrandModel {
  String id;
  String name;
  String image;
  ShopModel shop;
  int count;

  BrandModel({
    required this.id,
    required this.name,
    required this.image,
    required this.shop,
    required this.count,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        shop: ShopModel.fromJson(json["shop"]),
        count: json["count"]);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "shop": shop.toJson(),
      };
}
