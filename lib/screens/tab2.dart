import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Tab2 extends StatefulWidget {
  @override
  _Tab2State createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> with AutomaticKeepAliveClientMixin<Tab2> {
  Completer <WebViewController> _controller =Completer<WebViewController>();
  bool isLoading =true;

  @override
  void initState() {
    super.initState();
    print('initState Tab2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab2'),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            WebView(
              initialUrl: 'https://google.com/',
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onPageFinished: (String url){
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Colors.redAccent),
                ),
              ),
              backgroundColor: Colors.white.withOpacity(0.70),
            ) : Stack()
          ],
        ),
      ),
      floatingActionButton: FutureBuilder<WebViewController>(
          future: _controller.future,
          builder: (BuildContext context,
              AsyncSnapshot<WebViewController> controller) {
            if (controller.hasData) {
              return Row(
                children: <Widget>[
                  Spacer(
                    flex: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.5),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        child: Icon(
                            Icons.arrow_back
                        ),

                        backgroundColor: Colors.black,
                        foregroundColor: Colors.red,

                        onPressed: () {
                          controller.data.goBack();
                        },
                        heroTag: null,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(child: Icon(
                            Icons.rotate_left
                        ),

                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue,

                          onPressed: () {
                            controller.data.reload();
                          },
                          heroTag: null,
                        ),
                      )
                  ),
                  Padding(
                      padding: const EdgeInsets.all(2.5),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: FloatingActionButton(child: Icon(
                            Icons.arrow_forward
                        ),

                          backgroundColor: Colors.black,
                          foregroundColor: Colors.green,
                          onPressed: () {
                            controller.data.goForward();
                          },
                          heroTag: null,
                        ),
                      )
                  ),
                ],
              );
            }
            return Container();
          }
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;
}
