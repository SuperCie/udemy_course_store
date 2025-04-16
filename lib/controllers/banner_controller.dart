import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:les_store_app/global_variables.dart';
import 'package:les_store_app/models/bannermodel.dart';

class BannerController {
  // fetch banner
  Future<List<BannerModel>> fetchBanner() async {
    try {
      // send http get request to fetch banner
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> bannerData = jsonDecode(response.body);

        List<BannerModel> banners =
            bannerData.map((banner) => BannerModel.fromJson(banner)).toList();
        return banners;
      } else {
        // throw an execption if the server responded with an error status code
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      throw Exception('Error loading banner $e');
    }
  }
}
