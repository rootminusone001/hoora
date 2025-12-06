import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoora/blocs/toggle_favourites/toggle_favourites_bloc.dart';
import 'package:hoora/screens/periodic_screen/model/element_response_model.dart';
import 'package:hoora/screens/periodic_screen/widget/element_card.dart';
import 'package:mocktail/mocktail.dart';

class MockToggleFavBloc extends MockBloc<ToggleFavouritesEvent, ToggleFavouritesState>
    implements ToggleFavouritesBloc {}
class FakeToggleFavouriteEvent extends Fake implements TogglingFavouritesEvent {}

void main() {
  late ToggleFavouritesBloc mockBloc;
  setUpAll(() {
    registerFallbackValue(FakeToggleFavouriteEvent());
  });

  setUp(() {
    mockBloc = MockToggleFavBloc();
  });

  testWidgets('shows element name and number', (tester) async {
    final element = ElementResponseModel(number: 1, name: "Hydrogen");

    await tester.pumpWidget(MaterialApp(
      home: ElementCard(element: element),
    ));

    expect(find.text('1'), findsOneWidget);
    expect(find.text('Hydrogen'), findsOneWidget);
  });

  testWidgets('UI shows correct favourite state & dispatches toggle event', (tester) async {
    // Arrange: Create element data
    final element = ElementResponseModel(
      number: 1,
      name: "Hydrogen",
      isFavourite: false,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<ToggleFavouritesBloc>(
          create: (context) => mockBloc,
          child: ElementCard(element: element),
        ),
      ),
    );

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();
    verify(() => mockBloc.add(any(that: isA<TogglingFavouritesEvent>()))).called(1);
  });

  testWidgets('shows filled heart when isFavourite true', (tester) async {
    final element = ElementResponseModel(
      number: 1,
      name: "Hydrogen",
      isFavourite: true,
    );

    await tester.pumpWidget(MaterialApp(
      home: ElementCard(element: element),
    ));

    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });
}
