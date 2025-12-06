part of 'periodic_table_element_bloc.dart';

sealed class PeriodicTableElementState extends Equatable {
  const PeriodicTableElementState();
}

final class PeriodicTableElementInitial extends PeriodicTableElementState {
  @override
  List<Object> get props => [];
}

final class PeriodicTableElementLoadingState extends PeriodicTableElementState {
  @override
  List<Object> get props => [];
}

final class PeriodicTableElementSuccessState extends PeriodicTableElementState {
  final String message;
  final Map<int, ElementResponseModel> elements;
  const PeriodicTableElementSuccessState(this.message,this.elements);
  @override
  List<Object> get props => [message,elements];
}
final class PeriodicTableElementFailState extends PeriodicTableElementState {
  final String errorMessage;
  const PeriodicTableElementFailState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}