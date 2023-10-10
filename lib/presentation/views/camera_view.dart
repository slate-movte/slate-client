import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/themes.dart';
import '../bloc/camera/camera_bloc.dart';
import '../bloc/camera/camera_event.dart';
import '../bloc/camera/camera_state.dart';
import '../bloc/scene/scene_bloc.dart';
import '../bloc/scene/scene_event.dart';
import '../bloc/scene/scene_state.dart';
import '../widgets/item_table.dart';
import 'display_picture_view.dart';

class CameraView extends StatefulWidget {
  const CameraView({
    super.key,
  });

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  bool pipVisible = true;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    context.read<CameraBloc>().add(CameraOnEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('촬영하기'),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                pipVisible = !pipVisible;
              });
            },
            icon: Icon(
              pipVisible ? Icons.visibility_off : Icons.visibility,
              color: ColorOf.grey.light,
            ),
          ),
        ],
      ),
      body: BlocConsumer<CameraBloc, CameraState>(
        listener: (context, state) async {
          if (state is TakePictureDone) {
            await Navigator.of(context)
                .push(
                  MaterialPageRoute(
                    builder: (context) => DisplayPictureView(
                      image: state.image,
                    ),
                  ),
                )
                .then(
                  (_) => context.read<CameraBloc>().add(CameraOnEvent()),
                );
          }
        },
        builder: (context, state) {
          if (state is CameraGetReady) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CameraOn) {
            return Column(
              children: [
                Flexible(
                  child: SizedBox(
                    width: double.infinity,
                    child: CameraPreview(
                      state.controller,
                      child: Stack(
                        children: [
                          Visibility(
                            visible: pipVisible,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: SizeOf.w_md,
                                  vertical: SizeOf.h_md,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    openBottomSheet(context);
                                  },
                                  child: Container(
                                    width: 169.w,
                                    height: 113.h,
                                    decoration: ShapeDecoration(
                                      color: ColorOf.black.light,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(SizeOf.r),
                                      ),
                                    ),
                                    child: BlocBuilder<SceneBloc, SceneState>(
                                      builder: (context, state) {
                                        if (state is SceneSelected) {
                                          return ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8)),
                                            child:
                                                Image.network(state.sceneUrl),
                                          );
                                        }
                                        return const Center(
                                          child: Text("영화씬을 선택하세요."),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SafeArea(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: SizeOf.w_lg),
                    height: 140.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FloatingActionButton(
                          heroTag: null,
                          onPressed: () {
                            openBottomSheet(context);
                          },
                          elevation: 0,
                          backgroundColor: ColorOf.lightGrey.light,
                          child: Icon(
                            Icons.image,
                            color: ColorOf.black.light,
                          ),
                        ),
                        FloatingActionButton.large(
                          onPressed: () {
                            context.read<CameraBloc>().add(
                                TakePictureEvent(controller: state.controller));
                          },
                          elevation: 0,
                          backgroundColor: Colors.white,
                          shape: CircleBorder(
                              side: BorderSide(
                            color: ColorOf.point.light,
                            width: 6.r,
                          )),
                        ),
                        FloatingActionButton(
                          heroTag: null,
                          onPressed: () {
                            context
                                .read<CameraBloc>()
                                .add(DirectionChangeEvent());
                          },
                          backgroundColor: ColorOf.lightGrey.light,
                          elevation: 0,
                          child: Icon(
                            Icons.flip_camera_android,
                            color: ColorOf.black.light,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is CameraError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                  Text(state.message),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future openBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      showDragHandle: true,
      elevation: 1,
      enableDrag: true,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          color: ColorOf.white.light,
          height: 700.h,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeOf.w_lg,
                  vertical: SizeOf.h_md,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    maxLength: 20,
                    style: Theme.of(context).textTheme.bodyLarge,
                    cursorColor: ColorOf.grey.light,
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIconColor: ColorOf.grey.light,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: SizeOf.w_md,
                        vertical: 8.h,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.xmark_circle_fill),
                      ),
                      prefixIconColor: ColorOf.grey.light,
                      prefixIcon: const Icon(Icons.search),
                      labelText: '영화 이름을 검색해주세요.',
                    ),
                    onEditingComplete: () {
                      context.read<SceneBloc>().add(
                            GetScenesEvent(input: controller.text),
                          );
                      FocusScope.of(context).unfocus();
                    },
                    controller: controller,
                  ),
                ),
              ),
              BlocBuilder<SceneBloc, SceneState>(
                builder: (context, state) {
                  if (state is SceneIsEmpty) {
                    return const Text('해당 영화의 씬이 없습니다.');
                  } else if (state is SceneError) {
                    return const Center(
                      child: Text('다시 검색해주세요.'),
                    );
                  } else if (state is SceneLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SceneLoaded) {
                    return Flexible(
                      child: ItemTable(
                        sections: state.list
                            .map(
                              (movie) => ItemSection(
                                builder: ItemSectionBuilder()
                                  ..image = ItemTableGrid(
                                    title: movie.title,
                                    titleStyle: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                    items: movie.sceneImages
                                        .map((scene) => scene.imageUrl)
                                        .toList(),
                                  ),
                              ),
                            )
                            .toList(),
                      ),
                    );
                  }
                  return const Center(
                    child: Text("검색어를 입력해주세요."),
                  );
                },
              ),
            ],
          ),
        );
      },
    ).whenComplete(
      () {
        controller.clear();
      },
    );
  }
}
