import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/utils/enums.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/domain/entities/map_item.dart';
import 'package:slate/injection.dart';
import 'package:slate/presentation/bloc/map/map_bloc.dart';
import 'package:slate/presentation/bloc/map/map_event.dart';
import 'package:slate/presentation/bloc/map/map_state.dart';
import 'package:slate/presentation/bloc/search/search_bloc.dart';
import 'package:slate/presentation/bloc/search/search_event.dart';
import 'package:slate/presentation/bloc/search/search_state.dart';
import 'package:slate/presentation/views/item_info_view.dart';
import 'package:slate/presentation/views/movie_info_view.dart';
import 'package:slate/presentation/widgets/item_table.dart';

import 'package:slate/presentation/widgets/searched_item.dart';

import '../../core/utils/assets.dart';
import '../../data/models/travel_model.dart';

abstract class SearchedItemView extends StatefulWidget {
  const SearchedItemView({super.key});
}

class ItemMapView extends SearchedItemView {
  final bool initBottomSheet;
  final double? bottomSheetHeight;
  final MapItem? item;
  final MovieLocationModel? movieLocationModel;

  const ItemMapView({
    super.key,
    this.initBottomSheet = false,
    this.bottomSheetHeight,
    this.item,
    this.movieLocationModel,
  });

  @override
  State<ItemMapView> createState() => _ItemMapViewState();
}

class _ItemMapViewState extends State<ItemMapView> {
  TravelType onTapedTag = TravelType.MOVIE_LOCATION;

  @override
  void initState() {
    if (widget.initBottomSheet && widget.item != null) {
      context
          .read<MapBloc>()
          .add(InitializeMapEvent(latLng: widget.item!.position));
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        openBottomSheet(context, widget.item!);
      });
    } else {
      context.read<MapBloc>().add(InitializeMapEvent());
    }
    super.initState();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition _position = const CameraPosition(
    target: LatLng(35.171585, 129.127796),
    zoom: 15,
  );
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocListener<SearchBloc, SearchState>(
            child: SizedBox.shrink(),
              listener: (context, state) {
            if (state is MovieLocationDataLoaded ||
                state is RestaurantDataLoaded ||
                state is AccommoDataLoaded ||
                state is AttractionDataLoaded) {
              state.props.forEach((item) async {
                // print("맵아이템" + item.runtimeType.toString());
                widget.initBottomSheet
                    ? openBottomSheet(context, item!)
                    : openModalDailog(context, item!);
              });
            }
          }
          ),
          BlocConsumer<MapBloc, MapState>(
            listener: (context, state) async {
              if (state is MapInitialized) {
                setState(() {
                  _position = state.cameraPosition;
                  if (widget.item != null) {
                    _markers.add(Marker(
                      markerId: widget.item!.markerId,
                      position: widget.item!.position,
                      onTap: () {
                        // openBottomSheet(context, widget.item!);
                      },
                    ));
                  } else {
                    context
                        .read<MapBloc>()
                        .add(GetMarkersEvent(type: TravelType.MOVIE_LOCATION));
                  }
                });
              } else if (state is CameraMoved) {
                GoogleMapController controller = await _controller.future;
                await controller.animateCamera(
                  CameraUpdate.newCameraPosition(state.cameraPosition),
                );
              } else if (state is MarkerLoaded) {
                _markers.clear();

                setState(() {
                  state.markers.forEach(
                    (item) async {
                      _markers.add(
                        Marker(
                          markerId: item.markerId,
                          position: item.position,
                          onTap: () {
                            // print("맵아이템1" + item.markerId.value.toString());
                            switch (item.type) {
                              case TravelType.RESTAURANT:
                                context.read<SearchBloc>().add(
                                    RestaurantInfoSearchEvent(
                                        id: int.parse(
                                            item.markerId.value.toString())));
                                break;
                              case TravelType.ACCOMMODATION:
                                context.read<SearchBloc>().add(
                                    AccommoInfoSearchEvent(
                                        id: int.parse(
                                            item.markerId.value.toString())));
                                break;
                              case TravelType.ATTRACTION:
                                context.read<SearchBloc>().add(
                                    AttractionInfoSearchEvent(
                                        id: int.parse(
                                            item.markerId.value.toString())));
                                break;
                              case TravelType.MOVIE_LOCATION:
                                context.read<SearchBloc>().add(
                                    MovieLocationInfoSearchEvent(
                                        id: int.parse(
                                            item.markerId.value.toString())));
                                break;
                            }
                          },
                        ),
                      );
                      // print("맵2" + state.markers[0].position.toString());
                      GoogleMapController controller = await _controller.future;
                      await controller.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target: state.markers[0].position, zoom: 15)),
                      );
                    },
                  );
                });
              }
            },
            builder: (context, state) {
              if (state is MapLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is MapError) {
                return Center(
                  child: Text('ERROR'),
                );
              } else {
                return GoogleMap(
                  initialCameraPosition: _position,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  onMapCreated: (controller) async {
                    _controller.complete(controller);
                  },
                  markers: _markers,
                  cameraTargetBounds: CameraTargetBounds(
                    DI(instanceName: CORE_LATLNG_BOUNDS),
                  ),
                  minMaxZoomPreference: const MinMaxZoomPreference(11, null),
                );
              }
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeOf.w_md,
                vertical: SizeOf.h_md,
              ),
              child: FloatingActionButton.small(
                heroTag: null,
                onPressed: () async {
                  context.read<MapBloc>().add(Move2UserLocationEvent());
                },
                child: Icon(
                  Icons.my_location,
                  color: ColorOf.point.light,
                ),
                backgroundColor: Colors.white,
              ),
            ),
          ),
          Visibility(
            visible: widget.item == null,
            child: Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    (
                      '영화 촬영지',
                      AssetImage(Images.FILM_ICON.path),
                      TravelType.MOVIE_LOCATION,
                    ),
                    (
                      '식당',
                      AssetImage(Images.FOOD_ICON.path),
                      TravelType.RESTAURANT,
                    ),
                    (
                      '관광지',
                      AssetImage(Images.SITE_ICON.path),
                      TravelType.ATTRACTION,
                    ),
                    (
                      '숙박',
                      AssetImage(Images.ACCOM_ICON.path),
                      TravelType.ACCOMMODATION,
                    ),
                  ]
                      .map(
                        (element) => Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeOf.w_sm / 2,
                            vertical: SizeOf.h_sm,
                          ),
                          child: ActionChip(
                            avatar: Image(
                              image: element.$2,
                              width: 13.h,
                            ),
                            label: Text(element.$1),
                            side: onTapedTag == element.$3
                                ? BorderSide(
                                    color: ColorOf.point.light,
                                  )
                                : null,
                            backgroundColor: ColorOf.white.light,
                            labelStyle: Theme.of(context).textTheme.bodyLarge,
                            shape: const StadiumBorder(),
                            elevation: 0.6,
                            onPressed: () {
                              setState(() {
                                onTapedTag = element.$3;
                              });
                              context.read<MapBloc>().add(
                                    GetMarkersEvent(type: element.$3),
                                  );
                            },
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future openModalDailog(BuildContext context, Object item) async {
    // print("맵모달" + item.toString());
    String title = "제목";
    TravelType type = TravelType.MOVIE_LOCATION;
    String address = "주소";
    List<String>? tag = [] ;
    String? phone = "010-0000-0000";
    String? image = "";

    MovieLocationModel? movieItem;

    switch(item.runtimeType){
      case MovieLocationModel:
        movieItem = item as MovieLocationModel;
        title = movieItem.title;
        type = TravelType.MOVIE_LOCATION;
        image = movieItem.imageUrl;
        address = movieItem.address;
        break;
      case AttractionModel:
        AttractionModel attractionItem = item as AttractionModel;
        title = attractionItem.title;
        type = TravelType.ATTRACTION;
        image = attractionItem.images?[0];
        address = attractionItem.address;
        break;
      case AccommodationModel:
        AccommodationModel accommodationItem = item as AccommodationModel;
        title = accommodationItem.title;
        type = TravelType.ACCOMMODATION;
        phone = accommodationItem.tel;
        image = accommodationItem.images?[0];
        address = accommodationItem.address;
        break;
      case RestaurantModel:
        RestaurantModel restaurantItem = item as RestaurantModel;
        title = restaurantItem.title;
        type = TravelType.RESTAURANT;
        tag = restaurantItem.menus;
        phone = restaurantItem.tel;
        image = restaurantItem.images?[0];
        address = restaurantItem.address;
        break;
    }
    
    showBottomSheet(
      context: context,
      builder: (context) => Container(
        color: ColorOf.white.light,
        height: 200.h,
        child: SearchedItem(
          title: title,
          type: type,
          subTitle: address,
          tag: (type == TravelType.RESTAURANT) ? tag! : [],
          phone: (type == TravelType.MOVIE_LOCATION || type == TravelType.ATTRACTION) ? null  : phone,
          image: image,
          function: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => type == TravelType.MOVIE_LOCATION
                    ? MovieInfoView(item: movieItem,)
                    : ItemInfoView(item: item),
              ),
            );
          },
        ),
      ),
    );
  }

  Future openBottomSheet(BuildContext context, Object item) async {
    String title = "-";
    TravelType type = TravelType.MOVIE_LOCATION;
    String addressText = "주소";
    List<String>? tag = [] ;
    String? phoneNum = "010-0000-0000";
    String? image = "";

    MovieLocationModel movieItem;
    AttractionModel attractionItem;
    AccommodationModel accommodationItem;
    RestaurantModel restaurantItem;

    switch(item.runtimeType){
      case MapItem:
        MapItem mapItem = item as MapItem;
        switch (mapItem.type) {
          case TravelType.RESTAURANT:
            context.read<SearchBloc>().add(
                RestaurantInfoSearchEvent(
                    id: int.parse(mapItem.markerId.value)));
            break;
          case TravelType.ACCOMMODATION:
            context.read<SearchBloc>().add(
                AccommoInfoSearchEvent(
                    id: int.parse(
                        mapItem.markerId.value.toString())));
            break;
          case TravelType.ATTRACTION:
            context.read<SearchBloc>().add(
                AttractionInfoSearchEvent(
                    id: int.parse(
                        mapItem.markerId.value.toString())));
            break;
          case TravelType.MOVIE_LOCATION:
            context.read<SearchBloc>().add(
                MovieLocationInfoSearchEvent(
                    id: int.parse(
                        mapItem.markerId.value.toString())));
            break;
        }
        print("헤이이ㅣ" + mapItem.toString());

      case MovieLocationModel:
        print("헤이3" + item.toString());
        movieItem = item as MovieLocationModel;
        title = movieItem.title;
        type = TravelType.MOVIE_LOCATION;
        image = movieItem.imageUrl;
        addressText = movieItem.address;
        break;
      case AttractionModel:
        print("헤이4" + item.toString());
        attractionItem = item as AttractionModel;
        title = attractionItem.title;
        type = TravelType.ATTRACTION;
        image = attractionItem.images?[0];
        addressText = attractionItem.address;
        phoneNum = attractionItem.tel;
        break;
      case AccommodationModel:
        print("헤이5" + item.toString());
        accommodationItem = item as AccommodationModel;
        title = accommodationItem.title;
        type = TravelType.ACCOMMODATION;
        phoneNum = accommodationItem.tel;
        image = accommodationItem.images?[0];
        addressText = accommodationItem.address;
        break;
      case RestaurantModel:
        print("헤이식당" + item.toString());
        restaurantItem = item as RestaurantModel;
        setState(() {
          title = restaurantItem.title;
        });
        // title = restaurantItem.title;
        type = TravelType.RESTAURANT;
        tag = restaurantItem.menus;
        phoneNum = restaurantItem.tel;
        image = restaurantItem.images?[0];
        addressText = restaurantItem.address;

        break;
    }

    showBottomSheet(
      elevation: 1,
      context: context,
      builder: (context) {

        print("헤이2" + title.toString());

        // BlocListener<SearchBloc,SearchState>(
        //   listener: (context, state){
        //     print("식당블록");
        //     //mapItem으로 들어와서 데이터가 다시 로드될 때
        //     if (state is MovieLocationDataLoaded ||
        //         state is RestaurantDataLoaded ||
        //         state is AccommoDataLoaded ||
        //         state is AttractionDataLoaded) {
        //       print("식당뉴" + state.toString());
        //       switch (state) {
        //         case MovieLocationModel:
        //         case RestaurantModel:
        //           print("식당새롭게" + state.toString());
        //           RestaurantModel item = state as RestaurantModel;
        //           title = item.title;
        //         case AccommodationModel:
        //         case AttractionModel:
        //       }
        //     }else{
        //       //아무 변화 없을 때,
        //       print("식당뉴X");
        //     }
        //   },
        // );

        return SizedBox(
          height: widget.bottomSheetHeight ?? 550.h,
          child: ItemTable(
            header: ItemHeader(
              header: Text(
                title,
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
                    body: addressText,
                  )
                  ..phone = item.runtimeType != MovieLocationModel ? ItemTableRow(
                    title: '전화번호',
                    body: phoneNum!,
                    bodyTextStyle: Theme.of(context).textTheme.bodySmall,
                  ) : null
                  ..hours = const ItemTableRow(
                    title: '영업시간',
                    body: '''월요일 09:00~21:00
화요일 09:00~21:00
수요일 09:00~21:00
목요일 09:00~21:00
금요일 09:00~21:00
토요일 09:00~21:00
일요일 정기휴무''',
                  )
                  ..info = const ItemTableRow(
                    title: '식당정보',
                    body: '수훈비빔밥과 수훈쌈밥이 맛있는 부산 맛집!',
                  )
                  ..homePage = ItemTableRow(
                    title: '홈페이지',
                    body: 'www.soooohoooooon.co.kr',
                    bodyTextStyle: Theme.of(context).textTheme.bodySmall,
                  ),
              ),
              // ItemSection(
              //   builder: ItemSectionBuilder()..image = const ItemTableGrid(),
              // ),
            ],
          ),
        );

      },
    );
  }
}

class ItemListView extends SearchedItemView {
  String keyword;
  ItemListView({super.key, this.keyword = ""});

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  int movieLastId = 1;
  int attractionLastId = 1;
  List<Map<String, dynamic>> items = [
    {
      'title': '해운대',
      'type': TravelType.MOVIE_LOCATION,
      'movie': '개봉일 2009.07.22',
      'actors': '설경구, 하지원, 박중훈, 엄정화',
      'subTitle': null,
      'phone': null,
      'tags': [],
    },
    {
      'title': '수훈식당',
      'type': TravelType.RESTAURANT,
      'subTitle': '부산 수영구 광안로61번가길 32 2층',
      'tags': <String>['수훈비빔밥', '수훈쌈밥'],
      'phone': '0507-1367-1753',
      'movie': null,
      'actors': null,
    },
    {
      'title': '토요코인호텔 부산서면',
      'type': TravelType.ACCOMMODATION,
      'subTitle': '부산 부산진구 서전로 39',
      'phone': '051-638-1045',
      'movie': null,
      'actors': null,
      'tags': [],
    },
    {
      'title': '서면 먹자골목',
      'type': TravelType.ATTRACTION,
      'subTitle': '부산 부산진구 부전동',
      'movie': null,
      'actors': null,
      'phone': null,
      'tags': [],
    },
  ];

  @override
  void initState() {
    context.read<SearchBloc>().add(
          KeywordSearchEvent(
            keyword: widget.keyword,
            movieLastId: movieLastId,
            attractionLastId: attractionLastId,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return SearchedItem(
          type: items[index]['type'],
          title: items[index]['title'],
          subTitle: items[index]['subTitle'],
          phone: items[index]['phone'],
          movieInfo: items[index]['movie'],
          actors: items[index]['actors'],
          function: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => index % 2 == 1
                    ? ItemInfoView(
                        item: MapItem(
                          markerId: MarkerId('1'),
                          type: TravelType.ACCOMMODATION,
                          title: 'd',
                          position: LatLng(90, 10),
                        ),
                      )
                    : const MovieInfoView(), // example
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: 4,
    );
  }
}
