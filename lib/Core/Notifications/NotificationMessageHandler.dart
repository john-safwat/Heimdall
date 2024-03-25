NotificationMessageHandler injectNotificationMessageHandler() {
  return NotificationMessageHandler.getInstance();
}

class NotificationMessageHandler {

  NotificationMessageHandler._();

  static NotificationMessageHandler? instance;

  static NotificationMessageHandler getInstance() {
    return instance ??= NotificationMessageHandler._();
  }

  String handleNotificationTitleEnglish(String code) {
    if (code == "101") {
      return "Opened by Mobile";
    } else if (code == "102") {
      return "Closed by Mobile";
    } else if (code == "103") {
      return "Opened With E-key";
    } else if (code == "104") {
      return "Correct Password";
    } else if (code == "105") {
      return "Door Locked";
    } else if (code == "106") {
      return "Fingerprint Identified";
    } else if (code == "201") {
      return "Motion Detected";
    } else if (code == "202") {
      return "E-key Warning";
    } else if (code == "301") {
      return "We Captured One";
    } else if (code == "302") {
      return "Caught One";
    } else {
      return "You Know?";
    }
  }

  String handleNotificationBodyEnglish(String code) {

    if (code == "101") {
      return "This lock os Opened using Heimdall Mobile app Successfully";
    } else if (code == "102") {
      return "This lock os Closed using Heimdall Mobile app Successfully";
    } else if (code == "103") {
      return "One of E-keys Given to this lock is Used just now";
    } else if (code == "104") {
      return "The correct password was entered and the door opened";
    } else if (code == "105") {
      return "The door was closed manually";
    } else if (code == "106") {
      return "The door was opened after the fingerprint of one of the owners was correctly identified";
    } else if (code == "201") {
      return "Movement was captured without facial recognition, please be careful";
    } else if (code == "202") {
      return "Someone is trying to use an electronic key at the wrong time";
    } else if (code == "301") {
      return "We've captured pictures of someone approaching your door. You should pay attention";
    } else if (code == "302") {
      return "Someone fell into a Tripwire trap and we have pictures of him";
    } else {
      return "There is Something He Have to Tell You";
    }
  }

  String handleNotificationTitleArabic(String code) {
    if (code == "101") {
      return "فتح بالموبايل" ;
    } else if (code == "102") {
      return "اغلق بالموبايل";
    } else if (code == "103") {
      return "فتح بمفتاح الكتروني";
    } else if (code == "104") {
      return "كلمة مرور صحيحة";
    } else if (code == "105") {
      return "الباب اغلق";
    } else if (code == "106") {
      return "تم التعرف علي البصمة";
    } else if (code == "201") {
      return "التقطت عن الحركة";
    } else if (code == "202") {
      return "تحذير المفتاح الإلكتروني";
    } else if (code == "301") {
      return "لقد قبضنا على واحدة";
    } else if (code == "302") {
      return "امسكت احدهم";
    } else {
      return "هل تعلم؟";
    }
  }

  String handleNotificationBodyArabic(String code) {

    if (code == "101") {
      return "تم فتح نظام القفل هذا باستخدام تطبيق Heimdall Mobile بنجاح" ;
    } else if (code == "102") {
      return "تم إغلاق نظام التشغيل هذا باستخدام تطبيق Heimdall Mobile بنجاح";
    } else if (code == "103") {
      return "أحد المفاتيح الإلكترونية المعطاة لهذا القفل مستخدم الآن";
    } else if (code == "104") {
      return "تم إدخال كلمة المرور الصحيحة وفتح الباب";
    } else if (code == "105") {
      return "تم إغلاق الباب يدويًا";
    } else if (code == "106") {
      return "تم فتح الباب بعد التعرف على بصمة أحد المالكين بشكل صحيح";
    } else if (code == "201") {
      return "تم التقاط الحركة دون التعرف على الوجه، يرجى توخي الحذر";
    } else if (code == "202") {
      return "يحاول شخص ما استخدام مفتاح إلكتروني في الوقت الخطأ";
    } else if (code == "301") {
      return "لقد التقطنا صورًا لشخص يقترب من باب منزلك. يجب عليك الانتباه";
    } else if (code == "302") {
      return "لقد وقع شخص ما في فخ Tripwire ولدينا صور له";
    } else {
      return  "هناك شئ علينا اخبارك به";
    }
  }

}