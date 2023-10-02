import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/domain/entities/map_item.dart';
import 'package:slate/presentation/views/searched_item_view.dart';

import '../../core/utils/enums.dart';
import '../../data/models/travel_model.dart';

class ItemInfoView extends StatefulWidget {
  final Object item;

  const ItemInfoView({super.key, required this.item});

  @override
  State<ItemInfoView> createState() => _ItemInfoViewState();
}

class _ItemInfoViewState extends State<ItemInfoView> {
  @override
  Widget build(BuildContext context) {

    String title = "-";
    TravelType type = TravelType.MOVIE_LOCATION;
    String subTitle = "-";
    List<String>? tag = [] ;
    String? phone = "-";
    String? image = "";
    LatLng? location = LatLng(35.171585, 129.127796);
    MapItem? mapItem;
    MovieLocationModel? movieItem;

    switch(widget.item.runtimeType){
      case MovieLocationModel:
        movieItem = widget.item as MovieLocationModel;
        title = movieItem.title;
        type = TravelType.MOVIE_LOCATION;
        image = movieItem.imageUrl;
        location = movieItem.location;
        mapItem = MapItem(markerId: MarkerId(movieItem.id.toString()), type: type, title: title, position: location);
        break;
      case AttractionModel:
        AttractionModel attractionItem = widget.item as AttractionModel;
        title = attractionItem.title;
        type = TravelType.ATTRACTION;
        image = attractionItem.images?[0];
        location = attractionItem.location;
        mapItem = MapItem(markerId: MarkerId(attractionItem.id.toString()), type: type, title: title, position: location);
        break;
      case AccommodationModel:
        AccommodationModel accommodationItem = widget.item as AccommodationModel;
        title = accommodationItem.title;
        type = TravelType.ACCOMMODATION;
        phone = accommodationItem.tel;
        image = accommodationItem.images?[0];
        location = accommodationItem.location;
        mapItem = MapItem(markerId: MarkerId(accommodationItem.id.toString()), type: type, title: title, position: location);
        break;
      case RestaurantModel:
        RestaurantModel restaurantItem = widget.item as RestaurantModel;
        title = restaurantItem.title;
        type = TravelType.RESTAURANT;
        tag = restaurantItem.menus;
        phone = restaurantItem.tel;
        image = restaurantItem.images?[0];
        location = restaurantItem.location;
        mapItem = MapItem(markerId: MarkerId(restaurantItem.id.toString()), type: type, title: title, position: location);
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: false,
      ),
      body: ItemMapView(
        initBottomSheet: true,
        item: mapItem,
        movieLocationModel: (mapItem?.type == TravelType.MOVIE_LOCATION) ? movieItem : null,
      ),
    );
  }
}
