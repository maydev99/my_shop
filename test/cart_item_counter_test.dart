import 'package:flutter_test/flutter_test.dart';
import 'package:layout/utils/providers.dart';

void main() {
  group('Test CartItemCounter Provider', () {


    test('Add to counter', () {
      var cartItemCounter = CartItemCounter();
      expect(cartItemCounter.itemCount, 0); //Check counter is zero to start
      cartItemCounter.plusOne();
      expect(cartItemCounter.itemCount, 1);
    });

    test('Add to counter 10 times', () {
      var cartItemCounter = CartItemCounter();
      expect(cartItemCounter.itemCount, 0); //Check counter is zero to start
      var index = 0;
      while(index < 10) {
        index++;
        cartItemCounter.plusOne();
      }
      expect(cartItemCounter.itemCount, 10);
      index = 0;
    });

    test('Add to counter the remove from counter', () {
      var cartItemCounter = CartItemCounter();
      expect(cartItemCounter.itemCount, 0); //Check counter is zero to start
      cartItemCounter.plusOne();
      expect(cartItemCounter.itemCount, 1);
      cartItemCounter.minusOne();
      expect(cartItemCounter.itemCount, 0);
    });

    test('Add to counter 10 times the clear count', () {
      var cartItemCounter = CartItemCounter();
      expect(cartItemCounter.itemCount, 0); //Check counter is zero to start
      var index = 0;
      while(index < 10) {
        index++;
        cartItemCounter.plusOne();
      }
      expect(cartItemCounter.itemCount, 10);

      cartItemCounter.setToZero();
      expect(cartItemCounter.itemCount, 0);
    });
  });


}