import 'package:dio/dio.dart';
import 'package:flutter_test_app/models/image.dart';

class ImageServices {
  final String mainUrl = 'https://picsum.photos/v2/list';
  final Dio _dio = Dio();
  int pageImage=1;

  Future<List<ImageModel>> getImages() async {
    var params = {
      'page': pageImage,
    };
    try {
      Response response = await _dio.get(mainUrl, queryParameters: params);
      final imagesList = response.data as List;
      return imagesList.map((imageItem) => ImageModel.fromJson(imageItem)).toList();
    } catch (error) {
      print('this Error ----> $error');
      return null;
    }
  }

  Future<List<ImageModel>> getMoreImages(int pageIndex) async {
    var params = {
      'page': pageIndex,
    };
    try {
      Response response = await _dio.get(mainUrl, queryParameters: params);
      final imagesList = response.data as List;
      return imagesList.map((imageItem) => ImageModel.fromJson(imageItem)).toList();
    } catch (error) {
      print('this Error ----> $error');
      return null;
    }
  }

}
