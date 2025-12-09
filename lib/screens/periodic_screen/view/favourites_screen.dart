import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoora/blocs/periodic_table_elements/periodic_table_element_bloc.dart';
import 'package:hoora/blocs/toggle_favourites/toggle_favourites_bloc.dart';
import 'package:hoora/common_widgets/snackbar/snackbar.dart';
import 'package:hoora/screens/periodic_screen/widget/element_card.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeriodicTableElementBloc, PeriodicTableElementState>(
      builder: (context, state) {
        if (state is PeriodicTableElementSuccessState) {
          final favouriteElements = state.elements.values
              .where((element) => element.isFavourite == true)
              .toList();

          if (favouriteElements.isEmpty) {
            return Center(child: Text("No favourites yet ❤️"));
          }
          return ListView.separated(
            itemCount: favouriteElements.length,
            separatorBuilder: (context, index) => SizedBox(height: 12),
            itemBuilder: (context, index) {
              return MultiBlocListener(
                listeners: [
                  BlocListener<ToggleFavouritesBloc, ToggleFavouritesState>(
                    listener: (context, toggleFavouritesState) {
                      if (toggleFavouritesState is ToggleFavouritesSuccessState) {
                        if(toggleFavouritesState.data.atomicNumber == favouriteElements[index].number){
                          if(toggleFavouritesState.data.isFavourite){
                            SnackBarMessage.showSuccessSnackBar(context,"Added", "${favouriteElements[index].name} is added to Favourites");
                          }
                          else{
                            SnackBarMessage.showFailedSnackBar(context,'Removed',"${favouriteElements[index].name} is removed from Favourites");
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
                child: ElementCard(element: favouriteElements[index]),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
