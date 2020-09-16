part of 'catalog_bloc.dart';

@immutable
abstract class CatalogStates extends Equatable {
  const CatalogStates();
}

class CatalogLoading extends CatalogStates {
  @override
  List<Object> get props => [];
}

class CatalogLoaded extends CatalogStates {
  final Catalog catalog;

  const CatalogLoaded(this.catalog);

  @override
  List<Object> get props => [catalog];
}

class CatalogError extends CatalogStates {
  @override
  List<Object> get props => [];
}
