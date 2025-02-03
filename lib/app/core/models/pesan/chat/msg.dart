class MsgModel {
  String category;
  String msg;
  String sender;
  //in case if its media
  String? caption;
  String? type;
  String? image;

  MsgModel({
    required this.category,
    required this.msg,
    required this.sender,
    //in case if its media
    this.caption,
    this.type,
    this.image,
  });
}
