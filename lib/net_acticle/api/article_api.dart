import 'package:dio/dio.dart';
import 'package:first_station/net_acticle/modle/article.dart';

class ArticleApi {
  static const String kBaseUrl = 'https://www.wanandroid.com';
  final Dio _client = Dio(BaseOptions(baseUrl: kBaseUrl));

  Future<List<Article>> loadArticles(int page) async {
    String path = '/article/list/$page/json';
    var reslut = await _client.get(path);
    if (reslut.statusCode == 200) {
      if (reslut.data != null) {
        var data = reslut.data['data']['datas'] as List;
        return data.map(Article.formMap).toList();
      }
    }
    return [];
  }
}
