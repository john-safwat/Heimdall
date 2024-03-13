import 'package:heimdall/Data/Repository/LockRepositoryImpl.dart';
import 'package:heimdall/Data/Repository/LogRepositoryImpl.dart';
import 'package:heimdall/Data/Repository/NotificationsRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Log/Log.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';
import 'package:heimdall/Domain/Repository/LockRepository.dart';
import 'package:heimdall/Domain/Repository/LogRepository.dart';
import 'package:heimdall/Domain/Repository/NotificationsRepository.dart';

ChangeLockStateUseCase injectChangeLockStateUseCase() {
  return ChangeLockStateUseCase(
      lockRepository: injectLockRepository(),
      logRepository: injectLogRepository(),
      notificationsRepository: injectNotificationsRepository());
}

class ChangeLockStateUseCase {
  LockRepository lockRepository;
  LogRepository logRepository;

  NotificationsRepository notificationsRepository;

  ChangeLockStateUseCase(
      {required this.lockRepository,
      required this.notificationsRepository,
      required this.logRepository});

  Future<void> invoke(
      {required bool lockState,
      required Log log,
      required MyNotification notification}) async {
    await lockRepository.changeLockState(lockState: lockState);
    await logRepository.addLog(log: log);
    await notificationsRepository.addNotification(notification: notification);
  }
}
