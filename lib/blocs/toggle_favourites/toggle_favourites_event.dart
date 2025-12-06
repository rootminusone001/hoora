part of 'toggle_favourites_bloc.dart';

@immutable
sealed class ToggleFavouritesEvent {
  const ToggleFavouritesEvent();
}
class TogglingFavouritesEvent  extends ToggleFavouritesEvent{
  final FavouriteElementModel data;
 const  TogglingFavouritesEvent(this.data);
}
