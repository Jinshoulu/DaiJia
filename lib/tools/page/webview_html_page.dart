

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../public_header.dart';



class WebViewHtmlPage extends StatefulWidget {

  final String title;
  final String html;
  const WebViewHtmlPage({Key key, this.html = '', this.title = ''}) : super(key: key);

  @override
  _WebViewHtmlPageState createState() => _WebViewHtmlPageState();
}

class _WebViewHtmlPageState extends State<WebViewHtmlPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.html);

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: ShowWhiteAppBar(
        centerTitle: widget.title,
      ),
      body: SingleChildScrollView(
        child: Html(
          padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
          data: widget.html,
        ),
      ),
    );
  }
}
