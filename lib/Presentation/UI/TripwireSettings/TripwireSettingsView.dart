import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/GetTripwireParametersUseCase.dart';
import 'package:heimdall/Presentation/UI/TripwireSettings/TripwireSettingsNavigator.dart';
import 'package:heimdall/Presentation/UI/TripwireSettings/TripwireSettingsViewModel.dart';
import 'package:heimdall/Presentation/UI/TripwireSettings/Widgets/LineWidget.dart';
import 'package:heimdall/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

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
                                        imageBuilder: (context, imageProvider) =>
                                            Stack(
                                          children: [
                                            Image(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                              height: double.infinity,
                                            ),
                                            CustomPaint(
                                              painter: LinePainter(
                                                start: Offset(
                                                    viewModel.x1,
                                                    viewModel.y1),
                                                end: Offset(
                                                    viewModel.x2,
                                                    viewModel.y2),
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                strokeWidth: 5.0,
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
                                              color:
                                                  Theme.of(context).primaryColor,
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
                    Form(
                      key: viewModel.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            viewModel.local!.tripwirePints,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  controller: value.x1PointController,
                                  validator: (value) {
                                    return viewModel
                                        .validateNumberInputForXPoint(
                                            value ?? "");
                                  },
                                  onChanged: (value) {
                                    viewModel.updateLine();
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorColor: Theme.of(context).primaryColor,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorHeight: 20,
                                  decoration: InputDecoration(
                                      hintText: "X1",
                                      label: Text(
                                        "X1",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  controller: value.y1PointController,
                                  validator: (value) {
                                    return viewModel
                                        .validateNumberInputForYPoint(
                                            value ?? "");
                                  },
                                  onChanged: (value) {
                                    viewModel.updateLine();
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorColor: Theme.of(context).primaryColor,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorHeight: 20,
                                  decoration: InputDecoration(
                                      hintText: "Y1",
                                      label: Text(
                                        "Y1",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  controller: value.x2PointController,
                                  validator: (value) {
                                    return viewModel
                                        .validateNumberInputForXPoint(
                                            value ?? "");
                                  },
                                  onChanged: (value) {
                                    viewModel.updateLine();
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorColor: Theme.of(context).primaryColor,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorHeight: 20,
                                  decoration: InputDecoration(
                                      hintText: "X2",
                                      label: Text(
                                        "X2",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      )),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  controller: value.y2PointController,
                                  validator: (value) {
                                    return viewModel
                                        .validateNumberInputForYPoint(
                                            value ?? "");
                                  },
                                  onChanged: (value) {
                                    viewModel.updateLine();
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  cursorColor: Theme.of(context).primaryColor,
                                  keyboardType: TextInputType.emailAddress,
                                  cursorHeight: 20,
                                  decoration: InputDecoration(
                                      hintText: "Y2",
                                      label: Text(
                                        "Y2",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  TripwireSettingsViewModel initViewModel() {
    return TripwireSettingsViewModel(
        lockCard: widget.lockCard!,
        getTripwireImageAndStateUseCase: injectGetTripwireParametersUseCase());
  }
}
