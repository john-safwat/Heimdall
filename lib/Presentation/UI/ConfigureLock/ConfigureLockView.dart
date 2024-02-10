import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/ConfigureLock/ConfigureLockNavigator.dart';
import 'package:heimdall/Presentation/UI/ConfigureLock/ConfigureLockViewModel.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

class ConfigureLockView extends StatefulWidget {
  static const String routeName = "ConfigureLock";

  const ConfigureLockView({super.key});

  @override
  State<ConfigureLockView> createState() => _ConfigureLockViewState();
}

class _ConfigureLockViewState
    extends BaseState<ConfigureLockView, ConfigureLockViewModel>
    implements ConfigureLockNavigator {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => viewModel,
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // the lock card
                        Stack(
                          children: [
                            // background of the card
                            Container(
                              width: viewModel.mediaQuery!.width - 40,
                              height: viewModel.mediaQuery!.height * 0.6,
                              decoration: BoxDecoration(
                                  color: viewModel.cardColor,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            // the gradient with the lock name and image
                            Positioned.fill(
                                child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 30),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).primaryColor,
                                        Colors.transparent
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight)),
                              child: Column(
                                children: [
                                  // the lock name
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          viewModel.nameController.text,
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
                                  // the lock avatar
                                  Expanded(
                                    child: Image.asset(
                                      "assets/avatars/avatar${viewModel.lockAvatar}.png",
                                      width: double.infinity,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  )
                                ],
                              ),
                            ))
                          ],
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
                              flex: 5,
                              child: ElevatedButton(
                                  onPressed: () {
                                    viewModel.showSelectImageBottomSheet();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      viewModel.local!.pickYourImage,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                            const SizedBox(width: 20,),
                            Expanded(
                                flex : 3 ,
                                child: InkWell(
                                  onTap: (){
                                    viewModel.onColorPickerClick();
                                  },
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: viewModel.cardColor,
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                  );
                }
              },
            )),
      ),
    );
  }

  @override
  bool isMounted() {
    return mounted;
  }

  @override
  ConfigureLockViewModel initViewModel() {
    return ConfigureLockViewModel();
  }

  @override
  showColorPickerDialog() {
    showDialog(
        context: context,
        builder: (context) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            AlertDialog(
              titlePadding: const EdgeInsets.all(0),
              contentPadding: const EdgeInsets.all(0),
              content: ColorPicker(
                pickerColor: viewModel.cardColor,
                onColorChanged: (value) => viewModel.changeColor(value),

              ),
            ),
          ]
        ),
    );
  }
}
