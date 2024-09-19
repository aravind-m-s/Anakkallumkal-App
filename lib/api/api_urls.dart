import 'package:flutter/foundation.dart';

class ApiUrls {
  static const String _baseUrl =
      "${!kDebugMode ? "http://localhost:8080" : "https://anakallumkal.aravind.uk"}/api";
  static const String mediaUrl =
      "${!kDebugMode ? "http://localhost:8080" : "https://anakallumkal.aravind.uk"}/";

  static const String brandEndPoint = "$_baseUrl/brand";

  static const String brandListEndPoint = "$brandEndPoint/list";
  static const String brandCreateEndPoint = "$brandEndPoint/create";
  static const String brandDeleteEndPoint = brandEndPoint;
  static const String brandUpdateEndPoint = brandEndPoint;

  static const String furnitureEndPoint = "$_baseUrl/furniture";

  static const String furnitureListEndPoint = "$furnitureEndPoint/list";
  static const String furnitureCreateEndPoint = "$furnitureEndPoint/create";
  static const String furnitureDeleteEndPoint = furnitureEndPoint;
  static const String furnitureUpdateEndPoint = furnitureEndPoint;
  static const String furnitureExportEndPoint = "$furnitureEndPoint/export";

  static const String categoryEndPoint = "$_baseUrl/category";

  static const String categoryListEndPoint = "$categoryEndPoint/list";
  static const String categoryCreateEndPoint = "$categoryEndPoint/create";
  static const String categoryDeleteEndPoint = categoryEndPoint;
  static const String categoryUpdateEndPoint = categoryEndPoint;

  static const String subCategoryEndPoint = "$categoryEndPoint/sub/category";

  static const String subCategoryCreateEndPoint = "$subCategoryEndPoint/create";
  static const String subCategoryDeleteEndPoint = subCategoryEndPoint + "/";
  static const String subCategoryUpdateEndPoint = subCategoryEndPoint + "/";
}
