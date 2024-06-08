import 'package:flutter/material.dart';
import 'sehirler.dart';

void main() {
  runApp(const Navigasyon());
}

class Navigasyon extends StatefulWidget {
  const Navigasyon({super.key});

  @override
  State<Navigasyon> createState() => _NavigasyonState();
}

class _NavigasyonState extends State<Navigasyon> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Navigasyon Örneği",
      routes: {
        '/': (context) => Sayfa1(),
        //'/haber': (context) => Sayfa2(),
        '/ayar': (context) => Sayfa3()
      },
      initialRoute: '/',
      //home: Sayfa1(),
    );
  }
}

class Sayfa1 extends StatefulWidget {
  const Sayfa1({super.key});

  @override
  State<Sayfa1> createState() => _Sayfa1State();
}

class _Sayfa1State extends State<Sayfa1> {
  String uniAdi = "İnönü Üniversitesi";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          backgroundColor: Colors.grey,
          child: ListView(
            children: [
              ListTile(
                title: Text("Sayfa 1"),
                onTap: () => Navigator.pushNamed(context, "/"),
              ),
              ListTile(
                title: Text("Sayfa 3"),
                onTap: () => Navigator.pushNamed(context, "/ayar"),
              ),
              ListTile(
                title: Text("Sayfa 2"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Sayfa2(
                        uniAdi: uniAdi,
                      ),
                    ),
                  );
                },
              ),
            ],
          )),
      appBar: AppBar(
        title: Text("Anasayfa"),
      ),
      body: Center(
          child: Column(
        children: [
          Text(
            "Sayfa 1",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text("Üni adı $uniAdi"),
          OutlinedButton(
            onPressed: () async {
              String? deger = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Sayfa2(
                    uniAdi: uniAdi,
                  ),
                ),
              );
              if (deger != null) {
                print(deger);
              }
            },
            child: Text("Sayfa 2 git"),
          ),
          Flexible(
            child: ListView.builder(
              itemCount: sehirler.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(sehirler[index].isim),
                  onTap: () {
                    print("$index nolu satira basildi");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SehirDetay(gelenSehir: sehirler[index]),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      )),
    );
  }
}

class Sayfa2 extends StatefulWidget {
  Sayfa2({super.key, required this.uniAdi});
  String uniAdi;
  @override
  State<Sayfa2> createState() => _Sayfa2State();
}

class _Sayfa2State extends State<Sayfa2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sayfa 2"),
      ),
      body: Center(
          child: Column(
        children: [
          Text("Sayfa 2", style: Theme.of(context).textTheme.headlineLarge),
          IconButton.outlined(
              onPressed: () {
                Navigator.pop(context, "Sol");
              },
              icon: Icon(Icons.add_circle_outline_sharp)),
          IconButton.outlined(
              onPressed: () {
                Navigator.pop(context, "Sağ");
              },
              icon: Icon(Icons.arrow_right)),
          Text("Uni Adı:${widget.uniAdi}"),
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, "/ayar");
              /* Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Sayfa3(),
                  )); */
            },
            icon: Icon(Icons.next_plan_outlined),
            label: Text("Sayfa3"),
          )
        ],
      )),
    );
  }
}

class Sayfa3 extends StatefulWidget {
  const Sayfa3({super.key});

  @override
  State<Sayfa3> createState() => _Sayfa3State();
}

class _Sayfa3State extends State<Sayfa3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sayfa 3"),
      ),
      body: Center(
          child: Column(
        children: [
          Text(
            "Sayfa 3",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          GestureDetector(
            child: Text("Anasayfa"),
            onTap: () {
              Navigator.popUntil(context, ModalRoute.withName("/"));
            },
          ),
        ],
      )),
    );
  }
}

class SehirDetay extends StatelessWidget {
  SehirDetay({super.key, required this.gelenSehir});
  Sehir gelenSehir;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image.network(gelenSehir.resim),
            Text(
              gelenSehir.isim,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(gelenSehir.detay)
          ],
        ),
      ),
    );
  }
}
