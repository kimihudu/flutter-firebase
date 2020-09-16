import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:grocery_app/models/models.dart';
import 'package:grocery_app/repo/repos.dart';

part 'catalog_events.dart';
part 'catalog_states.dart';

class CatalogBloc extends Bloc<CatalogEvents, CatalogStates> {
  CatalogBloc() : super(CatalogLoading());

  // SimpleBlocDelegate delegate = SimpleBlocDelegate();

  @override
  // CatalogStates get initialState => CatalogLoading();

  @override
  Stream<CatalogStates> mapEventToState(
    CatalogEvents event,
  ) async* {
    if (event is CatalogStarted) {
      yield* _mapCatalogStartedToState();
    }
  }

  Stream<CatalogStates> _mapCatalogStartedToState() async* {
    yield CatalogLoading();
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      var listProds = await CatalogRepo().reqProds();

      yield CatalogLoaded(Catalog(products: listProds));
    } catch (_) {
      // delegate.onError(this, _, StackTrace.current);
      yield CatalogError();
    }
  }
}
