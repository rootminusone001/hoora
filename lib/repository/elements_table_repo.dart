import 'package:hoora/constants/api_constants.dart';
import 'package:hoora/screens/periodic_screen/model/element_response_model.dart';
import 'package:hoora/screens/periodic_screen/model/favourites_element_model.dart';
import 'package:hoora/services/api/api_providers.dart';
import 'package:hoora/services/sqlite_db/sqlite_db.dart';

class ElementsTableRepo {
  ElementsTableRepo._internal();

  static final ElementsTableRepo _instance = ElementsTableRepo._internal();

  factory ElementsTableRepo() {
    return _instance;
  }

  final ApiProvider _apiProvider = ApiProvider();

  List<ElementResponseModel> elementsTableList = [];

  Map<int, ElementResponseModel> elementsTableMap = {};

  List<ElementResponseModel> parseElements(List<dynamic> jsonList) {
    return jsonList.map((json) => ElementResponseModel.fromJson(json)).toList();
  }
  Future<Map<int, ElementResponseModel>> fetchElementsTable() async {
    try {

      final favouriteAtomicNumbers = (await SqliteDb.instance.getAllFavorites()).toSet();


      if (elementsTableMap.isNotEmpty) {
        for (final entry in elementsTableMap.entries) {
          entry.value.isFavourite = favouriteAtomicNumbers.contains(entry.key);
        }
        return elementsTableMap;
      }

      final response = await _apiProvider.getRequest(
        ApiConstants.baseUrl + ApiConstants.elementsTableUrl,
      );

      if (response != null && response.statusCode == 200) {
        elementsTableList = parseElements(response.data);

        elementsTableMap = {
          for (final element in elementsTableList)
            element.number: element..isFavourite =
            favouriteAtomicNumbers.contains(element.number)
        };

        return elementsTableMap;
      } else {
        throw Exception("Server error: ${response?.statusMessage}");
      }
    } catch (e) {
      throw Exception("Failed to fetch elements: $e");
    }
  }

  Future<void> updateElementsFavourites(FavouriteElementModel data) async {
    try {
      if( elementsTableMap[data.atomicNumber] != null){
        elementsTableMap[data.atomicNumber]?.isFavourite = data.isFavourite;
      }
    } catch (e) {
      throw Exception("Failed to update favourites: $e");
    }

  }


}