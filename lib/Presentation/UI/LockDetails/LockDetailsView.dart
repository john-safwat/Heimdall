import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Core/Providers/LocksProvider.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:heimdall/Domain/UseCase/ChangeLockStateUseCase.dart';
import 'package:heimdall/Domain/UseCase/GetLockImagesListUseCase.dart';
import 'package:heimdall/Domain/UseCase/GetLockKeysUseCase.dart';
import 'package:heimdall/Domain/UseCase/SetLockRealTimeDatabaseListenerUseCase.dart';
import 'package:heimdall/Presentation/UI/CreateKey/ManageKeyView.dart';
import 'package:heimdall/Presentation/UI/Gallery/GalleryView.dart';
import 'package:heimdall/Presentation/UI/ImagePreview/ImagePreviewView.dart';
import 'package:heimdall/Presentation/UI/LockDetails/LockDetailsNavigator.dart';
import 'package:heimdall/Presentation/UI/LockDetails/LockDetailsViewModel.dart';
import 'package:heimdall/Presentation/UI/LockDetails/Widgets/GalleryCardWidget.dart';
import 'package:heimdall/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:heimdall/Presentation/UI/Widgets/KeyCardWidget.dart';
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
    viewModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    viewModel.locksProvider = Provider.of<LocksProvider>(context);
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel,
      child: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          color: Theme.of(context).scaffoldBackgroundColor,
          onRefresh: () async {
            viewModel.loadData();
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(viewModel.local!.lockDetails),
            ),
            body: Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Consumer<LockDetailsViewModel>(
                        builder: (context, value, child) {
                      if (value.imagesErrorMessage != null) {
                        return ErrorMessageWidget(
                            errorMessage: value.imagesErrorMessage!,
                            fixErrorFunction: value.loadImagesList);
                      } else if (value.imagesLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (value.images.isEmpty) {
                        return Container(
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
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                        onPressed: () => viewModel.goToCreateKeyScreen(),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(viewModel.local!.createKey),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      viewModel.local!.keysList,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Consumer<LockDetailsViewModel>(
                        builder: (context, value, child) {
                      if (value.imagesErrorMessage != null) {
                        return ErrorMessageWidget(
                            errorMessage: value.imagesErrorMessage!,
                            fixErrorFunction: value.loadImagesList);
                      } else if (value.imagesLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                  childAspectRatio: 0.8),
                          itemBuilder: (context, index) => KeyCardWidget(
                            myKey: viewModel.keys[index],
                            onClick: viewModel.onCardClick,
                          ),
                          itemCount: viewModel.keys.length,
                        );
                      }
                    }),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).secondaryHeaderColor.withOpacity(0.5),
                          Colors.transparent
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter
                      )
                    ),
                    width: viewModel.mediaQuery!.width,
                    child: Consumer<LockDetailsViewModel>(
                        builder: (context, value, child) {
                      if (value.lockLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(1000),
                              onTap: () {
                                viewModel.changeLockState();
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 80,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      border: Border.all(
                                          width: 3,
                                          color: Theme.of(context)
                                              .secondaryHeaderColor),
                                      borderRadius:
                                      BorderRadius.circular(1000),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.3),
                                            blurRadius: 20,
                                            offset: const Offset(0, 0))
                                      ]),
                                  child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 3,
                                            color: Theme.of(context)
                                                .primaryColor),
                                        borderRadius:
                                        BorderRadius.circular(1000),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.4),
                                                blurRadius: 10,
                                                offset: const Offset(0, 0))
                                          ],
                                          color: viewModel.locksProvider
                                              .value["opened"] !=
                                              null &&
                                              viewModel.locksProvider
                                                  .value["opened"]
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          border: Border.all(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .secondaryHeaderColor),
                                          borderRadius:
                                          BorderRadius.circular(1000),
                                        ),
                                        child: SvgPicture.asset(
                                          viewModel.locksProvider
                                              .value["opened"] !=
                                              null &&
                                              viewModel.locksProvider
                                                  .value["opened"]
                                              ? "assets/SVG/lock_opened.svg"
                                              : "assets/SVG/lock_closed.svg",
                                          color: viewModel.locksProvider
                                              .value["opened"] !=
                                              null &&
                                              viewModel.locksProvider
                                                  .value["opened"]
                                              ? Theme.of(context)
                                              .scaffoldBackgroundColor
                                              : Theme.of(context)
                                              .primaryColor,
                                          width: double.infinity,
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                )
              ],
            ),
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
        changeLockStateUseCase: injectChangeLockStateUseCase(),
        getLockKeysUseCase: injectGetLockKeysUseCase());
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
          builder: (context) => GalleryView(
            images: images,
          ),
        ));
  }

  @override
  goToCreateKeyScreen({required LockCard lockCard}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ManageKeyView(
                  lockCard: lockCard,
                )));
    viewModel.loadKeys();
  }

  @override
  goToManageKeyScreen({required LockCard lockCard, required EKey eKey}) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ManageKeyView(
                  lockCard: lockCard,
                  eKey: eKey,
                )));
    viewModel.loadKeys();
  }
}
