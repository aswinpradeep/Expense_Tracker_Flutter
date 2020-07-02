class Article {
  
  String item;
  double amount;
  String date;
  String category;
 int type;

  Article(
      {this.item,
      this.amount,
      this.date,
      this.category,
      this.type,
      });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        item: json["ITEM"],
        amount: json["AMOUNT"],
        date: json["DATE"],
        category: json["CATEGORY"],
        type:json["TYPE"]
       );
  }
}
// class ArticleList {
//   final List<Article> article;

//   ArticleList({
//     this.article,
//   });

//   factory ArticleList.fromJson(List<dynamic> parsedJson) {

//     List<Article> article = new List<Article>();
//   article = parsedJson.map((i)=>Article.fromJson(i)).toList();
//     return new ArticleList(
//        article: article,
//     );
//   }
// }
