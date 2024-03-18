import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/CreateKeyUseCase.dart';
import 'package:heimdall/Presentation/UI/CreateKey/CreateKeyNavigator.dart';
import 'package:heimdall/Presentation/UI/CreateKey/CreateKeyViewModel.dart';
import 'package:heimdall/Presentation/UI/CreateKey/Widgets/DateWidget.dart';
import 'package:heimdall/Presentation/UI/CreateKey/Widgets/TimeWidget.dart';
import 'package:heimdall/Presentation/UI/CreateKey/Widgets/TypeButtonWidget.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:time_range_picker/time_range_picker.dart';

class CreateKeyView extends StatefulWidget {
  static const String routeName = "CreateKy";
  LockCard? lockCard;

  CreateKeyView({this.lockCard, super.key});

  @override
  State<CreateKeyView> createState() => _CreateKeyViewState();
}

class _CreateKeyViewState extends BaseState<CreateKeyView, CreateKeyViewModel>
    implements CreateKeyNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<CreateKeyViewModel>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text(viewModel.local!.createKey),
          ),
          body: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              Text(
                viewModel.local!.createKeyMessage,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    const Expanded(child: Divider()),
                    const SizedBox(width: 20),
                    Text(
                      viewModel.local!.validIn,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(width: 20),
                    const Expanded(child: Divider()),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  TypeButtonWidget(
                    selected: viewModel.validOnce,
                    title: viewModel.local!.once,
                    id: 1,
                    onPress: viewModel.onTypeButtonPress,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TypeButtonWidget(
                    selected: !viewModel.validOnce,
                    title: viewModel.local!.repeated,
                    id: 2,
                    onPress: viewModel.onTypeButtonPress,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                viewModel.local!.date,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              const DateWidget(),
              const SizedBox(height: 20),
              Text(
                viewModel.local!.time,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              const TimeWidget(),
              const SizedBox(height: 30),
              // the text from field for the email
              TextFormField(
                style: Theme.of(context).textTheme.bodyLarge,
                controller: value.emailController,
                validator: (value) {
                  return viewModel
                      .emailValidation(value ?? "");
                },
                autovalidateMode:
                AutovalidateMode.onUserInteraction,
                cursorColor: Theme.of(context).primaryColor,
                keyboardType: TextInputType.emailAddress,
                cursorHeight: 20,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    EvaIcons.email,
                    size: 30,
                  ),
                  hintText: value.local!.email,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () => viewModel.createKey(),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      viewModel.local!.createKey,
                    ),
                  ),
              ),
              const SizedBox(height: 20),
              Text(
                viewModel.local!.createKeyWarningMessage,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  CreateKeyViewModel initViewModel() {
    return CreateKeyViewModel(
      createKeyUseCase: injectCreateKeyUseCase(),
      lockCard: widget.lockCard!
    );
  }

  @override
  Future<DateTime> showDatePiker(DateTime selectedDate) async {
    DateTime? date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
      barrierDismissible: false,
      currentDate: selectedDate,
    );
    return date ?? selectedDate;
  }

  @override
  Future<DateTimeRange> showRangeDatePiker(DateTimeRange selectedDate) async {
    DateTimeRange? date = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1),
        barrierDismissible: false,
        initialDateRange: selectedDate);
    return date ?? selectedDate;
  }

  @override
  Future<TimeRange> showRangeTimePiker(TimeRange selectedTime) async {
    TimeRange? time = await showTimeRangePicker(
      context: context,
      start: selectedTime.startTime,
      end: selectedTime.endTime,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      activeTimeTextStyle: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
      barrierDismissible: false,
      use24HourFormat: false,
      timeTextStyle: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
      snap: false,
      rotateLabels: true,
      selectedColor:Theme.of(context).secondaryHeaderColor ,

      autoAdjustLabels: true,
      labelStyle: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
    );
    return time ?? selectedTime;
  }
}
