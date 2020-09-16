part of 'cart_bloc.dart';

@immutable
abstract class CartEvents extends Equatable {
  const CartEvents();
}

class CartStarted extends CartEvents {
  @override
  List<Object> get props => [];
}

class CartItemAdded extends CartEvents {
  final Product item;
  final int quantity;

  const CartItemAdded({this.item, this.quantity});

  @override
  List<Object> get props => [item, quantity];
}

class CartItemEdited extends CartEvents {
  final Product item;
  final int quantity;

  const CartItemEdited({this.item, this.quantity});

  @override
  List<Object> get props => [item, quantity];
}

class PlaceOrder extends CartEvents {
  final Order order;

  PlaceOrder({this.order});

  @override
  List<Object> get props => [order];
}
