import 'package:floor/floor.dart';

@entity
class CartEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  String title, description, category, imageUrl;
  double price;
  int quantity;

  CartEntity(
      {this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.imageUrl,
      required this.price,
      required this.quantity});
}
