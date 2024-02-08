class Card {
  String cardId;
  String lockId;
  String modelId;
  int color;
  String name;

  String image;

  Card(
      {required this.image,
      required this.name,
      required this.color,
      required this.lockId,
      required this.cardId,
      required this.modelId});
}
