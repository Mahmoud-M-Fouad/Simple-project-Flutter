class ProductModel{
  final int id;
  final String title;
  final String price;
  final String category;
  final String description;
  final String image;
  //final RatingModel rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    //required this.rating
});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: /*int.parse*/(json["id"]),
      title: json["title"],
      price: json["price"].toString(),
      description: json["description"],
      category: json["category"],
      image: json["image"],
      //rating: RatingModel.fromJson(json["rating"]),
    );
  }
//

}
class RatingModel{
  final String rate;
  final String count;

  RatingModel({required this.rate,required this.count});

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: /*double.parse*/(json["rate"]).toString(),
      count: /*int.parse*/(json["count"]).toString(),
    );
  }
//
}