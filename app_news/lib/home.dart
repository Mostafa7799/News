import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:knows/constant.dart';
import 'package:knows/models/apiservices.dart';
import 'package:knows/readcategory.dart';
import 'package:knows/readpage.dart';

List<String> category = [
  'technology',
  'science',
  'national',
  'business',
  'sports',
  'world',
  'politics',
  'startup',
  'entertainment',
  'miscellaneous',
  'automobile',
  'all',
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int newsCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(color: kBasic),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 55,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      padding: const EdgeInsets.only(top: 3, right: 11),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: kCard),
                      child: Center(
                        child: Row(children: [
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: GestureDetector(
                              onDoubleTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReadCategory(
                                          categoryName: category[index])),
                                );
                              },
                              onTap: () {
                                setState(() {
                                  newsCategoryIndex = index;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: DefaultTextStyle(
                                      style: const TextStyle(
                                          fontSize: 30, color: Colors.white),
                                      child: Text(category[index]),
                                    )),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 400,
                child: FutureBuilder(
                    future: ApiService().getNews('science'),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return CarouselSlider.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index,
                              int pageViewIndex) {
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScren(
                                          title: snapshot.data[index].title
                                              .toString(),
                                          content: snapshot.data[index].content
                                              .toString(),
                                          author: snapshot.data[index].author
                                              .toString(),
                                          imageUrl: snapshot
                                              .data[index].imageUrl
                                              .toString(),
                                          readMore: snapshot
                                              .data[index].readMoreUrl
                                              .toString(),
                                        ),
                                      ));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Stack(children: [
                                    SizedBox(
                                      width: 280,
                                      height: 350,
                                      child: FittedBox(
                                        alignment: Alignment.center,
                                        fit: BoxFit.cover,
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.network(snapshot
                                            .data[index].imageUrl
                                            .toString()),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: BlurryContainer(
                                        blur: 5,
                                        width: 280,
                                        height: 160,
                                        elevation: 8,
                                        color: Colors.transparent,
                                        padding: const EdgeInsets.all(8),
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(24),
                                            bottomRight: Radius.circular(24)),
                                        child: DefaultTextStyle(
                                          style: const TextStyle(
                                              fontSize: 18,
                                              overflow: TextOverflow.fade),
                                          child: Text(snapshot.data[index].title
                                              .toString()),
                                        ),
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: 390,
                            viewportFraction: 0.7,
                            autoPlay: true,
                            autoPlayInterval:
                                const Duration(seconds: 2, microseconds: 50),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            // enlargeCenterPage: true,
                          ),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  '  Latest news',
                  maxLines: 4,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    overflow: TextOverflow.clip,
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Center(
                child: FutureBuilder(
                  future: ApiService().getNews(category[newsCategoryIndex]),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: snapshot.data.length * 211.toDouble(),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScren(
                                        title: snapshot.data[index].title
                                            .toString(),
                                        content: snapshot.data[index].content
                                            .toString(),
                                        author: snapshot.data[index].author
                                            .toString(),
                                        imageUrl: snapshot.data[index].imageUrl
                                            .toString(),
                                        readMore: snapshot
                                            .data[index].readMoreUrl
                                            .toString(),
                                      ),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: kCard,
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10,
                                              bottom: 15,
                                              left: 10,
                                              right: 10),
                                          child: Container(
                                            width: 130,
                                            height: 130,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            // padding: EdgeInsets.all(25),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: FittedBox(
                                                alignment: Alignment.center,
                                                fit: BoxFit.cover,
                                                clipBehavior: Clip.hardEdge,
                                                child: Image.network(snapshot
                                                    .data[index].imageUrl
                                                    .toString()),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                width: 160,
                                                margin:
                                                    const EdgeInsets.all(10),
                                                child: DefaultTextStyle(
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      overflow:
                                                          TextOverflow.fade),
                                                  child: Text(
                                                    snapshot.data[index].title
                                                        .toString(),
                                                    maxLines: 4,
                                                    style: const TextStyle(
                                                        overflow:
                                                            TextOverflow.clip),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: SizedBox(
                                                  width: 160,
                                                  child: DefaultTextStyle(
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      overflow:
                                                          TextOverflow.fade,
                                                      color: Colors.grey,
                                                    ),
                                                    child: Text(
                                                        '${snapshot.data[index].author}  |   ${snapshot.data[index].date}'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
