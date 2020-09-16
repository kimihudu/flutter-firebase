import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grocery_app/blocs/blocs.dart';
import 'package:grocery_app/blocs/simple_bloc_delegate.dart';
import 'package:grocery_app/helper/ultis.dart';
import 'package:grocery_app/models/models.dart';
import 'package:grocery_app/repo/repos.dart';
import 'package:meta/meta.dart';

part 'cart_events.dart';
part 'cart_states.dart';

class CartBloc extends Bloc<CartEvents, CartStates> {
  CartBloc() : super(CartLoading());

  // SimpleBlocDelegate delegate = SimpleBlocDelegate();

  // @override
  // CartStates get initialState => CartLoading();

  @override
  Stream<CartStates> mapEventToState(
    CartEvents event,
  ) async* {
    if (event is CartStarted) {
      yield* _mapCartStartedToState();
    } else if (event is CartItemAdded) {
      yield* _mapCartItemAddedToState(event);
    } else if (event is CartItemEdited) {
      yield* _mapCartItemEditedToState(event);
    } else if (event is PlaceOrder) {
      yield* _mapCartPlacedOrderToState(event);
    }
  }

  Stream<CartStates> _mapCartStartedToState() async* {
    yield CartLoading();
    try {
      await Future.delayed(Duration(seconds: 1));
      yield CartLoaded(items: []);
    } catch (_) {
      // delegate.onError(this, _, StackTrace.current);
      yield CartError();
    }
  }

  Stream<CartStates> _mapCartItemAddedToState(CartItemAdded event) async* {
    final currentState = state;
    if (currentState is CartLoaded) {
      try {
        List<Product> _added = currentState.items;
        for (var i = 0; i < event.quantity; i++) {
          _added..add(event.item);
        }
        yield CartLoaded(
          items: _added,
          session: Helper.getCurrentSes(), //<-- keep stream update
        );
      } catch (_) {
        // delegate.onError(this, _, StackTrace.current);
        yield CartError();
      }
    }
  }

  Stream<CartStates> _mapCartItemEditedToState(CartItemEdited event) async* {
    final currentState = state;
    if (currentState is CartLoaded) {
      try {
        //remove prod by sku with old quantity
        //add the same prod with new quantity
        List<Product> _edited = currentState.items;
        _edited.removeWhere((prod) => prod.sku == event.item.sku);
        for (var i = 0; i < event.quantity; i++) {
          _edited..add(event.item);
        }

        yield CartLoaded(
          items: _edited,
          session: Helper.getCurrentSes(), //<-- keep stream update
        );
      } catch (_) {
        // delegate.onError(this, _, StackTrace.current);
        yield CartError();
      }
    }
  }

  Stream<CartStates> _mapCartPlacedOrderToState(PlaceOrder event) async* {
    final currentState = state;
    if (currentState is CartLoaded) {
      final ordered = await CatalogRepo().addOrder(event.order);
      if (ordered != null) {
        yield CartPlacedOrder(order: event.order, id: ordered);
      } else {
        yield CartPlacedOrderFail(order: event.order);
      }
    } else {
      Helper.debugLog(
          'cart_bloc > _mapCartPlacedOrderToState > fail > currentState',
          currentState);
    }
    try {} catch (_) {
      // delegate.onError(this, _, StackTrace.current);
      yield CartError();
    }
  }
}
