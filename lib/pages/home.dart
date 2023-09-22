import 'package:flutter/material.dart';
import 'package:outlined_text/outlined_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data.isNotEmpty ? print('data from result ') : print('data from builder');
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;
    String bgImage = data['isDayTime'] ? 'dayut.jpg' : 'nightut.jpg';
    Color bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[700]!;
    print('Heres the data $data');
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'location': result['location'],
                        'time': result['time'],
                        'flag': result['flag'],
                        'isDayTime': result['isDayTime'],
                      };
                    });
                  },
                  icon: const Icon(Icons.edit_location),
                  label: const Text('Edit location'),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedText(
                      text: Text(
                        data['location'],
                        style: const TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.white,
                        ),
                      ),
                      strokes: [
                        OutlinedTextStroke(color: Colors.black, width: 3),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                OutlinedText(
                  text: Text(
                    data['time'],
                    style: const TextStyle(
                      fontSize: 66.0,
                      color: Colors.white,
                    ),
                  ),
                  strokes: [
                    OutlinedTextStroke(color: Colors.black, width: 3),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
