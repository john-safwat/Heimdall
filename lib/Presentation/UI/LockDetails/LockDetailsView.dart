import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/GetLockImagesListUseCase.dart';
import 'package:heimdall/Presentation/UI/ImagePreview/ImagePreviewView.dart';
import 'package:heimdall/Presentation/UI/LockDetails/LockDetailsNavigator.dart';
import 'package:heimdall/Presentation/UI/LockDetails/LockDetailsViewModel.dart';
import 'package:heimdall/Presentation/UI/LockDetails/Widgets/GalleryCardWidget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LockDetailsView extends StatefulWidget {
  static const String routeName = "LockDetails";
  LockCard? lockCard;

  LockDetailsView({this.lockCard, super.key});

  @override
  State<LockDetailsView> createState() => _LockDetailsViewState();
}

class _LockDetailsViewState
    extends BaseState<LockDetailsView, LockDetailsViewModel>
    implements LockDetailsNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.loadImagesList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(viewModel.local!.lockDetails),
          ),
          body: Column(
            children: [
              Consumer<LockDetailsViewModel>(builder: (context, value, child) {
                if (value.imagesErrorMessage != null) {
                  return Text(
                    value.imagesErrorMessage!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  );
                } else if (value.imagesLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (value.images.isEmpty) {
                  return Container(
                    margin: const EdgeInsets.all(20),
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor
                    ),
                    child: Lottie.asset(value.getImageEmptyAnimation()),
                  );
                } else {
                  return GalleryCardWidget(
                    images: value.images,
                    onImageClick: value.goToImagePreviewScreen,
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  LockDetailsViewModel initViewModel() {
    return LockDetailsViewModel(
        lockCard: widget.lockCard!,
        getLockImagesListUseCase: injectGetLockImagesListUseCase());
  }

  @override
  goToImagePreviewScreen({required String image, required String tag , required List<String> images}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreviewView(tag: tag, image: image , images: images),
        ));
  }
}
