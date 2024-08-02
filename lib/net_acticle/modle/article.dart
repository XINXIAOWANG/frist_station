class Article {
  final String title;
  final String url;
  final String time;

  Article({required this.title, required this.url, required this.time});

  //通过一个formMap构造通过map数据构造Article对象
  factory Article.formMap(dynamic map) {
    return Article(
        title: map['title'] ?? '未知',
        url: map["link"] ?? '',
        time: map['niceDate'] ?? '');
  }

  @override
  String toString() {
    return 'Article{title:$title,url:$url,niceDate:$time}';
  }
}
