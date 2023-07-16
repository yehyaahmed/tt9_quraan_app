import 'package:flutter/material.dart';
import 'package:tt9_quraan_app/network.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Network network = Network();
  int pageNumber = 1;
  List<dynamic> ayahs = [];

  void getData() async {
    Map<String, dynamic> pageData = await network.fetchData(pageNumber);
    setState(() {
      ayahs = pageData['data']['ayahs'];
    });

    // print(pageData['data']['ayahs']);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: PageView.builder(itemBuilder: (context, index) {
        pageNumber = index + 1;
        getData();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text.rich(TextSpan(
            children: [
              for (int i = 0; i < ayahs.length; i++) ...{
                TextSpan(text: '${ayahs[i]['text']}'),
                WidgetSpan(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/Ayah.png'),
                      ),
                    ),
                    child: Text(
                      '${ayahs[i]['numberInSurah']}',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                )
              }

              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     Text(
              //       ' ${ayahs[i]['text']} ',
              //       style: TextStyle(fontSize: 18),
              //     ),
              //     Container(
              //       padding: EdgeInsets.all(8),
              //       decoration: BoxDecoration(
              //         image: DecorationImage(
              //           image: AssetImage('images/Ayah.png'),
              //         ),
              //       ),
              //       child: Text(
              //         '${ayahs[i]['numberInSurah']}',
              //         style: TextStyle(fontSize: 12),
              //       ),
              //     )
              //   ],
              // ),
            ],
          )),
        );
      })),
    );
  }
}
