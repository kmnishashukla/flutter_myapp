import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

//import 'package:flutter_html/flutter_html.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    Widget image_slider_carousel = Container(
      height: 200,
      child: Carousel(
        boxFit: BoxFit.fill,
        images: [
          AssetImage('assets/2.jpg'),
          AssetImage('assets/3.jpg'),
          AssetImage('assets/4.jpg'),
          AssetImage('assets/5.jpg'),
          AssetImage('assets/6.jpg'),
          AssetImage('assets/7.jpg'),
        ],
        autoplay: true,
        indicatorBgPadding: 1.0,
        dotColor: Colors.red,
        dotSize: 4.0,
      ),
    );
    return Scaffold(
      body: ListView(
        children: <Widget>[
          image_slider_carousel,
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'About Us',
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'WELCOME TO KOLONIZER REAL BUSINESS SOLUTIONS PVT.LTD.',
              style: TextStyle(fontSize: 20.0, color: Colors.black54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Kolonizer offers software solutions for real estate to streamline the investment, commercial, residential services of real estate companies at an exceptional level. Our properly integrated applications, software and websites help in generating genuine leads to leverage business through higher ROI. Our IT solutions are successfully designing the real estate infrastructure process to perform excellently through Internet, mobile technology, application enhancement and software use..',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18.0, color: Colors.black45),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/about.jpg'))),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Our Features',
              style: TextStyle(fontSize: 25.0, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Kolonizer as a leading software development company in Bhopal India,focus on providing customized software for real estate management, lead management, task management, material management and accounting management to reduce the complexity of real estate developers and builders. Our software serves the efficient needs of real estate marketing companies, real estate dealers covering all the aspects of the business at broader level.',
              //'Kolonizer offers software solutions for real estate to streamline the investment, commercial, residential services of real estate companies at an exceptional level. Our properly integrated applications, software and websites help in generating genuine leads to leverage business through higher ROI. Our IT solutions are successfully designing the real estate infrastructure process to perform excellently through Internet, mobile technology, application enhancement and software use..',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 18.0, color: Colors.black45),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/about2.jpg'))),
          ),
        ],
      ),
    );
  }
}
