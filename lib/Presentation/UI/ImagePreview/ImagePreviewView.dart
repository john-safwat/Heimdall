import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/ImagePreview/ImagePreviewNavigator.dart';
import 'package:heimdall/Presentation/UI/ImagePreview/ImagePreviewViewModel.dart';
import 'package:heimdall/Presentation/UI/ImagePreview/Widgets/ImageWidget.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:indexed_list_view/indexed_list_view.dart';
import 'package:provider/provider.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class ImagePreviewView extends StatefulWidget {
  static const String routeName = "imagePreview";
  String? image;
  List<String>? images;
  String? tag;

  ImagePreviewView({this.image, this.tag, this.images, super.key});

  @override
  State<ImagePreviewView> createState() => _ImagePreviewViewModelState();
}

class _ImagePreviewViewModelState
    extends BaseState<ImagePreviewView, ImagePreviewViewModel>
    implements ImagePreviewNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.tag = widget.tag!;
    viewModel.capturedImage = widget.image!;
    viewModel.images = widget.images!;
    viewModel.controller = IndexedScrollController(
      initialIndex: viewModel.images.indexOf(viewModel.capturedImage),
      keepScrollOffset: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<ImagePreviewViewModel>(
        builder: (context, value, child) => OrientationBuilder(
          builder: (context, orientation) => Scaffold(
            appBar: orientation == Orientation.portrait
                ? AppBar(
                    title: Text(viewModel.local!.imagePreview),
                    actions: [
                      InkWell(
                        onTap: () => viewModel.showQuestionMessage(),
                        child: const Icon(EvaIcons.download_outline)
                      ),
                      const SizedBox(width: 20,)
                    ],
                  )
                : null,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                orientation == Orientation.portrait
                    ? const Spacer()
                    : const SizedBox(),
                SizedBox(
                  height: 230,
                  child: IndexedListView.builder(
                    minItemCount: 1,
                    maxItemCount: viewModel.images.length,
                    controller: viewModel.controller,
                    scrollDirection: Axis.horizontal,
                    physics: const PageScrollPhysics(),
                    itemBuilder: (context, index) => ZoomOverlay(
                      modalBarrierColor: Colors.black12,
                      minScale: 0.5,
                      maxScale: 4.0,
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: const Duration(milliseconds: 300),
                      twoTouchOnly: true,
                      // Defaults to false
                      child: CachedNetworkImage(
                        imageUrl: viewModel.images[index],
                        fit: BoxFit.cover,
                        width: orientation == Orientation.portrait
                            ? viewModel.mediaQuery!.width
                            : null,
                        imageBuilder: (context, imageProvider) => Hero(
                          tag: "$index",
                          child: Image(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                        placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            Icons.image,
                            size: 45,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                orientation == Orientation.portrait
                    ? const Spacer()
                    : const SizedBox(),
                if (orientation == Orientation.portrait) Column(
                        children: [
                          SizedBox(
                            height: 70,
                            child: IndexedListView.separated(
                              minItemCount: 1,
                              maxItemCount: viewModel.images.length,
                              separatorBuilder: (context, index) => const SizedBox(width: 10,),
                              controller: viewModel.controller,
                              cacheExtent: viewModel.images
                                  .indexOf(viewModel.capturedImage)
                                  .toDouble(),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => ImageWidget(
                                  image: viewModel.images[index],
                                  isSelected: index ==
                                      viewModel.images
                                          .indexOf(viewModel.capturedImage),
                                  onImageClick: viewModel.onImageChange),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          )
                        ],
                      ) else const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  ImagePreviewViewModel initViewModel() {
    return ImagePreviewViewModel();
  }
}
