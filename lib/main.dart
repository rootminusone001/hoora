import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoora/blocs/periodic_table_elements/periodic_table_element_bloc.dart';
import 'package:hoora/blocs/toggle_favourites/toggle_favourites_bloc.dart';
import 'package:hoora/repository/elements_table_repo.dart';
import 'package:hoora/screens/periodic_screen/view/periodic_table_screen.dart';
import 'package:hoora/services/sqlite_db/sqlite_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqliteDb.instance.database;
  runApp(
      RepositoryProvider(
          create: (_) => ElementsTableRepo(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PeriodicTableElementBloc(
          repo: RepositoryProvider.of<ElementsTableRepo>(context),
        )),
        BlocProvider(create: (context) => ToggleFavouritesBloc(
            repo: RepositoryProvider.of<ElementsTableRepo>(context)
        )),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        home:PeriodicTableScreen(),
      ),
    );
  }
}
