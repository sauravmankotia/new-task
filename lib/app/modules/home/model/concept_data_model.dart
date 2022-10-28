class ConceptModelClass {
  String? subtitle;
  bool? isChildSelected;

  ConceptModelClass({this.subtitle, this.isChildSelected});

  ConceptModelClass.fromJson(Map<String, dynamic> json) {
    subtitle = json['subtitle'];
    isChildSelected = json['isChildSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subtitle'] = this.subtitle;
    data['isChildSelected'] = this.isChildSelected;
    return data;
  }
}