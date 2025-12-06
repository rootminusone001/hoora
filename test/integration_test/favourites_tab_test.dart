import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoora/blocs/periodic_table_elements/periodic_table_element_bloc.dart';
import 'package:hoora/blocs/toggle_favourites/toggle_favourites_bloc.dart';
import 'package:hoora/screens/periodic_screen/model/element_response_model.dart';
import 'package:hoora/screens/periodic_screen/view/periodic_table_screen.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hoora/services/sqlite_db/sqlite_db.dart';

import 'favourites_element_test.dart';

class MockDatabase extends Mock implements SqliteDb {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockDatabase mockDb;

  setUp(() {
    mockDb = MockDatabase();

    when(() => mockDb.getAllFavorites())
        .thenAnswer((_) async => [1, 2]);
  });

  testWidgets("Favorites tab shows only favorite elements", (tester) async {

    final mockRepo = MockElementsTableRepo();

    when(() => mockRepo.fetchElementsTable())
        .thenAnswer((_) async => {
      1: ElementResponseModel(number: 1, name: "Hydrogen"),
      2: ElementResponseModel(number: 2, name: "Helium"),
    });


    final periodicBloc = PeriodicTableElementBloc(repo: mockRepo);
    final favBloc = ToggleFavouritesBloc(repo: mockRepo);



    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: periodicBloc),
            BlocProvider.value(value: favBloc),
          ],
          child: const PeriodicTableScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    periodicBloc.emit(
      PeriodicTableElementSuccessState(
        "Loaded",
        {
          1: ElementResponseModel(number: 1, name: "Hydrogen", isFavourite: true),
          2: ElementResponseModel(number: 2, name: "Helium", isFavourite: true),
          3: ElementResponseModel(number: 3, name: "Lithium", isFavourite: false),
        },
      ),
    );

    final favTab = find.byWidgetPredicate(
          (widget) => widget is Tab && widget.text == "Favorites",
    );
    await tester.tap(favTab);
    await tester.pumpAndSettle();

    final cards = find.byType(Card);
    expect(cards, findsNWidgets(2));
  });


}
