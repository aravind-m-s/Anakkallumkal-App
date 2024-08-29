import 'package:anakallumkal_app/api/api_urls.dart';
import 'package:http/http.dart';

class InterceptedMultipartRequest extends MultipartRequest {
  InterceptedMultipartRequest(super.method, super.url);

  @override
  Future<StreamedResponse> send() async {
    return super.send();
  }
}

class ApiProvider {
  static getAllBrands() async {
    try {
      final request = InterceptedMultipartRequest(
        "GET",
        Uri.parse(
          ApiUrls.brandListEndPoint,
        ),
      );

      final response = await request.send();
      return Response.fromStream(response);
    } catch (e) {
      return e;
    }
  }

  static getAllCategories() async {
    try {
      final request = InterceptedMultipartRequest(
        "GET",
        Uri.parse(
          ApiUrls.categoryListEndPoint,
        ),
      );

      final response = await request.send();
      return Response.fromStream(response);
    } catch (e) {
      return e;
    }
  }

  static getAllFurnitures(String id, String query) async {
    try {
      final request = InterceptedMultipartRequest(
        "GET",
        Uri.parse(
          "${ApiUrls.furnitureListEndPoint}/$id${query.isEmpty ? "" : "?search=$query"}",
        ),
      );

      final response = await request.send();
      return Response.fromStream(response);
    } catch (e) {
      return e;
    }
  }

  static createFurniture(
    String name,
    String productNo,
    String stock,
    String price,
    String brand,
    String image,
    String category,
    String rows,
  ) async {
    try {
      final request = InterceptedMultipartRequest(
        "POST",
        Uri.parse(
          ApiUrls.furnitureCreateEndPoint,
        ),
      );
      request.fields['name'] = name;
      request.fields['product_no'] = productNo;
      request.fields['stock'] = stock;
      request.fields['price'] = price;
      request.fields['brand'] = brand;
      request.fields['category'] = category;
      request.fields['rows'] = rows;

      final mutlipartFile = await MultipartFile.fromPath('image', image);

      request.files.add(mutlipartFile);

      final response = await request.send();
      return Response.fromStream(response);
    } catch (e) {
      return e;
    }
  }

  static createBrand(
    String name,
    String shop,
    String image,
  ) async {
    try {
      final request = InterceptedMultipartRequest(
        "POST",
        Uri.parse(
          ApiUrls.brandCreateEndPoint,
        ),
      );
      request.fields['name'] = name;
      request.fields['shop'] = shop;

      print(request.fields);

      final mutlipartFile = await MultipartFile.fromPath('image', image);

      request.files.add(mutlipartFile);

      final response = await request.send();
      return Response.fromStream(response);
    } catch (e) {
      return e;
    }
  }

  static updateFurniture(
    String id,
    String name,
    String productNo,
    String stock,
    String price,
    String brand,
    String image,
    String category,
    String rows,
  ) async {
    try {
      final request = InterceptedMultipartRequest(
        "PUT",
        Uri.parse(
          "${ApiUrls.furnitureUpdateEndPoint}/$id",
        ),
      );
      request.fields['name'] = name;
      request.fields['product_no'] = productNo;
      request.fields['stock'] = stock;
      request.fields['price'] = price;
      request.fields['brand'] = brand;
      request.fields['category'] = category;
      request.fields['rows'] = rows;

      if (!image.startsWith("http")) {
        final mutlipartFile = await MultipartFile.fromPath('image', image);

        request.files.add(mutlipartFile);
      }

      final response = await request.send();
      return Response.fromStream(response);
    } catch (e) {
      return e;
    }
  }

  static updateBrand(
    String id,
    String name,
    String shop,
    String image,
  ) async {
    try {
      final request = InterceptedMultipartRequest(
        "PUT",
        Uri.parse(
          "${ApiUrls.brandUpdateEndPoint}/$id",
        ),
      );
      request.fields['name'] = name;
      request.fields['shop'] = shop;

      if (!image.startsWith("http")) {
        final mutlipartFile = await MultipartFile.fromPath('image', image);

        request.files.add(mutlipartFile);
      }

      final response = await request.send();
      return Response.fromStream(response);
    } catch (e) {
      return e;
    }
  }

  static deleteFurniture(
    String id,
  ) async {
    try {
      final request = InterceptedMultipartRequest(
        "DELETE",
        Uri.parse(
          "${ApiUrls.furnitureDeleteEndPoint}/$id",
        ),
      );

      final response = await request.send();
      return Response.fromStream(response);
    } catch (e) {
      return e;
    }
  }

  static deleteBrand(
    String id,
  ) async {
    try {
      final request = InterceptedMultipartRequest(
        "DELETE",
        Uri.parse(
          "${ApiUrls.brandDeleteEndPoint}/$id",
        ),
      );

      final response = await request.send();
      return Response.fromStream(response);
    } catch (e) {
      return e;
    }
  }

  static exportFurnitures(
    String id,
  ) async {
    try {
      final request = InterceptedMultipartRequest(
        "GET",
        Uri.parse(
          "${ApiUrls.furnitureExportEndPoint}/$id",
        ),
      );

      final response = await request.send();
      return Response.fromStream(response);
    } catch (e) {
      return e;
    }
  }
}
