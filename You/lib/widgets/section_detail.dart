import 'package:flutter/material.dart';
import 'package:you/ui/detail.dart';

import 'sections.dart';

// Display a single SectionDetail.
class SectionDetailView extends StatelessWidget {
  const SectionDetailView({Key? key, required this.detail}) : super(key: key);

  final SectionDetail detail;

  @override
  Widget build(BuildContext context) {
    final Widget image = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        image: DecorationImage(
          image: AssetImage(
            detail.imageAsset,
          ),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
    );

    Widget item;
    if (detail.title == null && detail.subtitle == null) {
      item = Container(
        height: 240.0,
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          top: false,
          bottom: false,
          child: image,
        ),
      );
    } else {
      var imageType;
      imageType = detail.imageAsset;
      item = ListTile(
        onTap: () {
          if (imageType == 'assets/image/google.jpg') {
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => Detail(
                  imageType: "google",
                      url: detail.url!,
                    )));
          } else if (imageType == 'assets/image/facebook.png') {
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => Detail(
                  imageType: "fb",
                      url: detail.url!,
                    )));
          } else if (imageType == 'assets/image/instagram.jpeg') {
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) => Detail(
                  imageType: "insta",
                      url: detail.url!,
                    )));
          } else if (imageType == 'assets/image/twitter.jpg') {
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (_, __, ___) =>
                    Detail(imageType: "twitter", url: detail.url!)));
          }
        },
        title: Text(
          detail.title!,
          style: const TextStyle(fontSize: 18.0),
        ),
        subtitle: Text(
          detail.subtitle!,
          style: const TextStyle(color: Colors.purple, fontSize: 15.0),
        ),
        leading: SizedBox(width: 40.0, height: 40.0, child: image),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.grey.shade200),
      child: item,
    );
  }
}
