import 'dart:convert';
import 'dart:math';
import 'package:artistic_wallpapers/model/categoryModel.dart';
import 'package:artistic_wallpapers/model/photosModel.dart';
import 'package:http/http.dart' as http;

class ApiOperations {
  static List<PhotosModel> trendingWallpapers = [];
  static List<PhotosModel> searchWallpapersList = [];
  static List<CategoryModel> cateogryModelList = [];

  static String _apiKey =
      "PN0EG13VpAqTQTQ5zxnmwkb65ye3JfL8XP3KeI4zvukY7jI6Q6Qm8FhK";

  static Future<List<PhotosModel>> getTrendingWallpaers() async {
    await http.get(Uri.parse("https://api.pexels.com/v1/curated"),
        headers: {"Authorization": "$_apiKey"}).then((value) {
      print("RESPONSE REPORT");
      print(value.body);
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      photos.forEach((element) {
        trendingWallpapers.add(PhotosModel.formAPI2App(element));
      });
    });

    return trendingWallpapers;
  }

  static Future<List<PhotosModel>> searchWallpapers(String query) async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        headers: {"Authorization": "$_apiKey"}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpapersList.clear();
      photos.forEach((element) {
        searchWallpapersList.add(PhotosModel.formAPI2App(element));
      });
    });

    return searchWallpapersList;
  }

  static List<CategoryModel> getCategoriesList() {
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    cateogryModelList.clear();
    cateogryName.forEach((catName) async {
      final _random = new Random();

      PhotosModel photoModel =
          (await searchWallpapers(catName))[0 + _random.nextInt(11 - 0)];
      print("IMG SRC IS HERE");
      print(photoModel.imgSrc);
      cateogryModelList
          .add(CategoryModel(catImgUrl: photoModel.imgSrc, catName: catName));
    });

    return cateogryModelList;
  }
}

