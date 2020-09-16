part of 'catalog_bloc.dart';

@immutable
abstract class CatalogEvents extends Equatable {
  const CatalogEvents();
}

class CatalogStarted extends CatalogEvents {
  @override
  List<Object> get props => [];
}
