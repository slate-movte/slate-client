import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/utils/enums.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/injection.dart';
import 'package:slate/presentation/bloc/map/map_bloc.dart';
import 'package:slate/presentation/bloc/map/map_event.dart';
import 'package:slate/presentation/bloc/map/map_state.dart';
import 'package:slate/presentation/views/item_info_view.dart';
import 'package:slate/presentation/views/movie_info_view.dart';
import 'package:slate/presentation/widgets/item_table.dart';

import 'package:slate/presentation/widgets/searched_item.dart';

bool openedBottomSheet = false;

abstract class SearchedItemView extends StatefulWidget {
  const SearchedItemView({super.key});
}

class ItemMapView extends SearchedItemView {
  final bool initBottomSheet;
  final double? bottomSheetHeight;

  const ItemMapView({
    super.key,
    this.initBottomSheet = false,
    this.bottomSheetHeight,
  });

  @override
  State<ItemMapView> createState() => _ItemMapViewState();
}

class _ItemMapViewState extends State<ItemMapView> {
  @override
  void initState() {
    context.read<MapBloc>().add(InitializeMapEvent());
    if (widget.initBottomSheet) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        openBottomSheet(context);
      });
    }
    super.initState();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late CameraPosition _position;
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        children: [
          BlocConsumer<MapBloc, MapState>(
            listener: (context, state) async {
              if (state is MapInitialized) {
                setState(() {
                  _position = state.cameraPosition;
                });
              } else if (state is CameraMoved) {
                GoogleMapController controller = await _controller.future;
                await controller.animateCamera(
                  CameraUpdate.newCameraPosition(state.cameraPosition),
                );
              } else if (state is MarkerLoaded) {
                setState(() {
                  _markers = state.markers;
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
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Visibility(
                  visible: openedBottomSheet ? false : true,
                  child: Row(
                    children: [
                      (
                        '영화 촬영지',
                        AssetImage('lib/assets/images/film.png'),
                        12.w,
                        14.h,
                        TravelType.MOVIE_LOCATION,
                      ),
                      (
                        '식당',
                        AssetImage('lib/assets/images/food.png'),
                        14.w,
                        14.h,
                        TravelType.RESTAURANT,
                      ),
                      (
                        '관광지',
                        AssetImage('lib/assets/images/flag.png'),
                        14.w,
                        12.h,
                        TravelType.ATTRACTION,
                      ),
                      (
                        '숙박',
                        AssetImage('lib/assets/images/building.png'),
                        12.w,
                        14.h,
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
                                  width: element.$3,
                                  height: element.$4),
                              label: Text(element.$1),
                              backgroundColor: ColorOf.white.light,
                              labelStyle: Theme.of(context).textTheme.bodyLarge,
                              shape: const StadiumBorder(),
                              elevation: 0.6,
                              onPressed: () {
                                context.read<MapBloc>().add(
                                      GetMarkersEvent(type: element.$5),
                                    );
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Future openBottomSheet(BuildContext context) async {
    showBottomSheet(
      elevation: 1,
      context: context,
      builder: (context) {
        //하단시트 올라가면 카메라 움직이게 하려는 의도였지만 CameraUpdate로는 초기화 에러 발생.
        //mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(37.6313962, 127.0767797), 14));

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
                    setState(() {
                      openedBottomSheet = false;
                    });
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
              ItemSection(
                builder: ItemSectionBuilder()..image = const ItemTableGrid(),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ItemListView extends SearchedItemView {
  const ItemListView({super.key});

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return SearchedItem(
          function: () {
            setState(() {
              openedBottomSheet = true;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => index % 2 == 0
                    ? const ItemInfoView()
                    : const MovieInfoView(), // example
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: 3,
    );
  }
}
