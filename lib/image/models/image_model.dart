class ImageModel{
  int id = 0;
  String url = "";
  String title = "";

  ImageModel(this.id, this.title, this.url);

  ImageModel.parseJson(Map <String, dynamic> parsed){
    id = parsed['id'];
    url = parsed['url'];
    title = parsed['title'];
  }

//   Alternative
//   ImageModel.parseJsonAlternative(Map<String, dynamic> parsed)
//     : id = parsed['id'],
//     url = parsed['url'],
//     title = parsed['title']
}