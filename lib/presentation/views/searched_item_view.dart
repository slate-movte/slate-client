import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/utils/enums.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/domain/entities/map_item.dart';
import 'package:slate/domain/entities/movie.dart';
import 'package:slate/domain/entities/travel.dart';
import 'package:slate/injection.dart';
import 'package:slate/presentation/bloc/map/map_bloc.dart';
import 'package:slate/presentation/bloc/map/map_event.dart';
import 'package:slate/presentation/bloc/map/map_state.dart';
import 'package:slate/presentation/bloc/search/keyword/search_bloc.dart';
import 'package:slate/presentation/bloc/search/keyword/search_event.dart';
import 'package:slate/presentation/bloc/search/keyword/search_state.dart';
import 'package:slate/presentation/bloc/search/travel/travel_bloc.dart';
import 'package:slate/presentation/bloc/search/travel/travel_event.dart';
import 'package:slate/presentation/bloc/search/travel/travel_state.dart';
import 'package:slate/presentation/views/movie_info_view.dart';
import 'package:slate/presentation/widgets/item_table.dart';

import 'package:slate/presentation/widgets/searched_item.dart';

import '../../core/utils/assets.dart';
import '../../data/models/travel_model.dart';
import '../widgets/item_table.dart';
import 'marker_info_view.dart';

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
  bool curLocTag = false;
  bool _open = false;

  @override
  void initState() {
    if (widget.initBottomSheet && widget.item != null) {
      context
          .read<MapBloc>()
          .add(InitializeMapEvent(latLng: widget.item!.position));
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        // openBottomSheet(context, widget.item!);
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
          BlocListener<TravelBloc, TravelState>(
            child: SizedBox.shrink(),
            listener: (context, state) {
              Travel travel = const Travel(
                id: 0,
                title: "title",
                type: TravelType.MOVIE_LOCATION,
                location: LatLng(0, 0),
                address: "address",
                tel: "010-0000-0000",
                imageUrl: "",
                menus: [],
              );

              if (state is MovieLocationDataLoaded) {
                travel = state.movieLocation;
              } else if (state is RestaurantDataLoaded) {
                travel = state.restaurant;
              } else if (state is AccommoDataLoaded) {
                travel = state.accommodation;
              } else if (state is AttractionDataLoaded) {
                travel = state.attraction;
              }

              if (!widget.initBottomSheet) {
                openModalDailog(context, travel);
              }
            },
          ),
          BlocConsumer<MapBloc, MapState>(
            listener: (context, state) async {
              if (state is MapInitialized) {
                //맵 초기화가 일어날 때가 하단 모달 있는 상태이면 초기화 중단 (제외고려)
                if (_open) {
                  return;
                }
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
                    context.read<MapBloc>().add(GetMarkersEvent(
                        type: TravelType.MOVIE_LOCATION,
                        latLng: _position.target));
                  }
                });
              } else if (state is CameraMoved) {
                GoogleMapController controller = await _controller.future;
                _position = state.cameraPosition;
                await controller.animateCamera(
                  CameraUpdate.newCameraPosition(_position),
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
                            _open = true;

                            switch (item.type) {
                              case TravelType.RESTAURANT:
                                context.read<TravelBloc>().add(
                                    GetRestaurantInfoEvent(
                                        id: int.parse(
                                            item.markerId.value.toString())));
                                break;
                              case TravelType.ACCOMMODATION:
                                context.read<TravelBloc>().add(
                                    GetAccommoInfoEvent(
                                        id: int.parse(
                                            item.markerId.value.toString())));
                                break;
                              case TravelType.ATTRACTION:
                                context.read<TravelBloc>().add(
                                    GetAttractionInfoEvent(
                                        id: int.parse(
                                            item.markerId.value.toString())));
                                break;
                              case TravelType.MOVIE_LOCATION:
                                context.read<TravelBloc>().add(
                                    GetMovieLocationInfoEvent(
                                        id: int.parse(
                                            item.markerId.value.toString())));
                                break;
                            }
                          },
                        ),
                      );

                      GoogleMapController controller = await _controller.future;

                      await controller.animateCamera(
                        CameraUpdate.newCameraPosition(CameraPosition(
                            target: curLocTag
                                ? _position.target
                                : state.markers[0].position,
                            zoom: 15)),
                      );

                      setState(() {
                        curLocTag = false;
                      });
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
                  onTap: closeModal,
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeOf.w_md,
                  vertical: SizeOf.h_md,
                ),
                child: ActionChip(
                  label: Text("현재 위치에서 검색"),
                  backgroundColor: ColorOf.white.light,
                  labelStyle: Theme.of(context).textTheme.bodyLarge,
                  shape: StadiumBorder(),
                  onPressed: () async {
                    LatLng centerLocation = await calculateCenter();
                    setState(() {
                      curLocTag = true;
                      _position =
                          CameraPosition(target: centerLocation, zoom: 15);
                    });
                    context.read<MapBloc>().add(
                          GetMarkersEvent(
                              type: onTapedTag, latLng: _position.target),
                        );
                  },
                )),
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
                            onPressed: () async {
                              //테그 클릭하면 하단 모달 닫기
                              if (_open) {
                                Navigator.pop(context);
                                _open = false;
                              }
                              setState(() {
                                onTapedTag = element.$3;
                              });
                              LatLng centerLocation = await calculateCenter();
                              setState(() {
                                _position = CameraPosition(
                                    target: centerLocation, zoom: 15);
                              });
                              context.read<MapBloc>().add(
                                    GetMarkersEvent(
                                        type: element.$3,
                                        latLng: _position.target),
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

  Future<void> closeModal(LatLng latlng) async {
    //맵 클릭시 하단 모달 닫기
    if (_open) {
      Navigator.pop(context);
      _open = false;
    }
  }

  //중심 찾기 함수
  Future<LatLng> calculateCenter() async {
    GoogleMapController controller = await _controller.future;
    LatLngBounds visibleRegion = await controller.getVisibleRegion();

    LatLng southwest = visibleRegion.southwest;
    LatLng northeast = visibleRegion.northeast;

    double centerLat = (southwest.latitude + northeast.latitude) / 2;
    double centerLng = (southwest.longitude + northeast.longitude) / 2;

    return LatLng(centerLat, centerLng);
  }

  Future openModalDailog(BuildContext context, Travel item) async {
    showBottomSheet(
      backgroundColor: Colors.white.withOpacity(0.0),
      context: context,
      builder: (context) => Container(
        color: ColorOf.white.light,
        height: 160.h,
        child: SearchedItem(
          title: item.title,
          type: item.type,
          subTitle: item.address,
          tag: item.menus ?? [],
          phone: [TravelType.MOVIE_LOCATION, TravelType.ATTRACTION]
                  .contains(item.type)
              ? null
              : item.tel,
          imageUrl: item.imageUrl,
          function: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => item.type == TravelType.MOVIE_LOCATION
                    ? MovieInfoView(
                        movieId: item.id,
                      )
                    // : ItemInfoView(item: item),
                    : MarkerInfoView(
                        id: item.id,
                        type: item.type,
                        title: item.title,
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ItemListView extends SearchedItemView {
  // List items;

  ItemListView({
    super.key,
    // this.items = const [],
  });

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  List items = [];
  bool isLoadMoreRunning = false;
  ScrollController controller = ScrollController();
  double lastOffset = 0.0;
  bool isEndScroll = false;

  void _addScrollController() {
    if (controller.offset == controller.position.maxScrollExtent &&
        !controller.position.outOfRange &&
        !isEndScroll) {
      context.read<SearchBloc>().add(KeywordSearchEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(_addScrollController);

    return BlocConsumer<SearchBloc, SearchState>(
      listener: (context, state) {
        if (state is KeywordDataLoaded) {
          if (!isEndScroll) {
            setState(() {
              isLoadMoreRunning = false;
              items.addAll(state.dataList);
            });
            isEndScroll = state.endData;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              lastOffset = controller.offset;
              if (controller.hasClients) {
                controller.jumpTo(lastOffset);
              }
            });
          }
        } else if (state is InitSearch) {
          setState(() {
            items = [];
            isEndScroll = false;
          });
        } else if (state is SearchDataLoading) {
          setState(() {
            isLoadMoreRunning = true;
          });
        }
      },
      builder: (context, state) {
        if (state is InitSearch) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                controller: controller,
                itemBuilder: (context, index) {
                  if (items[index] is Movie) {
                    return SearchedItem.movie(
                      movie: items[index],
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieInfoView(
                              movieId: (items[index] as Movie).id,
                            ),
                          ),
                        );
                      },
                    );
                  } else if (items[index] is Travel) {
                    return SearchedItem.travel(
                      travel: items[index],
                      function: () {
                        log(items[index].id.toString());
                        log(items[index].type.toString());
                        log(items[index].title.toString());

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MarkerInfoView(
                              id: items[index].id,
                              type: items[index].type,
                              title: items[index].title,
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return SizedBox.shrink();
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: items.length,
              ),
            ),
            if (isLoadMoreRunning)
              Container(
                padding: EdgeInsets.symmetric(vertical: SizeOf.h_lg),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      },
    );
  }
}
