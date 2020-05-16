import 'package:flutter/material.dart';

import 'screens/tab1.dart';
import 'screens/tab2.dart';

class TabContainerIndexedStack extends StatefulWidget {
  TabContainerIndexedStack({Key key}) : super(key: key);

  @override
  _TabContainerIndexedStackState createState() =>
      _TabContainerIndexedStackState();
}

class _TabContainerIndexedStackState extends State<TabContainerIndexedStack> {
  int tabIndex = 0;
  List<Widget> listScreens;
  @override
  void initState() {
    super.initState();
    listScreens = [
      Tab1(),
      Tab2()
    ];
  }

@override
  bool get wantKeepAlive => true; //by default it will be null, change it to true.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      home: Scaffold(
        body: IndexedStack(index: tabIndex, children: listScreens),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabIndex,
            onTap: (int index) {
              setState(() {
                tabIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.timeline),
                title: Text('Tab 1'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Tab 2'),
              ),
            ]),
        backgroundColor: Colors.black,
      ),
    );
  }
}
