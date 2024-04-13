import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:heimdall/Domain/UseCase/CreateKeyUseCase.dart';
import 'package:heimdall/Domain/UseCase/DeleteKeyUseCase.dart';
import 'package:heimdall/Domain/UseCase/GetUserDataUseCase.dart';
import 'package:heimdall/Domain/UseCase/UpdateKeyUseCase.dart';
import 'package:heimdall/Presentation/UI/CreateKey/ManageKeyNavigator.dart';
import 'package:heimdall/Presentation/UI/CreateKey/ManageKeyViewModel.dart';
import 'package:heimdall/Presentation/UI/CreateKey/Widgets/DateWidget.dart';
import 'package:heimdall/Presentation/UI/CreateKey/Widgets/TimeWidget.dart';
import 'package:heimdall/Presentation/UI/CreateKey/Widgets/TypeButtonWidget.dart';
import 'package:heimdall/Presentation/UI/Widgets/ErrorMessageWidget.dart';
import 'package:heimdall/Presentation/UI/Widgets/UserCardWidget.dart';
import 'package:provider/provider.dart';
import 'package:time_range_picker/time_range_picker.dart';

class ManageKeyView extends StatefulWidget {
  static const String routeName = "CreateKy";
  LockCard? lockCard;
  EKey? eKey;

  ManageKeyView({this.lockCard, this.eKey, super.key});

  @override
  State<ManageKeyView> createState() => _ManageKeyViewState();
}

class _ManageKeyViewState extends BaseState<ManageKeyView, ManageKeyViewModel>
    implements ManageKeyNavigator {
  @override
  void initState() {
    super.initState();
    if (widget.eKey != null) {
      viewModel.key = widget.eKey;
      viewModel.validOnce = viewModel.key!.validOnce!;
      viewModel.singleDate = viewModel.key!.startDate!;
      viewModel.rangeDate = DateTimeRange(
          start: viewModel.key!.startDate!, end: viewModel.key!.endDate!);
      viewModel.rangeTime = TimeRange(
          startTime: viewModel.key!.startTime!,
          endTime: viewModel.key!.endTime!);
      viewModel.selectedDays = viewModel.key!.days!;
      viewModel.loadUserData();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Scaffold(
            appBar: AppBar(
              title: Text(viewModel.local!.createKey),
            ),
            body:
                Consumer<ManageKeyViewModel>(builder: (context, value, child) {
              if (value.errorMessage != null) {
                return ErrorMessageWidget(
                    errorMessage: value.errorMessage!,
                    fixErrorFunction: value.loadUserData);
              } else if (value.user == null && value.key != null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
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
                    if (viewModel.key == null) ...[
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyLarge,
                        controller: value.emailController,
                        validator: (value) {
                          return viewModel.emailValidation(value ?? "");
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    ] else ...[
                      Text(
                        viewModel.local!.user,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 20),
                      UserCardWidget(user: viewModel.user!),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => viewModel.updateKey(),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            viewModel.local!.updateKey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => viewModel.onDeleteButtonPress(),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(MyTheme.red),
                            foregroundColor:
                                MaterialStateProperty.all(MyTheme.white)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            viewModel.local!.deleteKey,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    Text(
                      viewModel.local!.createKeyWarningMessage,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }
            })));
  }

  @override
  ManageKeyViewModel initViewModel() {
    return ManageKeyViewModel(
        createKeyUseCase: injectCreateKeyUseCase(),
        getUserDataUseCase: injectGetUserDataUseCase(),
        updateKeyUseCase: injectUpdateKeyUseCase(),
        deleteKeyUseCase: injectDeleteKeyUseCase(),
        lockCard: widget.lockCard!);
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
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate:viewModel.key != null? selectedDate.start : DateTime.now(),
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
      selectedColor: Theme.of(context).secondaryHeaderColor,
      autoAdjustLabels: true,
      labelStyle: Theme.of(context)
          .textTheme
          .titleLarge!
          .copyWith(color: Theme.of(context).scaffoldBackgroundColor),
    );
    return time ?? selectedTime;
  }
}
