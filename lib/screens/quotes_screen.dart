import 'package:flutter/material.dart';

import '../model/network.dart';

class QuotesScreen extends StatefulWidget {
  final Map<String, dynamic> quotesDate;

  const QuotesScreen({super.key, required this.quotesDate});

  @override
  QuotesScreenState createState() => QuotesScreenState();
}

class QuotesScreenState extends State<QuotesScreen> {
  late String content;
  late String author;
  late String tags;
  late String url;

  void fetchImage() {
    NetworkHelper.getImageData(tags).then((value) {
      url = value['url'];
    });
  }

  void initialize() async {
    content = widget.quotesDate['content'];
    author = widget.quotesDate['author'];
    tags = widget.quotesDate['tags'][0];
    fetchImage();
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.5),
              BlendMode.dstATop,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        NetworkHelper.getQuotesData().then((newData) {
                          author = newData['author'];
                          content = newData['content'];
                          tags = newData['tags'];
                          // NetworkHelper network = NetworkHelper();
                          // network.getImageData(tags).then((newData) {
                          //   url = newData['url'];
                          // });
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.refresh_outlined,
                      size: 50,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),
              Center(
                child: Text(
                  content,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  author,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
