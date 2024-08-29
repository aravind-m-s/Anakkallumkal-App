part of 'furniture_bloc.dart';

sealed class FurnitureEvent extends Equatable {
  const FurnitureEvent();

  @override
  List<Object> get props => [];
}

final class GetAllBrandsEvent extends FurnitureEvent {}

final class GetAllCategoriesEvent extends FurnitureEvent {}

final class GetAllFurnituresEvent extends FurnitureEvent {
  final BrandModel brand;
  final String query;

  const GetAllFurnituresEvent({required this.brand, this.query = ''});
}

final class UpdateStateEvent extends FurnitureEvent {}

class CreateFurnitureEvent extends FurnitureEvent {
  final String name;
  final String productNo;
  final String stock;
  final String price;
  final String brand;
  final String image;
  final String categoryId;
  final String rows;

  const CreateFurnitureEvent({
    required this.name,
    required this.productNo,
    required this.stock,
    required this.price,
    required this.brand,
    required this.image,
    required this.categoryId,
    required this.rows,
  });
}

class UpdateFurnitureEvent extends FurnitureEvent {
  final String id;
  final String name;
  final String productNo;
  final String stock;
  final String price;
  final String brand;
  final String image;
  final String categoryId;
  final String rows;

  const UpdateFurnitureEvent({
    required this.id,
    required this.name,
    required this.productNo,
    required this.stock,
    required this.price,
    required this.brand,
    required this.image,
    required this.categoryId,
    required this.rows,
  });
}

class CreateBrandEvent extends FurnitureEvent {
  final String name;
  final String shop;
  final String image;

  const CreateBrandEvent({
    required this.name,
    required this.shop,
    required this.image,
  });
}

class UpdateBrandEvent extends FurnitureEvent {
  final String id;
  final String name;
  final String shop;
  final String image;

  const UpdateBrandEvent({
    required this.id,
    required this.name,
    required this.shop,
    required this.image,
  });
}

class DeleteBrandEvent extends FurnitureEvent {
  final String id;

  const DeleteBrandEvent({required this.id});
}

class DeleteFurnitureEvent extends FurnitureEvent {
  final String id;

  const DeleteFurnitureEvent({required this.id});
}

class ExportFurnituresEvent extends FurnitureEvent {}
