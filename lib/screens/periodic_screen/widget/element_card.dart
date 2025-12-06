import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoora/blocs/toggle_favourites/toggle_favourites_bloc.dart';
import 'package:hoora/screens/periodic_screen/model/element_response_model.dart';
import 'package:hoora/screens/periodic_screen/model/favourites_element_model.dart';

class ElementCard extends StatelessWidget {
  final ElementResponseModel element;
  const ElementCard({super.key,required this.element});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(element.number.toString()),
                  Text(element.name??''),
                ],
              ),
              IconButton(
                  onPressed: (){
                    final FavouriteElementModel data = FavouriteElementModel(atomicNumber: element.number , isFavourite: !element.isFavourite );
                    context.read<ToggleFavouritesBloc>().add(TogglingFavouritesEvent(data));
                  }, icon: Icon(
                  element.isFavourite ? Icons.favorite:  Icons.favorite_border,
              color:element.isFavourite ? Colors.red: Colors.grey ,
              ))
              ,
            ],
          ),
        ));
  }
}
