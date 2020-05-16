import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Tab1 extends StatefulWidget {
  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> with AutomaticKeepAliveClientMixin{
  Completer<WebViewController> _controller = Completer<WebViewController>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    print('Tab1 instantiated');
  }

  @override
  Widget build(BuildContext context) {
    print("Tab1 built");
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(
          title: Text('Tab3'),
          leading: Icon(
            Icons.picture_in_picture_alt,
          ),
         )
        ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            WebView(
              initialUrl: 'https://qytetarin.com/',
              javascriptMode: JavascriptMode.unrestricted,
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

                        backgroundColor: Colors.white70,
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

                          backgroundColor: Colors.white70,
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

                          backgroundColor: Colors.white70,
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
