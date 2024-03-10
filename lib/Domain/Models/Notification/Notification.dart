class Notification {

  String id;
  String body;
  List<String> urls;
  String priority;
  DateTime time;


  Notification({
    required this.id ,
    required this.body,
    required this.priority ,
    required this.time ,
    required this.urls
  });

}