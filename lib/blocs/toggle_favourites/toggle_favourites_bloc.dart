import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hoora/repository/elements_table_repo.dart';
import 'package:hoora/screens/periodic_screen/model/favourites_element_model.dart';
import 'package:hoora/services/sqlite_db/sqlite_db.dart';
import 'package:meta/meta.dart';

part 'toggle_favourites_event.dart';

part 'toggle_favourites_state.dart';

class ToggleFavouritesBloc
    extends Bloc<ToggleFavouritesEvent, ToggleFavouritesState> {
  final ElementsTableRepo _repo;
  ToggleFavouritesBloc({required ElementsTableRepo repo})
      : _repo = repo,
        super(ToggleFavouritesInitial()) {
    on<TogglingFavouritesEvent>(_onToggleFavoriteElement);
  }

  Future<void> _onToggleFavoriteElement(
    TogglingFavouritesEvent event,
    Emitter<ToggleFavouritesState> emit,
  ) async {
    emit(ToggleFavouritesLoadingState());
    try {
      final bool isToggle = await SqliteDb.instance.toggleFavorite(
        event.data.atomicNumber,
        event.data.isFavourite,
      );
      if (isToggle) {
        emit(ToggleFavouritesSuccessState(event.data));
      } else {
        emit(ToggleFavouritesFailState("Failed to toggle favourite"));
      }
    } catch (e) {
      emit(ToggleFavouritesFailState(e.toString()));
    }
  }
}
