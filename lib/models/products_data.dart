/// id : 5
/// title : "John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet"
/// price : 695
/// description : "From our Legends Collection, the Naga was inspired by the mythical water dragon that protects the ocean's pearl. Wear facing inward to be bestowed with love and abundance, or outward for protection."
/// category : "jewelery"
/// image : "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg"
/// rating : {"rate":4.6,"count":400}

class ProductsData {
  ProductsData({
      int? id,
      String? title, 
      int? price, 
      String? description, 
      String? category, 
      String? image, 
      Rating? rating,}){
    _id = id;
    _title = title;
    _price = price;
    _description = description;
    _category = category;
    _image = image;
    _rating = rating;
}


  ProductsData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _price = json['price'];
    _description = json['description'];
    _category = json['category'];
    _image = json['image'];
    _rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }
  int? _id;
  String? _title;
  int? _price;
  String? _description;
  String? _category;
  String? _image;
  Rating? _rating;

  int? get id => _id;
  String? get title => _title;
  int? get price => _price;
  String? get description => _description;
  String? get category => _category;
  String? get image => _image;
  Rating? get rating => _rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['price'] = _price;
    map['description'] = _description;
    map['category'] = _category;
    map['image'] = _image;
    if (_rating != null) {
      map['rating'] = _rating?.toJson();
    }
    return map;
  }

}

class CustomProduct {
  final String title;
  final String price;
  final String description;
  final String category;
  final String imageUrl;

  CustomProduct(
      this.title, this.price, this.description, this.category, this.imageUrl);
}

/// rate : 4.6
/// count : 400

class Rating {
  Rating({
      double? rate, 
      int? count,}){
    _rate = rate;
    _count = count;
}

  Rating.fromJson(dynamic json) {
    _rate = json['rate'];
    _count = json['count'];
  }
  double? _rate;
  int? _count;

  double? get rate => _rate;
  int? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rate'] = _rate;
    map['count'] = _count;
    return map;
  }

}