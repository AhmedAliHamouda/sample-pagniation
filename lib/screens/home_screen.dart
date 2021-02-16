import 'package:flutter/material.dart';
import 'package:flutter_test_app/providers/images_provider.dart';
import 'package:flutter_test_app/services/services.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _sc = new ScrollController();
  int pageIndex=1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _sc.addListener(() async {
      if (_sc.position.pixels ==
          _sc.position.maxScrollExtent) {
          pageIndex++;
         await Provider.of<Images>(context,listen: false).fetchMoreData(pageIndex);
      }
    });
  }
  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test App'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Provider.of<Images>(context, listen: false).fetchData(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<Images>(
                builder: (context, images, index) {
                  if (images.imagesListData.length <= 0) {
                    return Center(
                      child: Text('No photos'),
                    );
                  } else {
                    return GridView.builder(
                      controller: _sc,
                      padding: EdgeInsets.all(5.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio:2.5,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 2.0,
                      ),
                      itemCount: images.imagesListData.length+1,
                      itemBuilder: (context, index) {
                        if(index==images.imagesListData.length){
                          return  Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }else {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                            ),
                            elevation: 2.0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0),
                              ),
                              child: GridTile(
                                child: Image.network(
                                  images.imagesListData[index].downloadUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }

                      },
                    );
                  }
                },
              ),
      ),
    );
  }
}
