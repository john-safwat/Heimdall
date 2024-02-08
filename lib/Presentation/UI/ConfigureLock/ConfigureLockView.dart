import 'package:flutter/material.dart';
import 'package:heimdall/Core/Base/BaseState.dart';
import 'package:heimdall/Presentation/UI/ConfigureLock/ConfigureLockNavigator.dart';
import 'package:heimdall/Presentation/UI/ConfigureLock/ConfigureLockViewModel.dart';
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
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                width: viewModel.mediaQuery!.width - 40,
                                decoration: BoxDecoration(
                                  color: viewModel.cardColor,
                                  borderRadius: BorderRadius.circular(20)
                                ),
                              ),
                              Positioned(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).primaryColor,
                                        Colors.transparent
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight
                                    )
                                  ),
                                )
                              )
                            ],
                          ),
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
}
