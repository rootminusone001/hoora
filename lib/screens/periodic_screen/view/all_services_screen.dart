import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoora/blocs/periodic_table_elements/periodic_table_element_bloc.dart';
import 'package:hoora/blocs/toggle_favourites/toggle_favourites_bloc.dart';
import 'package:hoora/common_widgets/snackbar/snackbar.dart';
import 'package:hoora/screens/periodic_screen/widget/element_card.dart';

class AllServicesScreen extends StatelessWidget {
  const AllServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PeriodicTableElementBloc, PeriodicTableElementState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        if (state is PeriodicTableElementSuccessState) {
          if (state.elements.isEmpty) {
            return Center(child: Text("No Elements"));
          }
          return ListView.separated(
            itemCount: state.elements.length,
            separatorBuilder: (context, index) => SizedBox(height: 12),
            itemBuilder: (context, index) {
              final elementsList = state.elements.values.toList();
              return MultiBlocListener(
                listeners: [
                  BlocListener<ToggleFavouritesBloc, ToggleFavouritesState>(
                    listener: (context, toggleFavouritesState) {
                      if (toggleFavouritesState is ToggleFavouritesSuccessState) {

                        if(toggleFavouritesState.data.atomicNumber == state.elements[index]?.number){
                          if(toggleFavouritesState.data.isFavourite){
                            SnackBarMessage.showSuccessSnackBar(context, "Added", "${state.elements[index]?.name} is added to Favourites");
                          }
                          else{
                            SnackBarMessage.showFailedSnackBar(context, "Removed", "${state.elements[index]?.name} is removed from Favourites");
                          }
                          context.read<PeriodicTableElementBloc>().add(
                            GetPeriodicTableElementsEvent(),
                          );
                        }
                      }
                      if (toggleFavouritesState is ToggleFavouritesFailState) {
                        SnackBarMessage.showFailedSnackBar(context,"Failed",  toggleFavouritesState.errorMessage);
                      }
                    },
                  ),
                ],
                child: ElementCard(element: elementsList[index]),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
