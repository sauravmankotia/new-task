class DbModel {
  int? id;
  String? title;
  String? dateTimeCreated;

  DbModel({
    this.id, this.title,this.dateTimeCreated
  });

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "title": this.title,
      "dateTimeCreated": this.dateTimeCreated,
    };
  }
}
