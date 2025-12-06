import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hoora/repository/elements_table_repo.dart';
import 'package:hoora/screens/periodic_screen/model/element_response_model.dart';
import 'package:hoora/services/sqlite_db/sqlite_db.dart';

part 'periodic_table_element_event.dart';
part 'periodic_table_element_state.dart';


  class PeriodicTableElementBloc extends Bloc<PeriodicTableElementEvent, PeriodicTableElementState> {
    final ElementsTableRepo _elementsTableRepo ;

    PeriodicTableElementBloc({required ElementsTableRepo repo})
        : _elementsTableRepo = repo,
          super(PeriodicTableElementInitial()) {
      on<GetPeriodicTableElementsEvent>(_onGetElements);
    }

    Future<void> _onGetElements(
        GetPeriodicTableElementsEvent event,
        Emitter<PeriodicTableElementState> emit) async {

    emit(PeriodicTableElementLoadingState());

    try {
      final elements = await _elementsTableRepo.fetchElementsTable();
      emit(PeriodicTableElementSuccessState("Fetched successfully", elements));
    } catch (e) {
      emit(PeriodicTableElementFailState(e.toString()));
    }
  }
}
