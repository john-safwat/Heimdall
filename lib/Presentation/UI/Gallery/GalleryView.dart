import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/Gallery/GalleryNavigator.dart';
import 'package:heimdall/Presentation/UI/Gallery/GalleryViewModel.dart';
import 'package:heimdall/Presentation/UI/ImagePreview/ImagePreviewView.dart';
import 'package:provider/provider.dart';

class GalleryView extends StatefulWidget {
  static const String routeName = "Gallery";
  List<String>? images;

  GalleryView({this.images, super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends BaseState<GalleryView, GalleryViewModel>
    implements GalleryNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.images = widget.images!;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(viewModel.local!.gallery),
          ),
          body: Column(
            children: [
              Expanded(
                  child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) => InkWell(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  onTap: () => viewModel.goToImagePreviewScreen(viewModel.images[index], "$index"),
                  child: CachedNetworkImage(
                    imageUrl: viewModel.images[index],
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    imageBuilder: (context, imageProvider) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Hero(
                        tag: "$index",
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
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(
                        Icons.image,
                        size: 45,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
                itemCount: viewModel.images.length,
              ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  goToImagePreviewScreen(
      {required String image,
      required String tag,
      required List<String> images}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ImagePreviewView(tag: tag, image: image, images: images),
        ));
  }

  @override
  GalleryViewModel initViewModel() {
    return GalleryViewModel();
  }
}
