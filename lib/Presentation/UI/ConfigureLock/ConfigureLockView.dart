import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/UseCase/AddLockCardUseCase.dart';
import 'package:heimdall/Domain/UseCase/GetUserDataUseCase.dart';
import 'package:heimdall/Presentation/UI/ConfigureLock/ConfigureLockNavigator.dart';
import 'package:heimdall/Presentation/UI/ConfigureLock/ConfigureLockViewModel.dart';
import 'package:provider/provider.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class ConfigureLockView extends StatefulWidget {
  static const String routeName = "ConfigureLock";
  LockCard? card;
  ConfigureLockView({this.card , super.key});
  @override
  State<ConfigureLockView> createState() => _ConfigureLockViewState();
}

class _ConfigureLockViewState
    extends BaseState<ConfigureLockView, ConfigureLockViewModel>
    implements ConfigureLockNavigator {

  @override
  void initState() {
    super.initState();
    if(widget.card != null){
      viewModel.lockId =widget.card!.lockId;
      viewModel.lockAvatar =widget.card!.image;
      viewModel.cardColor = Color(widget.card!.color);
      viewModel.nameController = TextEditingController(text: widget.card!.name);
      viewModel.card = widget.card!;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => viewModel,
        child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                title: Text(viewModel.local!.scanYourLock),
              ),
              body: Consumer<ConfigureLockViewModel>(
                builder: (context, value, child) {
                  if (value.lockId.isEmpty) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            viewModel.local!.configureLockMessage1,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            viewModel.local!.configureLockMessage2,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: viewModel.mediaQuery!.width - 40,
                            height: viewModel.mediaQuery!.width - 40,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: QrCamera(
                                cameraDirection: CameraDirection.BACK,
                                fit: BoxFit.fitWidth,
                                formats: const [BarcodeFormats.QR_CODE],
                                qrCodeCallback: (value) {
                                  viewModel.readLockId(value);
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          // the lock card
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
                            width: viewModel.mediaQuery!.width - 40,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Theme.of(context).primaryColor,
                                      viewModel.cardColor
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                // the lock name
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        viewModel.nameController.text,
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
                                // the lock avatar
                                Image.asset(
                                  viewModel.lockAvatar,
                                  width: double.infinity,
                                  fit: BoxFit.fitWidth,
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          // the name text field
                          TextFormField(
                            style: Theme.of(context).textTheme.bodyLarge,
                            controller: value.nameController,
                            validator: (value) {
                              return viewModel.nameValidation(value ?? "");
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            cursorColor: Theme.of(context).primaryColor,
                            keyboardType: TextInputType.name,
                            cursorHeight: 20,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                EvaIcons.lock,
                                size: 30,
                              ),
                              hintText: value.local!.name,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: ElevatedButton(
                                    onPressed: () {
                                      viewModel.showSelectImageBottomSheet();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        viewModel.local!.pickYourImage,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 3,
                                  child: InkWell(
                                    onTap: () {
                                      viewModel.onColorPickerClick();
                                    },
                                    child: Container(
                                      padding:const EdgeInsets.all(12),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: viewModel.cardColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        viewModel.local!.color,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      viewModel.saveCard();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        viewModel.local!.confirm,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: viewModel.card == null ? 10 : 0,
                              ),
                              viewModel.card == null ?Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      value.readLockId("");
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 2,
                                          color: Theme.of(context).primaryColor
                                        ),
                                        borderRadius: BorderRadius.circular(10)
                                      )),
                                      backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                      foregroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        viewModel.local!.reScan,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ):const SizedBox()
                            ],
                          )
                        ],
                      ),
                    );
                  }
                },
              )),
        ),
      ),
    );
  }

  @override
  ConfigureLockViewModel initViewModel() {
    return ConfigureLockViewModel(
      addLockCardUseCase: injectAddLockCardUseCase(),
      getUserDataUseCase: injectGetUserDataUseCase(),
    );
  }

  @override
  showColorPickerDialog() {
    showDialog(
      context: context,
      builder: (context) =>
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(0),
          content: ColorPicker(
            pickerColor: viewModel.cardColor,
            onColorChanged: (value) => viewModel.changeColor(value),
            displayThumbColor: true,
            hexInputBar: false,
            enableAlpha: false,
            pickerAreaBorderRadius: BorderRadius.circular(20),
          ),
        ),
      ]),
    );
  }
}
