import 'package:flutter/material.dart';
import 'package:flutter_test_app/models/image.dart';
import 'package:flutter_test_app/services/services.dart';

class Images extends ChangeNotifier {
  List<ImageModel> _imagesListData = [];

  List<ImageModel> get imagesListData {
    return [..._imagesListData];
  }

  Future<void> fetchData() async {
    final imagesList = await ImageServices().getImages();
    _imagesListData = imagesList;
    notifyListeners();
  }

  Future<void> fetchMoreData(int pageIndex) async {
    final moreImagesList = await ImageServices().getMoreImages(pageIndex);
    _imagesListData.addAll(moreImagesList);
    notifyListeners();
  }
}
