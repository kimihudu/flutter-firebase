part of 'cart_bloc.dart';

@immutable
abstract class CartStates extends Equatable {
  const CartStates();
}

class CartLoading extends CartStates {
  @override
  List<Object> get props => [];
}

class CartLoaded extends CartStates {
  final List<Product> items;
  final int session;

  const CartLoaded({this.items, this.session});

  int get totalPrice =>
      items.fold(0, (total, current) => total + int.parse(current.price));

  int get totalItems => items.length;

  @override
  List<Object> get props => [items, session];
}

class CartPlacedOrder extends CartStates {
  Order order;
  String id;

  CartPlacedOrder({
    this.order,
    this.id,
  });

  @override
  // TODO: implement props
  List<Object> get props => [order, id];
}

class CartPlacedOrderFail extends CartStates {
  Order order;

  CartPlacedOrderFail({this.order});

  @override
  // TODO: implement props
  List<Object> get props => [order];
}

class CartError extends CartStates {
  @override
  List<Object> get props => [];
}
