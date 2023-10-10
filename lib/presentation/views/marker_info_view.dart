import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/utils/enums.dart';
import '../../domain/entities/travel.dart';
import '../../injection.dart';
import '../bloc/search/travel/travel_bloc.dart';
import '../bloc/search/travel/travel_event.dart';
import '../bloc/search/travel/travel_state.dart';
import '../widgets/item_table.dart';

class MarkerInfoView extends StatefulWidget {
  final int id;
  final TravelType type;
  final String title;

  const MarkerInfoView({
    super.key,
    required this.id,
    required this.type,
    required this.title,
  });

  @override
  State<MarkerInfoView> createState() => _MarkerInfoViewState();
}

class _MarkerInfoViewState extends State<MarkerInfoView> {
  bool isDataLoaded = false;
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  Travel item = const Travel(
    id: 0,
    title: "-",
    images: [],
    type: TravelType.MOVIE_LOCATION,
    location: LatLng(0, 0),
    address: "-",
    tel: "-",
    openTime: "",
    overview: "",
    homepage: "",
  );

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    switch (widget.type) {
      case TravelType.ACCOMMODATION:
        context.read<TravelBloc>().add(GetAccommoInfoEvent(id: widget.id));
        break;
      case TravelType.ATTRACTION:
        context.read<TravelBloc>().add(GetAttractionInfoEvent(id: widget.id));
        break;
      case TravelType.MOVIE_LOCATION:
        context
            .read<TravelBloc>()
            .add(GetMovieLocationInfoEvent(id: widget.id));
        break;
      case TravelType.RESTAURANT:
        context.read<TravelBloc>().add(GetRestaurantInfoEvent(id: widget.id));
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String infoTitle = '정보';

    return BlocConsumer<TravelBloc, TravelState>(
      listener: (context, state) {
        if (state is AttractionDataLoaded) {
          infoTitle = '관광정보';
          item = state.attraction;
        } else if (state is AccommoDataLoaded) {
          infoTitle = '숙박정보';
          item = state.accommodation;
        } else if (state is MovieLocationDataLoaded) {
          infoTitle = '영화정보';
          item = state.movieLocation;
        } else if (state is RestaurantDataLoaded) {
          infoTitle = '식당정보';
          item = state.restaurant;
        }
        _markers.add(Marker(
          markerId: MarkerId(item.id.toString()),
          position: item.location,
        ));
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            centerTitle: false,
          ),
          body: state is TravelDataLoading && !isDataLoaded
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 200.h,
                      child: GoogleMap(
                        markers: _markers,
                        initialCameraPosition:
                            CameraPosition(target: item.location, zoom: 18),
                        myLocationButtonEnabled: false,
                        myLocationEnabled: false,
                        onMapCreated: _onMapCreated,
                        zoomControlsEnabled: false,
                        cameraTargetBounds: CameraTargetBounds(
                          DI(instanceName: CORE_LATLNG_BOUNDS),
                        ),
                        minMaxZoomPreference:
                            const MinMaxZoomPreference(11, null),
                      ),
                    ),
                    Expanded(
                      child: ItemTable(
                        header: ItemHeader(
                          header: Text(
                            item.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        sections: [
                          ItemSection(
                            padding: EdgeInsets.zero,
                            builder: ItemSectionBuilder()
                              ..address = ItemTableRow(
                                title: '주소',
                                body: item.address,
                              )
                              ..phone = item.tel == null || item.tel == ""
                                  ? null
                                  : ItemTableRow(
                                      title: '전화번호',
                                      body: item.tel!,
                                      bodyTextStyle:
                                          Theme.of(context).textTheme.bodySmall,
                                    )
                              ..hours =
                                  item.openTime == null || item.openTime == ""
                                      ? null
                                      : ItemTableRow(
                                          title: '영업시간',
                                          body: item.openTime!,
                                        )
                              ..info =
                                  item.overview == null || item.overview == ""
                                      ? null
                                      : ItemTableRow(
                                          title: infoTitle,
                                          body: item.overview!,
                                        )
                              ..homePage =
                                  item.homepage == null || item.homepage == ""
                                      ? null
                                      : ItemTableRow(
                                          title: '홈페이지',
                                          body: item.homepage!,
                                          bodyTextStyle: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                          ),
                          ItemSection(
                            builder: ItemSectionBuilder()
                              ..image = ItemTableGrid(
                                items: item.images ?? [],
                              ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
