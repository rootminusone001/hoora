import 'package:hoora/constants/db_constants.dart';

class FavouriteElementModel {
  final int atomicNumber;
  final bool isFavourite;

  FavouriteElementModel({
    required this.atomicNumber,
    required this.isFavourite,
  });

  factory FavouriteElementModel.fromJson(Map<String, dynamic> json) {
    return FavouriteElementModel(
      atomicNumber: json[DbConstants.atomicNumber],
      isFavourite: json[DbConstants.isFavorite],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      DbConstants.atomicNumber: atomicNumber,
      DbConstants.isFavorite: isFavourite,
    };
  }
}
