import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart';

LocalAuthExceptionHandler injectLocalAuthExceptionHandler() {
  return LocalAuthExceptionHandler.getInstance();
}

class LocalAuthExceptionHandler {
  LocalAuthExceptionHandler._();

  static LocalAuthExceptionHandler? instance;

  static getInstance() {
    return instance ??= LocalAuthExceptionHandler._();
  }

  String handleLoginErrorEnglish(PlatformException e) {
    if (e.code == notEnrolled) {
      return "Please Use any Biometric Option to Authenticate";
    } else if (e.code == passcodeNotSet) {
      return "Set Your Phone Password for Safe Authentication";
    } else if (e.code == notAvailable) {
      return "Can't Use Biometric Option to Authenticate";
    } else if (e.code == otherOperatingSystem) {
      return "Your OS is Not Supported for Biometric Authentication";
    } else if (e.code == lockedOut) {
      return "To Many Attempts";
    } else if (e.code == permanentlyLockedOut) {
      return "To Many Attempts You Need to enter Passcode or PIN Number";
    } else if (e.code == biometricOnlyNotSupported) {
      return "Can't Use Biometric Option to Authenticate";
    } else {
      return "Authentication Error";
    }
  }

  String handleLoginErrorArabic(PlatformException e) {
    if (e.code == notEnrolled) {
      return "يرجى استخدام أي خيار بيومتري للمصادقة";
    } else if (e.code == passcodeNotSet) {
      return "قم بتعيين كلمة مرور هاتفك للمصادقة الآمنة";
    } else if (e.code == notAvailable) {
      return "لا يمكن استخدام خيار القياسات الحيوية للمصادقة";
    } else if (e.code == otherOperatingSystem) {
      return "نظام التشغيل لديك غير مدعوم للمصادقة الحيوية";
    } else if (e.code == lockedOut) {
      return "للعديد من المحاولات";
    } else if (e.code == permanentlyLockedOut) {
      return "للعديد من المحاولات تحتاج إلى إدخال رمز المرور أو رقم التعريف الشخصي";
    } else if (e.code == biometricOnlyNotSupported) {
      return "لا يمكن استخدام خيار القياسات الحيوية للمصادقة";
    } else {
      return "خطأ مصادقة";
    }
  }
}
