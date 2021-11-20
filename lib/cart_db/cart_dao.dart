import 'package:floor/floor.dart';
import 'cart_entity.dart';

@dao
abstract class CartDao{
  @Query('SELECT * FROM CartEntity')
  Stream<List<CartEntity>> getAllCartItems();

  /*@Query('SELECT * FROM Employee WHERE id = :id')
  Stream<Employee?> getAllEmployeeById(int id);*/

  @Query('DELETE FROM CartEntity')
  Future<void> deleteAllCartItems();

  @insert
  Future<void> insertCartItem(CartEntity cartEntity);

  @update
  Future<void> updateCartItem(CartEntity cartEntity);

  @delete
  Future<void> deleteCartItem(CartEntity cartEntity);

}