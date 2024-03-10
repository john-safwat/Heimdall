import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/ImagePreview/ImagePreviewNavigator.dart';
import 'package:heimdall/Presentation/UI/ImagePreview/ImagePreviewViewModel.dart';
import 'package:heimdall/Presentation/UI/ImagePreview/Widgets/ImageWidget.dart';
import 'package:provider/provider.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';

class ImagePreviewView extends StatefulWidget {
  static const String routeName = "imagePreview";
  String? image;
  List<String>? images;
  String? tag;
  ImagePreviewView({this.image, this.tag , this.images, super.key});

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
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<ImagePreviewViewModel>(
        builder: (context, value, child) => OrientationBuilder(
          builder: (context, orientation) => Scaffold(
            appBar: orientation == Orientation.portrait?AppBar(
              title: Text(viewModel.local!.imagePreview),
            ):null,
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ZoomOverlay(
                    modalBarrierColor: Colors.black12,
                    minScale: 0.5,
                    maxScale: 4.0,
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration:const Duration(milliseconds: 300),
                    twoTouchOnly: true, // Defaults to false
                    child: CachedNetworkImage(
                      imageUrl: viewModel.capturedImage,
                      fit: BoxFit.cover,
                      width: orientation == Orientation.portrait? double.infinity : null,
                      imageBuilder: (context, imageProvider) => ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Hero(
                          tag: viewModel.tag,
                          child: Image(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Icon(
                          Icons.image,
                          size: 45,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  ),
                  orientation == Orientation.portrait? SizedBox(
                    height:  100,
                    child: Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => ImageWidget(
                            image: viewModel.images[index],
                            tag: "$index",
                            onImageClick: viewModel.onImageChange
                        ),
                        itemCount: viewModel.images.length,
                      ),
                    ),
                  ) :const SizedBox()
                ],
              ),
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
