// import 'package:dio/dio.dart';

// class RunService {
//   static Future<List<dynamic>> getRunJson() async {
//     Dio dio = Dio();

//     var response = await dio.get('http://localhost:3004/shoes');
//     return response.data;
//   }
// }

import 'package:dio/dio.dart';
import 'package:runs/models/shoes.dart';

import '../models/shoes.dart';
import '../models/user.dart';

class RunService {
  static Future<List<Shoes>> fetchShoes() async {
    Response response = await Dio().get("http://localhost:3004/shoes");
    List<Shoes> Shoess =
        (response.data as List).map((v) => Shoes.fromJSON(v)).toList();
    return Shoess;
  }

  static Future<List<Shoes>> fetchShoesBasedbrand(String category) async {
    Response response =
        await Dio().get("http://localhost:3004/shoes?category=" + category);
    List<Shoes> Shoess =
        (response.data as List).map((v) => Shoes.fromJSON(v)).toList();
    return Shoess;
  }

  static Future<List<User>> fetchUserBasedId(String id) async {
    Response response = await Dio().get("http://localhost:3004/user?id=" + id);
    List<User> users =
        (response.data as List).map((v) => User.fromJSON(v)).toList();
    return users;
  }

  static Future<List<Shoes>> fetchShoesBasedLike() async {
    Response response =
        await Dio().get("http://localhost:3004/shoes?isSaved=true");
    List<Shoes> Shoess =
        (response.data as List).map((v) => Shoes.fromJSON(v)).toList();
    return Shoess;
  }
}