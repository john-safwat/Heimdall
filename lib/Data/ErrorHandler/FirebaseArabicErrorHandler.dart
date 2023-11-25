
// dependency injection
FirebaseArabicErrorHandler injectFirebaseArabicErrorHandler(){
  return FirebaseArabicErrorHandler.getInstance();
}

class FirebaseArabicErrorHandler {

  // singleton pattern
  FirebaseArabicErrorHandler._();
  static FirebaseArabicErrorHandler? _instance;
  static FirebaseArabicErrorHandler getInstance(){
    return _instance??=FirebaseArabicErrorHandler._();
  }

  String handleFirebaseImageDatabaseExceptions({required String error}) {
    switch (error) {
      case "storage/unknown":
        error = "التخزين/غير معروف";
        break;
      case "storage/object-not-found":
        error = "التخزين/الكائن غير موجود";
        break;
      case "storage/bucket-not-found":
        error = "لم يتم تكوين أي حاوية للتخزين السحابي";
        break;
      case "storage/project-not-found":
        error = "لم يتم تكوين أي مشروع للتخزين السحابي";
        break;
      case "storage/quota-exceeded":
        error = "لقد تم تجاوز الحصة المخصصة لحاوية التخزين السحابي الخاصة بك. إذا كنت في المستوى المجاني، قم بالترقية إلى الخطة المدفوعة. إذا كنت تستخدم خطة مدفوعة، فاتصل بدعم Firebase.";
        break;
      case "storage/unauthenticated":
        error = "لم يتم التحقق من المستخدم، يرجى التحقق والمحاولة مرة أخرى.";
        break;
      case "storage/unauthorized":
        error = "المستخدم غير مصرح له بتنفيذ الإجراء المطلوب، تحقق من قواعد الأمان الخاصة بك للتأكد من صحتها.";
        break;
      case "storage/retry-limit-exceeded":
        error = "تم تجاوز الحد الأقصى للوقت المحدد للعملية (التحميل، التنزيل، الحذف، وما إلى ذلك). حاول التحميل مرة أخرى.";
        break;
      case "storage/invalid-checksum":
        error = "الملف الموجود على العميل لا يتطابق مع المجموع الاختباري للملف الذي يتلقاه الخادم. حاول التحميل مرة أخرى.";
        break;
      case "storage/canceled":
        error = "ألغى المستخدم العملية.";
        break;
      case "storage/invalid-event-name":
        error = "تم تقديم اسم حدث غير صالح. يجب أن يكون واحدًا من [التشغيل، التقدم، الإيقاف المؤقت]";
        break;
      case "storage/invalid-url":
        error = "تم تقديم عنوان URL غير صالح إلى refFromURL(). يجب أن يكون بالشكل: gs://bucket/object أو https://firebasestorage.googleapis.com/v0/b/bucket/o/object?token=<TOKEN>";
        break;
      case "storage/invalid-argument":
        error = "يجب أن تكون الوسيطة التي تم تمريرها إلى put() هي File أو Blob أو UInt8 Array. يجب أن تكون الوسيطة التي تم تمريرها إلى putString() عبارة عن سلسلة خام أو Base64 أو Base64URL.";
        break;
      case "storage/no-default-bucket":
        error = "لم يتم تعيين أي حاوية في خاصية StorageBucket الخاصة بالتكوين الخاص بك.";
        break;
      case "storage/cannot-slice-blob":
        error = "يحدث هذا عادةً عند تغيير الملف المحلي (حذفه أو حفظه مرة أخرى وما إلى ذلك). حاول التحميل مرة أخرى بعد التأكد من عدم تغيير الملف.";
        break;
      case "storage/server-file-wrong-size":
        error = "الملف الموجود على العميل لا يتطابق مع حجم الملف الذي يتلقاه الخادم. حاول التحميل مرة أخرى.";
        break;
      default:
        error = "خطاء في الاتصال بالخادم";
    }
    return error;
  }

  String handleFirebaseAuthException({required String error}){
    switch (error) {
      case "error_invalid_email":
        error = "عنوان البريد الإلكتروني غير صالح";
        break;
      case "error_too_many_requests":
        error = "للعديد من الطلبات";
        break;
      case "error_operation_not_allowed":
        error = "لا يمكن إنشاء حساب الآن حاول مرة أخرى لاحقًا";
        break;
      case "email-already-in-use":
        error = "البريد الاليكتروني قيد الاستخدام";
        break;
      default:
        error = "خطاء في الاتصال بالخادم";
    }
    return error;
  }

  String handleLoginError(String error){
    switch (error) {
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        error = "مزيج خاطئ من البريد الإلكتروني/كلمة المرور.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        error = "لم يتم العثور على مستخدم مع هذا البريد الإلكتروني.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        error = "تم تعطيل المستخدم.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        error = "هناك طلبات كثيرة جدًا لتسجيل الدخول إلى هذا الحساب.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        error = "عنوان البريد الإلكتروني غير صالح.";
        break;
      default:
        error = "فشل تسجيل الدخول. حاول مرة اخرى.";
        break;
    }
    return error;
  }

  String handleFirebaseFireStoreError(String error){
    switch (error) {
      case "ABORTED":
        error = "تم إحباط العملية، عادةً بسبب مشكلة في التزامن مثل إحباط المعاملة، وما إلى ذلك.";
        break;
      case "ALREADY_EXISTS":
        error = "بعض المستندات التي حاولنا إنشاءها موجودة بالفعل.";
        break;
      case "CANCELLED":
        error = "تم إلغاء العملية (عادةً بواسطة المتصل).";
        break;
      case "DATA_LOSS":
        error = 'فقدان البيانات أو تلفها بشكل غير قابل للاسترداد.';
        break;
      case "DEADLINE_EXCEEDED":
        error = "انتهى الموعد النهائي قبل أن تكتمل العملية.";
        break;
      case "FAILED_PRECONDITION":
        error = "تم رفض العملية لأن النظام ليس في الحالة المطلوبة لتنفيذ العملية.";
        break;
      case "INTERNAL":
        error = "الأخطاء الداخلية.";
        break;
      case "INVALID_ARGUMENT":
        error = "حدد العميل وسيطة غير صالحة.";
        break;
      case "NOT_FOUND":
        error = "لم يتم العثور على بعض المستندات المطلوبة.";
        break;
      case "OK":
        error = "تمت العملية بنجاح.";
        break;
      case "OUT_OF_RANGE":
        error = "تمت محاولة العملية بعد النطاق الصالح.";
        break;
      case "PERMISSION_DENIED":
        error = "المتصل ليس لديه الإذن بتنفيذ العملية المحددة.";
        break;
      case "RESOURCE_EXHAUSTED":
        error = "تم استنفاد بعض الموارد، ربما تكون الحصة النسبية لكل مستخدم، أو ربما نفدت مساحة نظام الملفات بأكمله.";
        break;
      case "UNAUTHENTICATED":
        error = "لا يحتوي الطلب على بيانات اعتماد مصادقة صالحة للعملية.";
        break;
      case "UNAVAILABLE":
        error = "الخدمة غير متوفرة حاليا.";
        break;
      case "UNIMPLEMENTED":
        error = "لم يتم تنفيذ العملية أو أنها غير مدعومة/ممكّنة.";
        break;
      case "UNKNOWN":
        error = "خطأ غير معروف أو خطأ من مجال خطأ مختلف.";
        break;
      default:
        error = "هناك خطأ ما";
        break;
    }
    return error;
  }

}