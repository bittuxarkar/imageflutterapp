import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List images = [];
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchapi();
  }

  fetchapi()async{
    await http.get(Uri.parse("https://api.pexels.com/v1/curated?page=2&per_page=100"),
      headers:{"Authorization": '563492ad6f91700001000001b9d15128c4154058b636176b6e9cd039'}).then((value) {
        Map result = jsonDecode(value.body);
        setState(() {
          images = result['photos'];
        });
        print(images[0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Downloader"),
        actions: [
          IconButton(
              onPressed: (){},
              icon: Icon(Icons.download),
          )
        ],
      ),

      body: GridView.builder(
        itemCount: images.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
        childAspectRatio: 2/3,
      ),
        itemBuilder: (context,index){
        return InkWell(
          onTap: (){
            print(images[index]['url']);
          },
          child: Container(
            color: Colors.white,
            child: Image.network(images[index]['src']['tiny'],
              fit: BoxFit.cover,
            ),
          ),
        );
        },
      ),
    );
  }
}
