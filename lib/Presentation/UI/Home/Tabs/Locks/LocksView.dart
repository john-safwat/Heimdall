import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/GetLocksCarsUseCase.dart';
import 'package:heimdall/Presentation/UI/ConfigureLock/ConfigureLockView.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Locks/LocksNavigator.dart';
import 'package:heimdall/Presentation/UI/Home/Tabs/Locks/LocksViewModel.dart';
import 'package:heimdall/Presentation/UI/LockDetails/LockDetailsView.dart';
import 'package:heimdall/Presentation/UI/Widgets/LockCardWidget.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LocksView extends StatefulWidget {
  const LocksView({super.key});

  @override
  State<LocksView> createState() => _LocksViewState();
}

class _LocksViewState extends BaseState<LocksView, LocksViewModel>
    implements LocksNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.loadCardsData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          body: RefreshIndicator(
            backgroundColor: Theme.of(context).primaryColor,
            key: viewModel.refreshIndicatorKey,
            color: Theme.of(context).scaffoldBackgroundColor,
            onRefresh: () async {
              return viewModel.loadCardsData();
            },
            child: Column(
              children: [
                Expanded(child: Consumer<LocksViewModel>(
                  builder: (context, value, child) {
                    if (value.errorMessage != null) {
                      return Column(
                        children: [
                          const Row(),
                          Text(
                            viewModel.errorMessage!,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                viewModel.loadCardsData();
                              },
                              child: Text(viewModel.local!.tryAgain))
                        ],
                      );
                    } else if (viewModel.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (viewModel.lockCardsList.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(child: Lottie.asset(viewModel.getAnimation())),
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Text(
                                viewModel.local!.empty,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  Text(
                                    "${viewModel.local!.welcomeBack} "
                                    "${viewModel.appConfigProvider?.user?.displayName?.split(" ").first}"
                                    " 😊",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    viewModel
                                        .local!.weAreWatchingEveryThingForYou,
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const SizedBox(height: 25),
                                  TextFormField(
                                    style: Theme.of(context).textTheme.bodyLarge,
                                    controller: viewModel.searchController,
                                    cursorColor: Theme.of(context).primaryColor,
                                    keyboardType: TextInputType.text,
                                    cursorHeight: 20,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        EvaIcons.search,
                                        size: 30,
                                      ),
                                      hintText: viewModel.local!.search,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                    animateToClosest: false,
                                    height: 500,
                                    viewportFraction: 0.85,
                                    initialPage: 0,
                                    enableInfiniteScroll: true,
                                    enlargeCenterPage: true,
                                    enlargeStrategy:
                                        CenterPageEnlargeStrategy.height),
                                items: viewModel.lockCardsList
                                    .map((e) => LockCardWidget(
                                        card: e,
                                        onCardClick: viewModel.onLockCardPress))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ))
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              viewModel.goToConfigureLocScreen();
            },
            child: const Icon(Bootstrap.qr_code_scan),
          ),
        ),
      ),
    );
  }

  @override
  LocksViewModel initViewModel() {
    return LocksViewModel(getLocksCarsUseCase: injectGetLocksCarsUseCase());
  }

  @override
  goToConfigureLockScreen() {
    Navigator.pushNamed(context, ConfigureLockView.routeName);
  }

  @override
  goToLockDetailsScreen(LockCard lockCard) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LockDetailsView(lockCard: lockCard)));
  }
}
