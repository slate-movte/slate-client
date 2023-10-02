import 'dart:async';

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
import 'package:slate/presentation/views/item_info_view.dart';
import 'package:slate/presentation/views/movie_info_view.dart';
import 'package:slate/presentation/widgets/item_table.dart';

import 'package:slate/presentation/widgets/searched_item.dart';

import '../../core/utils/assets.dart';

abstract class SearchedItemView extends StatefulWidget {
  const SearchedItemView({super.key});
}

class ItemMapView extends SearchedItemView {
  final bool initBottomSheet;
  final double? bottomSheetHeight;
  final MapItem? item;

  const ItemMapView({
    super.key,
    this.initBottomSheet = false,
    this.bottomSheetHeight,
    this.item,
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
        openBottomSheet(context);
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
                        openBottomSheet(context);
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
                    (item) {
                      _markers.add(
                        Marker(
                          markerId: item.markerId,
                          position: item.position,
                          onTap: () {
                            widget.initBottomSheet
                                ? openBottomSheet(context)
                                : openModalDailog(context, item);
                          },
                        ),
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

  Future openModalDailog(BuildContext context, MapItem item) async {
    showBottomSheet(
      context: context,
      builder: (context) => Container(
        color: ColorOf.white.light,
        height: 200.h,
        child: SearchedItem(
          title: '수훈식당',
          type: TravelType.RESTAURANT,
          subTitle: '부산 수영구 광안로61번가길 32 2층',
          tag: ['수훈비빔밥', '수훈쌈밥'],
          phone: '0507-1367-1753',
          function: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => item.type == TravelType.MOVIE_LOCATION
                    ? const MovieInfoView()
                    : ItemInfoView(item: item),
              ),
            );
          },
        ),
      ),
    );
  }

  Future openBottomSheet(BuildContext context) async {
    showBottomSheet(
      elevation: 1,
      context: context,
      builder: (context) {
        return SizedBox(
          height: widget.bottomSheetHeight ?? 550.h,
          child: ItemTable(
            header: ItemHeader(
              header: Text(
                '수훈식당',
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
                  ..address = const ItemTableRow(
                    title: '주소',
                    body: '부산 수영구 광안로 61번가길 32 2층',
                  )
                  ..phone = ItemTableRow(
                    title: '전화번호',
                    body: '0507-1367-1753',
                    bodyTextStyle: Theme.of(context).textTheme.bodySmall,
                  )
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
  List items;

  ItemListView({
    super.key,
    this.items = const [],
  });

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (widget.items[index] is Movie) {
          return SearchedItem.movie(
            movie: widget.items[index],
            function: () {},
          );
          // Movie movie = widget.items[index] as Movie;
          // log(movie.toString());
          // return SearchedItem(
          //   item: movie,
          //   type: TravelType.MOVIE_LOCATION,
          //   title: movie.title,
          //   movieInfo: movie.plot,
          // );
        } else if (widget.items[index] is Travel) {
          return SearchedItem.travel(
            travel: widget.items[index],
            function: () {},
          );
        }
        return SizedBox.shrink();
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: widget.items.length,
    );
  }
}
