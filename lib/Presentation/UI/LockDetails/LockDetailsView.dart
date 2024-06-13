import 'package:flutter/material.dart';
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
import 'package:heimdall/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:heimdall/Presentation/UI/Widgets/KeyCardWidget.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/bi.dart';
import 'package:iconify_flutter_plus/icons/ic.dart';
import 'package:load_switch/load_switch.dart';
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
              body: Consumer<LockDetailsViewModel>(
                  builder: (context, value, child) {
                if (value.imagesErrorMessage != null) {
                  return ErrorMessageWidget(
                      errorMessage: value.imagesErrorMessage!,
                      fixErrorFunction: value.loadImagesList);
                } else if (value.keysErrorMessage != null) {
                  return ErrorMessageWidget(
                      errorMessage: value.keysErrorMessage!,
                      fixErrorFunction: value.loadKeys);
                } else if (value.imagesLoading || value.keysLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      SizedBox(
                        height: 500,
                        child: Stack(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 40),
                              alignment: Alignment.bottomCenter,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(viewModel.lockCard.color),
                              ),
                              child: Image.asset(viewModel.lockCard.image),
                            ),
                            Positioned.fill(
                                child: Container(
                              padding: const EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).primaryColor,
                                        Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.5),
                                        Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.3),
                                        Colors.transparent
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      viewModel.lockCard.name,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.w900,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor),
                                    ),
                                  ),
                                  const Expanded(child: SizedBox())
                                ],
                              ),
                            )),
                            Positioned.fill(
                                child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  LoadSwitch(
                                    value:
                                        viewModel.locksProvider.value["opened"],
                                    future: () async {
                                      await viewModel.changeLockState();
                                      return viewModel
                                          .locksProvider.value["opened"];
                                    },
                                    style: SpinStyle.material,
                                    onChange: (v) {},
                                    onTap: (v) {},
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: InkWell(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () {
                              viewModel.goToCreateKeyScreen();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              height: 140,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Iconify(
                                          Ic.baseline_vpn_key,
                                          size: 30,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                        viewModel.local!.createKey,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                            ),
                          )),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: InkWell(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            onTap: () {
                              viewModel.goToGalleryScreen();
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              height: 140,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        height: double.infinity,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: Iconify(
                                          Bi.images,
                                          size: 30,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                      )),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                        viewModel.local!.gallery,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                                fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        viewModel.local!.keysList,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 20),
                      GridView.builder(
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
                      )
                    ],
                  );
                }
              }),
            ),
          ),
        ));
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
