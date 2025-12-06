import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoora/blocs/periodic_table_elements/periodic_table_element_bloc.dart';
import 'package:hoora/constants/app_constants.dart';
import 'package:hoora/screens/periodic_screen/view/all_services_screen.dart';
import 'package:hoora/screens/periodic_screen/view/favourites_screen.dart';

class PeriodicTableScreen extends StatefulWidget {
  const PeriodicTableScreen({super.key});

  @override
  State<PeriodicTableScreen> createState() => _PeriodicTableScreenState();
}

class _PeriodicTableScreenState extends State<PeriodicTableScreen> with SingleTickerProviderStateMixin{
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: AppConstants.tabs.length, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PeriodicTableElementBloc>().add(
        GetPeriodicTableElementsEvent(),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [Tab(text: 'All Services'), Tab(text: 'Favorites')],
        ),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(16.0),
        child: TabBarView(
              controller: _tabController,
              children: [
                AllServicesScreen(),
                FavouritesScreen(),
              ],
            ),
      )


    );
  }
}
