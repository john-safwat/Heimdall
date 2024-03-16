import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Core/Providers/LocksProvider.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/ChangeLockStateUseCase.dart';
import 'package:heimdall/Domain/UseCase/GetLockImagesListUseCase.dart';
import 'package:heimdall/Domain/UseCase/SetLockRealTimeDatabaseListenerUseCase.dart';
import 'package:heimdall/Presentation/UI/Gallery/GalleryView.dart';
import 'package:heimdall/Presentation/UI/ImagePreview/ImagePreviewView.dart';
import 'package:heimdall/Presentation/UI/LockDetails/LockDetailsNavigator.dart';
import 'package:heimdall/Presentation/UI/LockDetails/LockDetailsViewModel.dart';
import 'package:heimdall/Presentation/UI/LockDetails/Widgets/GalleryCardWidget.dart';
import 'package:heimdall/Presentation/UI/Widgets/ErrorMessageWidget.dart';
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
    viewModel.locksProvider =
        Provider.of<LocksProvider>(context, listen: false);
    viewModel.locksProvider.lockId = viewModel.lockCard.lockId;
    viewModel.loadImagesList();
    viewModel.setDatabaseListener();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    viewModel.locksProvider = Provider.of<LocksProvider>(context);
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(viewModel.local!.lockDetails),
          ),
          body: ListView(
            children: [
              Consumer<LockDetailsViewModel>(builder: (context, value, child) {
                if (value.imagesErrorMessage != null) {
                  return ErrorMessageWidget(
                      errorMessage: value.imagesErrorMessage!,
                      fixErrorFunction: value.loadImagesList
                  );
                } else if (value.imagesLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (value.images.isEmpty) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor),
                    child: Lottie.asset(value.getImageEmptyAnimation()),
                  );
                } else {
                  return GalleryCardWidget(
                    images: value.images,
                    onImageClick: value.goToImagePreviewScreen,
                    onMoreImagesPress: value.goToGalleryScreen,
                  );
                }
              }),
              Consumer<LockDetailsViewModel>(builder: (context, value, child) {
                if (value.lockErrorMessage != null) {
                  return Text(
                    value.lockErrorMessage!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  );
                } else if (value.lockLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              viewModel.locksProvider
                                  .value["opened"] !=
                                  null && viewModel.locksProvider.value["opened"]?MyTheme.green: MyTheme.red
                          )
                        ),
                        onPressed: () {
                          viewModel.changeLockState();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                viewModel.locksProvider
                                    .value["opened"] !=
                                    null && viewModel.locksProvider.value["opened"]

                                    ? viewModel.local!.opened
                                    : viewModel.local!.closed,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                              ),
                              Switch(
                                activeColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                value:
                                    viewModel.locksProvider.value["opened"] ??
                                        false,
                                onChanged: (value) => () {
                                  viewModel.changeLockState();
                                },
                              )
                            ],
                          ),
                        )),
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
        getLockImagesListUseCase: injectGetLockImagesListUseCase(),
        setLockRealTimeDatabaseListenerUseCase:
            injectSetLockRealTimeDatabaseListenerUseCase(),
        changeLockStateUseCase: injectChangeLockStateUseCase());
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
  goToGalleryScreen({required List<String> images}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              GalleryView(images: images,),
        ));
  }
}
