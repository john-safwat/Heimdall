import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/GetTripwireParametersUseCase.dart';
import 'package:heimdall/Domain/UseCase/UpdateRequestImageStateUseCase.dart';
import 'package:heimdall/Domain/UseCase/UpdateTripwireParametersUseCase.dart';
import 'package:heimdall/Presentation/UI/TripwireSettings/TripwireSettingsNavigator.dart';
import 'package:heimdall/Presentation/UI/TripwireSettings/TripwireSettingsViewModel.dart';
import 'package:heimdall/Presentation/UI/TripwireSettings/Widgets/LineWidget.dart';
import 'package:heimdall/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/material_symbols.dart';
import 'package:iconify_flutter_plus/icons/zondicons.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wheel_slider/wheel_slider.dart';

class TripwireSettingsView extends StatefulWidget {
  static const String routeName = "TripwireSettings";

  LockCard? lockCard;

  TripwireSettingsView({this.lockCard, super.key});

  @override
  State<TripwireSettingsView> createState() => _TripwireSettingsViewState();
}

class _TripwireSettingsViewState
    extends BaseState<TripwireSettingsView, TripwireSettingsViewModel>
    implements TripwireSettingsNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.loadParameters();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(viewModel.local!.tripwire),
          ),
          body: Consumer<TripwireSettingsViewModel>(
            builder: (context, value, child) {
              if (viewModel.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (viewModel.errorMessage != null) {
                return ErrorMessageWidget(
                    errorMessage: viewModel.errorMessage!,
                    fixErrorFunction: viewModel.loadParameters);
              } else {
                return ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 220,
                        child: Row(
                          children: [
                            Expanded(
                                child: viewModel.state
                                    ? Container(
                                        height: 220,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color:
                                                Theme.of(context).primaryColor),
                                        child: Lottie.asset(
                                            value.getImageEmptyAnimation()),
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: viewModel.imageUrl,
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,
                                        imageBuilder:
                                            (context, imageProvider) => Stack(
                                          children: [
                                            Image(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                              height: double.infinity,
                                            ),
                                            CustomPaint(
                                              painter: LinePainter(
                                                start: Offset(
                                                    viewModel.x1, viewModel.y1),
                                                end: Offset(
                                                    viewModel.x2, viewModel.y2),
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                strokeWidth: 5.0,
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.all(10),
                                              alignment: Alignment.bottomRight,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  viewModel.requestNewImage();
                                                },
                                                child: Iconify(
                                                  MaterialSymbols
                                                      .autorenew_rounded,
                                                  color: Theme.of(context)
                                                      .scaffoldBackgroundColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Icon(
                                            Icons.image,
                                            size: 45,
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                          ),
                                        ),
                                      )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          viewModel.local!.tripwirePints,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(width: 1 , color: Theme.of(context).primaryColor)
                              ),
                              child: Column(
                                children: [
                                  Text("X1" , style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: WheelSlider.number(
                                          interval: 1,
                                          // this field is used to show decimal/double values
                                          totalCount: 640,
                                          initValue: viewModel.x1.toInt(),
                                          onValueChanged: (val) {
                                            viewModel.updateX1(val as int);
                                          },
                                          allowPointerTappable: true,
                                          currentIndex: viewModel.x1,
                                          showPointer: true,
                                          customPointer: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Theme.of(context).primaryColor),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                              ),
                                            ],
                                          ),
                                          unSelectedNumberStyle: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                              color: Theme.of(context).secondaryHeaderColor),
                                          selectedNumberStyle: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(width: 1 , color: Theme.of(context).primaryColor)
                              ),
                              child: Column(
                                children: [
                                  Text("Y1" , style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: WheelSlider.number(
                                          interval: 1,
                                          // this field is used to show decimal/double values
                                          totalCount: 360,
                                          initValue: viewModel.y1.toInt(),
                                          onValueChanged: (val) {
                                            viewModel.updateY1(val as int);
                                          },
                                          allowPointerTappable: true,
                                          currentIndex: viewModel.y1,
                                          showPointer: true,
                                          customPointer: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Theme.of(context).primaryColor),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                              ),
                                            ],
                                          ),
                                          unSelectedNumberStyle: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                              color: Theme.of(context).secondaryHeaderColor),
                                          selectedNumberStyle: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(width: 1 , color: Theme.of(context).primaryColor)
                              ),
                              child: Column(
                                children: [
                                  Text("X2" , style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: WheelSlider.number(
                                          interval: 1,
                                          // this field is used to show decimal/double values
                                          totalCount: 640,
                                          initValue: viewModel.x2.toInt(),
                                          onValueChanged: (val) {
                                            viewModel.updateX2(val as int);
                                          },
                                          allowPointerTappable: true,
                                          currentIndex: viewModel.x2,
                                          showPointer: true,
                                          customPointer: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Theme.of(context).primaryColor),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                              ),
                                            ],
                                          ),
                                          unSelectedNumberStyle: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                              color: Theme.of(context).secondaryHeaderColor),
                                          selectedNumberStyle: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(width: 1 , color: Theme.of(context).primaryColor)
                              ),
                              child: Column(
                                children: [
                                  Text("Y2" , style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: WheelSlider.number(
                                          interval: 1,
                                          // this field is used to show decimal/double values
                                          totalCount: 360,
                                          initValue: viewModel.y2.toInt(),
                                          onValueChanged: (val) {
                                            viewModel.updateY2(val as int);
                                          },
                                          allowPointerTappable: true,
                                          currentIndex: viewModel.y2,
                                          showPointer: true,
                                          customPointer: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Theme.of(context).primaryColor),
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                              ),
                                            ],
                                          ),
                                          unSelectedNumberStyle: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                              color: Theme.of(context).secondaryHeaderColor),
                                          selectedNumberStyle: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          viewModel.local!.timer,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(width: 1 , color: Theme.of(context).primaryColor)
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: WheelSlider.number(
                                  interval: 0.5,
                                  // this field is used to show decimal/double values
                                  totalCount: 100,
                                  initValue: viewModel.timer,
                                  onValueChanged: (val) {
                                    viewModel.updateTimer(val as double);
                                  },
                                  allowPointerTappable: true,
                                  currentIndex: viewModel.timer,
                                  showPointer: true,
                                  customPointer: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Theme.of(context).primaryColor),
                                            borderRadius: BorderRadius.circular(10)
                                        ),
                                      ),
                                    ],
                                  ),
                                  unSelectedNumberStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                      color: Theme.of(context).secondaryHeaderColor),
                                  selectedNumberStyle: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          viewModel.local!.timerInfo,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: (){
                            viewModel.updateParameters();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(viewModel.local!.confirm),
                              ],
                            ),
                          )
                        )
                      ],
                    ),
                  ],
                );
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              viewModel.loadParameters();
            },
            child: Iconify(
              Zondicons.reload,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
      ),
    );
  }

  @override
  TripwireSettingsViewModel initViewModel() {
    return TripwireSettingsViewModel(
        lockCard: widget.lockCard!,
        getTripwireImageAndStateUseCase: injectGetTripwireParametersUseCase(),
        updateRequestImageStateUseCase: injectUpdateRequestImageStateUseCase(),
        updateTripwireParametersUseCase: injectUpdateTripwireParametersUseCase()
    );
  }
}
