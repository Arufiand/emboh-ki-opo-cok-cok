import 'package:flutter/material.dart';
import '../models/image_model.dart';

class ImageLists extends StatelessWidget {
  final List<ImageModel> images;

  ImageLists(this.images);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, int index) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black
            ),
          ),
          margin: EdgeInsets.all(20.0),
          padding: EdgeInsets.all(20.0),
          child: Image.network(images[index].url),
        );
      },
    );
  }
}
