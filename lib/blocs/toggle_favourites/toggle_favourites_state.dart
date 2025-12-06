part of 'toggle_favourites_bloc.dart';

@immutable
sealed class ToggleFavouritesState extends Equatable{
  const ToggleFavouritesState();
}

final class ToggleFavouritesInitial extends ToggleFavouritesState {
  @override
  List<Object?> get props => [];
}
final class ToggleFavouritesLoadingState extends ToggleFavouritesState {
  @override
  List<Object?> get props => [];
}
final class ToggleFavouritesSuccessState extends ToggleFavouritesState {
  final FavouriteElementModel data;
  const ToggleFavouritesSuccessState(this.data);
  @override
  List<Object?> get props => [data];
}
final class ToggleFavouritesFailState extends ToggleFavouritesState {
  final String errorMessage;
  const ToggleFavouritesFailState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
