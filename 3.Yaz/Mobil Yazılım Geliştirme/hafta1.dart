import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    print("sayfa build edildi");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 3, 223, 69)),
      ),
      home: Scaffold(
        appBar: appBar1(),
        drawer: Drawer(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {},
          child: Icon(Icons.mail_lock),
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 4,
          shape: CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
              backgroundColor: Color.fromARGB(255, 4, 128, 41),
              type: BottomNavigationBarType.fixed,
              currentIndex: 2,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.chat_bubble), label: "Sohbetler"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.stadium_outlined), label: "Durumlar"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Settings"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.call_end_sharp), label: "Aramalar"),
              ]),
        ),
        body: Center(
          child: Text(
            "fırat üniversitesi",
            style: TextStyle(
              fontSize: 25,
              fontFamily: "Impact",
              color: Color(0xffBAC109),
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar1() {
    return AppBar(
      title: const Text("İlk uygulama"),
      centerTitle: true,
      //leading: const Icon(Icons.menu_open_outlined),
      elevation: 5,
      actions: const [
        Icon(Icons.shopping_basket),
        Center(
          child: Badge(
            label: Text("3"),
            child: Icon(Icons.notification_add_outlined),
          ),
        ),
      ],
    );
  }
}
