import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/utils/enums.dart';
import '../../data/models/travel_model.dart';
import '../../injection.dart';
import '../widgets/item_table.dart';

class MarkerInfoView extends StatefulWidget {
  final Object item;

  const MarkerInfoView({super.key, required this.item});

  @override
  State<MarkerInfoView> createState() => _MarkerInfoViewState();
}

class _MarkerInfoViewState extends State<MarkerInfoView> {

  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {

    MovieLocationModel movieItem;
    AttractionModel attractionItem;
    AccommodationModel accommodationItem;
    RestaurantModel restaurantItem;

    //initialize
    TravelModel travelModel = TravelModel(id: 0, title: "-", images: [], type: TravelType.MOVIE_LOCATION, location: LatLng(0,0), address: "-", tel: "-", openTime: "", overview: "", homepage: "");
    String infoTitle = '정보';

    switch (widget.item.runtimeType) {
      case MovieLocationModel:
        movieItem = widget.item as MovieLocationModel;
        travelModel = TravelModel(id: movieItem.id, title: movieItem.title, images: movieItem.images, type: TravelType.MOVIE_LOCATION, location: movieItem.location, address: movieItem.address, tel: movieItem.tel);
        infoTitle = '영화정보';
        break;
      case AttractionModel:
        attractionItem = widget.item as AttractionModel;
        travelModel = TravelModel(id: attractionItem.id, title: attractionItem.title, images: attractionItem.images, type: TravelType.ATTRACTION, location: attractionItem.location, address: attractionItem.address, tel: attractionItem.tel, overview: attractionItem.overview, homepage: attractionItem.homepage, openTime: attractionItem.restDate);
        infoTitle = '관광정보';
        break;
      case AccommodationModel:
        accommodationItem = widget.item as AccommodationModel;
        travelModel = TravelModel(id: accommodationItem.id, title: accommodationItem.title, images: accommodationItem.images, type: TravelType.ACCOMMODATION, location: accommodationItem.location, address: accommodationItem.address, tel: accommodationItem.tel, overview: accommodationItem.overview, homepage: accommodationItem.homepage);
        infoTitle = '숙박정보';
        break;
      case RestaurantModel:
        restaurantItem = widget.item as RestaurantModel;
        travelModel = TravelModel(id: restaurantItem.id, title: restaurantItem.title, images: restaurantItem.images, type: TravelType.RESTAURANT, location: restaurantItem.location, address: restaurantItem.address, tel: restaurantItem.tel, menus: restaurantItem.menus, openTime: restaurantItem.openTime, overview: restaurantItem.overview, homepage: restaurantItem.homepage);
        infoTitle = '식당정보';
        break;
    }

    _markers.add(Marker(
      markerId: MarkerId(travelModel.id.toString()),
      position: travelModel.location,
      onTap: () {
        // openBottomSheet(context, widget.item!);
      },
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text(travelModel.title),
        centerTitle: false,
      ),
      body: Column(
          children:[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200.h,
              child : GoogleMap(
                markers: _markers,
                initialCameraPosition: CameraPosition(target: travelModel.location, zoom: 18),
                myLocationButtonEnabled: false,
                myLocationEnabled: false,
                onMapCreated: _onMapCreated,
                zoomControlsEnabled: false,
                cameraTargetBounds: CameraTargetBounds(
                  DI(instanceName: CORE_LATLNG_BOUNDS),
                ),
                minMaxZoomPreference: const MinMaxZoomPreference(11, null),
              ),
            ),
            Expanded(
              child: ItemTable(
                header: ItemHeader(
                  header: Text(
                    travelModel.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    )
                  ],
                ),
                sections: [
                  ItemSection(
                    padding: EdgeInsets.zero,
                    builder: ItemSectionBuilder()
                      ..address = ItemTableRow(
                        title: '주소',
                        body: travelModel.address,
                      )
                      ..phone = travelModel.tel == null || travelModel.tel == "" ? null : ItemTableRow(
                        title: '전화번호',
                        body: travelModel.tel!,
                        bodyTextStyle: Theme.of(context).textTheme.bodySmall,
                      )
                      ..hours = travelModel.openTime == null || travelModel.openTime == "" ? null : ItemTableRow(
                        title: '영업시간',
                        body: travelModel.openTime!,
                      )
                      ..info = travelModel.overview == null || travelModel.overview == "" ? null : ItemTableRow(
                        title: infoTitle,
                        body: travelModel.overview!,
                      )
                      ..homePage = travelModel.homepage == null || travelModel.homepage == "" ? null : ItemTableRow(
                        title: '홈페이지',
                        body: travelModel.homepage!,
                        bodyTextStyle: Theme.of(context).textTheme.bodySmall,
                      ),
                  ),
                  ItemSection(
                    builder: ItemSectionBuilder()..image = ItemTableGrid(items: travelModel.images!,),
                  ),
                ],
              ),
            ),
          ]
      )
    );
  }
}
