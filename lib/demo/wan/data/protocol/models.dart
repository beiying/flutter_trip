class ComData {
  int size;
  List datas;
  ComData.fromJson(Map<String, dynamic> json) : size = json["size"], datas = json["datas"];
}

class BannerModel {
  String title;
  int id;
  String url;
  String imagePath;

  BannerModel.fromJson(Map<String, dynamic> json)
    : title = json["title"],
    id = json["id"],
    url = json["url"],
    imagePath = json["imagePath"];

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
    "url": url,
    "imagePath": imagePath,
  };

  @override
  String toString() {
    StringBuffer sb = StringBuffer("{");
    sb.write("\"title\":\"$title\"");
    sb.write("\"id\":\"$id\"");
    sb.write("\"url\":\"$url\"");
    sb.write("\"imagePath\":\"$imagePath\"");
    return sb.toString();
  }
}