import 'package:clone_carrot_market/data/contents_repository.dart';
import 'package:clone_carrot_market/utils/data_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'detailContentView.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final contentsRepository = ContentsRepository();
  String currentLocation = 'ara';
  final Map<String, String> locationTypeToString = {
    'ara': '아라동',
    'ora': '오라동',
    'donam': '도남동',
  };
  bool isLoading = false;

  Widget _makeDataList(List<Map<String, String>>? datas) {
    int size = datas?.length ?? 0;
    print('size? $size');
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 15),
      physics: ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        if (size > 0) {
          Map<String, String> data = datas![index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailContentView(data: data),
                  ));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: Hero(
                      tag: data['cid']!,
                      child: Image.asset(
                        data['image']!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      padding: const EdgeInsets.only(left: 20, top: 2),
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['title']!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 5),
                          Text(
                            data['location']!,
                            style: TextStyle(
                                fontSize: 12, color: Color(0xff999999)),
                          ),
                          SizedBox(height: 5),
                          Text(
                            DataUtils.calcStringToWon(data['price']!),
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5),
                          Expanded(
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 18,
                                    child: SvgPicture.asset(
                                      'assets/svg/heart_off.svg',
                                      width: 13,
                                      height: 13,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(data['likes']!),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          height: 1,
          color: Colors.black.withOpacity(0.1),
        );
      },
      itemCount: size,
    );
  }

  Future<List<Map<String, String>>> _loadContents() async {
    List<Map<String, String>> responseData =
        await contentsRepository.loadContentsFromLocation(currentLocation);
    return responseData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadContents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (snapshot.hasError)
          return Center(
            child: Text('data error'),
          );
        if (snapshot.hasData)
          return _makeDataList(snapshot.data as List<Map<String, String>>);

        return Center(
          child: Text('해당 지역에 데이터가 없습니다.'),
        );
      },
    );
  }
}
