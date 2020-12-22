
import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../public_header.dart';



class WebViewPage extends StatefulWidget {

  const WebViewPage({
    Key key,
    @required this.title,
    @required this.url,
    this.needToken = false
  }) : super(key: key);

  final String title;
  final String url;
  final bool needToken;

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  WebViewController _controllerWeb;
  String _title;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _title = widget.title;

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (context, snapshot) {
          return WillPopScope(
            onWillPop: () async {
              if (snapshot.hasData) {
                var canGoBack = await snapshot.data.canGoBack();
                if (canGoBack) {
                  // 网页可以返回时，优先返回上一页
                  await snapshot.data.goBack();
                  return Future.value(false);
                }
              }
              return Future.value(true);
            },
            child: Scaffold(
                appBar: ShowWhiteAppBar(
                  centerTitle: widget.title,
                ),
                body: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 16),
                      child: WebView(
                        initialUrl: widget.needToken?(widget.url+'?token=${SpUtil.getString(AppValue.token)}'):widget.url,
                        ///JS执行魔术 是否允许JS执行
                        javascriptMode: JavascriptMode.unrestricted,
                        onWebViewCreated: (WebViewController webViewController) {
                          _controller.complete(webViewController);
                          _controllerWeb = webViewController;
                        },
                        onPageFinished: (url) {
                          print('load finished  url = $url');
                          _controllerWeb.evaluateJavascript("document.title").then((result){
                            setState(() {
                              _title = result;
                              isLoading = false;
                            });
                          });
                        },
                        navigationDelegate: (NavigationRequest request) {
                          //对于需要拦截的操作 做判断
                          if(request.url.startsWith("myapp://")) {
                            print("即将打开 ${request.url}");
                            //做拦截处理
                            //pushto....

                            return NavigationDecision.prevent;
                          }

                          //不需要拦截的操作
                          return NavigationDecision.navigate;
                        },
                        javascriptChannels: <JavascriptChannel>[
                          JavascriptChannel(
                              name: "callBack",
                              onMessageReceived: (JavascriptMessage message) {
                                print("参数： ${message.message}");
                                AppPush.goBack(context);
//                                String callbackname = message.message; //实际应用中要通过map通过key获取
//                                String data = "收到消息调用了";
//                                String script = "$callbackname($data)";
//                                _controllerWeb.evaluateJavascript(script);
                              }
                          ),
                        ].toSet(),
                      ),
                    ),
                    Offstage(
                      offstage: !isLoading,
                      child: StateLayout(type: StateType.loading,imageSize: 80,),
                    )
                  ],
                )
            ),
          );
        }
    );
  }


}
