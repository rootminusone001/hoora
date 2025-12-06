import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hoora/blocs/periodic_table_elements/periodic_table_element_bloc.dart';
import 'package:hoora/blocs/toggle_favourites/toggle_favourites_bloc.dart';
import 'package:hoora/repository/elements_table_repo.dart';
import 'package:hoora/screens/periodic_screen/model/element_response_model.dart';
import 'package:hoora/screens/periodic_screen/view/periodic_table_screen.dart';
import 'package:hoora/services/api/api_providers.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:hoora/services/sqlite_db/sqlite_db.dart';

// MOCK classes
class MockApiProvider extends Mock implements ApiProvider {}
class MockDatabase extends Mock implements SqliteDb {}


class MockElementsTableRepo extends Mock implements ElementsTableRepo {}


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockDatabase mockDb;

  setUp(() {
    mockDb = MockDatabase();

    final mockRepo = MockElementsTableRepo();

    when(() => mockRepo.fetchElementsTable())
        .thenAnswer((_) async => {
      1: ElementResponseModel(number: 1, name: "Hydrogen"),
      2: ElementResponseModel(number: 2, name: "Helium"),
    });



    // Fake initially empty list
    when(() => mockDb.getAllFavorites())
        .thenAnswer((_) async => []);

    // Fake tap toggle
    when(() => mockDb.toggleFavorite(any(), any()))
        .thenAnswer((_) async => true);
  });

  testWidgets("Favorite persists after rebuild", (tester) async {
    final mockRepo = MockElementsTableRepo();

    when(() => mockRepo.fetchElementsTable()).thenAnswer((_) async => {
      1: ElementResponseModel(number: 1, name: "Hydrogen", isFavourite: false),
      2: ElementResponseModel(number: 2, name: "Helium", isFavourite: false),
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

    final hydrogen = ElementResponseModel(number: 1, name: "Hydrogen", isFavourite: true);
    periodicBloc.emit(
        PeriodicTableElementSuccessState("Success",{1: hydrogen, 2: ElementResponseModel(number: 2, name: "Helium", isFavourite: false)})
    );

    await tester.pumpAndSettle();

    final favTab = find.text("Favorites");
    await tester.tap(favTab);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });






}
