import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:knows/constant.dart';

class DetailsScren extends StatelessWidget {

   DetailsScren(
      {Key? key,
      required this.title,
      required this.content,
      required this.imageUrl,
      required this.author,
      required this.readMore})
      : super(key: key);

  String title;
  String content;
  String imageUrl;
  String author;
  String readMore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBasic,
        title: Row(children:  [
          Align(
              alignment: Alignment.topLeft,
              child: DefaultTextStyle(
                style: const TextStyle(fontSize: 30, color: Colors.white),
                child: Text(author),
              )),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              height: 5,
              color: Colors.white,
            ),
          ),
        ]),
      ),
      backgroundColor: kBasic,
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                height: 300,
                width: double.infinity,
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 300,
                  child: FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(imageUrl),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 20,
                child: BlurryContainer(
                    elevation: 10,
                    blur: 3,
                    borderRadius: BorderRadius.circular(20),
                    child: Text(author)),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.only(left: 18, right: 18, top: 10),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 18, left: 18, top: 20),
            child: Divider(
              height: 8,
              color: Colors.white,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(18),
            child: Text(
              content,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ]),
      ),
    );
  }
}
