class CommentModel {
  String? comment;
  String? commenterImage;
  String? commenterName;

  CommentModel({this.comment, this.commenterImage, this.commenterName});

  CommentModel.fromJson(Map<String, dynamic> json)
  {
    comment = json['comment'];
    commenterImage = json['commenterImage'];
    commenterName = json['commenterName'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['comment'] = comment;
    data['commenterImage'] = commenterImage;
    data['commenterName'] = commenterName;
    return data;
  }
}
