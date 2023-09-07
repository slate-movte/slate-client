import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:slate/core/utils/themes.dart';
import 'package:slate/presentation/bloc/marker_bloc.dart';
import 'package:slate/presentation/bloc/marker_event.dart';
import 'package:slate/presentation/views/item_info_view.dart';
import 'package:slate/presentation/views/movie_info_view.dart';
import 'package:slate/presentation/widgets/item_table.dart';

import 'package:slate/presentation/widgets/searched_item.dart';

import '../bloc/location_bloc.dart';
import '../bloc/location_event.dart';
import '../bloc/location_state.dart';
import '../bloc/marker_state.dart';

bool openedBottomSheet = false;

abstract class SearchedItemView extends StatefulWidget {
  final List items;

  const SearchedItemView({super.key, required this.items});
}

class ItemMapView extends SearchedItemView {
  final bool initBottomSheet;
  final double? bottomSheetHeight;

  const ItemMapView({
    super.key,
    required super.items,
    this.initBottomSheet = false,
    this.bottomSheetHeight,
  });

  @override
  State<ItemMapView> createState() => _ItemMapViewState();
}

class _ItemMapViewState extends State<ItemMapView> {
  @override
  void initState() {
    if (widget.initBottomSheet) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        openBottomSheet(context);
      });
    }
    super.initState();
  }

  late GoogleMapController mapController;

  late LatLng currentPosition;

  //초기 마커 더미 데이터 -> 만약 bloc 잘 작동되면 position이 변경되면서 마커 3개가 등장해야 함.
  Set<Marker> markerList = {
    Marker(
      markerId: const MarkerId("전주식당"),
      position: const LatLng(38.6313962, 127.0767797)
    ),
    Marker(
      markerId: const MarkerId("행복숙소"),
      position: const LatLng(38.63089, 127.0796858),
    )
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.small(
          heroTag: null,
            onPressed: () {
               context.read<LocationBloc>().add(UpdateLocationEvent());
            },
            child: Icon(Icons.my_location, color: Colors.deepOrange,),
            backgroundColor: Colors.white,
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: openedBottomSheet ? MediaQuery.of(context).size.height - (widget.bottomSheetHeight ?? 550.h) : 600.h, //기본 높이를 double.infinity로 하면 오류
          child: BlocBuilder<LocationBloc, LocationState>(
              builder: (context,state){
                if(state is LocationLoadingState){
                  return GoogleMap(
                      initialCameraPosition: CameraPosition(target: currentPosition, zoom: 14),
                      onMapCreated: (GoogleMapController controller){
                        mapController = controller;
                      },
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      markers: markerList
                  );
                }else if(state is LocationLoadedState){
                  if(state.locationData == LatLng(35.171585, 129.127796)){
                    return GoogleMap(
                        initialCameraPosition: CameraPosition(target: LatLng(state.locationData.latitude, state.locationData.longitude), zoom: 14),
                        onMapCreated: (GoogleMapController controller){
                          mapController = controller;
                          currentPosition = state.locationData;
                        },
                        myLocationEnabled: true,
                        myLocationButtonEnabled: false,
                        markers: markerList
                    );
                  }else{
                    mapController.animateCamera(CameraUpdate.newLatLngZoom(LatLng(state.locationData.latitude, state.locationData.longitude), 14));
                  }
                }
                BlocBuilder<MarkerBloc, MarkerState>(
                    builder: (markcontext, markstate){
                      print("마커 작동 테스트1");
                      if(markstate is MarkerLoadedState){
                        print("마커 작동 테스트2");
                        setState(() {
                          markerList = markstate.markerData;
                          print("업데이트 마커 정보:" + markerList.toString());
                        });
                      }
                      return GoogleMap(
                          initialCameraPosition: CameraPosition(target: currentPosition, zoom: 14),
                          onMapCreated: (GoogleMapController controller){
                            mapController = controller;
                          },
                          myLocationEnabled: true,
                          myLocationButtonEnabled: false,
                          markers: markerList
                      );
                    }
                );
                return GoogleMap(
                    initialCameraPosition: CameraPosition(target: currentPosition, zoom: 14),
                    onMapCreated: (GoogleMapController controller){
                      mapController = controller;
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    markers: markerList
                );

              }
          ),

        ),
        Center(
          child: IconButton(
            onPressed: () async {
              setState(() {
                openedBottomSheet = true;
              });
              await openBottomSheet(context);
            },
            icon: Icon(
              Icons.pin_drop_outlined,
              color: ColorOf.white.light,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Visibility(
              visible: openedBottomSheet ? false : true,
              child: Row(
                children: [
                  ('영화 촬영지', AssetImage('lib/assets/images/film.png'), 12.w, 14.h, 'MOVIE_LOCATION'),
                  ('식당', AssetImage('lib/assets/images/food.png'), 14.w, 14.h, 'RESTAURANT'),
                  ('관광지', AssetImage('lib/assets/images/flag.png'), 14.w, 12.h, 'ATTRACTION'),
                  ('숙박', AssetImage('lib/assets/images/building.png'), 12.w, 14.h, 'ACCOMMODATION'),
                ]
                    .map(
                      (element) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeOf.w_sm / 2,
                      vertical: SizeOf.h_sm,
                    ),
                    child: ActionChip(
                      avatar: Image(image: element.$2, width: element.$3, height: element.$4),
                      label: Text(element.$1),
                      backgroundColor: ColorOf.white.light,
                      labelStyle: Theme.of(context).textTheme.bodyLarge,
                      shape: const StadiumBorder(),
                      elevation: 0.6,
                      onPressed: () {
                        context.read<MarkerBloc>().add(MarkerLoadedEvent(markerType: element.$5));

                      },
                    ),
                  ),
                ).toList(),
              ),
            )
          ),
        ),
      ],
    )
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
  const ItemListView({super.key, required super.items});

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
