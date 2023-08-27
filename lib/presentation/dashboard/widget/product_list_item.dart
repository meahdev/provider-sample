
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem(
      {required this.title, required this.price, required this.image, Key? key})
      : super(key: key);
  final String title;
  final String price;
  final String image;

  @override
  Widget build(BuildContext context) {
    return _buildCard();
  }

  Card _buildCard() {
    return Card(
      elevation: 2,
      child: buildColumn()
    );
  }

   buildColumn() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5.0, top: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildImage(image),
          buildSizedBox(height: 5),
          buildText(name: title, fontSize: 14.5),
          buildSizedBox(height: 5),
          buildText(
              name: "\$$price", fontWeight: FontWeight.w500, fontSize: 13.5),
        ],
      ),
    );
  }

  buildText({required name, FontWeight? fontWeight, double? fontSize}) {
    return Text(
      name,
      style: GoogleFonts.roboto(fontWeight: fontWeight, fontSize: fontSize),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  SizedBox buildSizedBox({double? height, double? width}) {
    return SizedBox(
      height: height ?? 0.0,
      width: width ?? 0.0,
    );
  }

  buildImage(String imgUrl) {
    return Center(
      child: CachedNetworkImage(
          width: 130,
          height: 130,
          imageUrl: imgUrl,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.contain,
              ),
            ),
          ),
          placeholder: (context, url) => Container(
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: const SizedBox(
                  width: 20.0,
                  height: 20.0,
                  child: Icon(Icons.image_not_supported))),
          errorWidget: (context, url, error) =>
          const Icon(Icons.image_not_supported)),
    );
  }
}