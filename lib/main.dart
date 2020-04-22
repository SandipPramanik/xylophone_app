import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xylophoneapp/theme.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(MyApp());

final AudioCache player = AudioCache();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: XylophoneApp(),
            theme: notifier.darkTheme ? dark : light,
          );
        },
      ),
    );
  }
}

class XylophoneApp extends StatelessWidget {
  final keyColors = [
    Colors.green[700],
    Colors.blue[800],
    Colors.amber,
    Colors.orange[800],
    Colors.purple,
    Colors.red[700],
    Colors.teal
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Xylophone Flutter",
        ),
        centerTitle: true,
        elevation: 10,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 15, right: 10.0),
              child: Consumer<ThemeNotifier>(
                builder: (context, ThemeNotifier notifier, child) {
                  return Switch(
                      value: notifier.darkTheme,
                      onChanged: (val) {
                        notifier.toggleTheme();
                      });
                },
              ))
        ],
      ),
      body: Container(
        color: Colors.transparent,
        child: LayoutBuilder(
          builder: (context, constraint) {
            var maxWidth = MediaQuery.of(context).size.width;

            var w = maxWidth - 120;
            var h = 50.0;

            var i = 0;

            final myKeys = keyColors.map((c) {
              i++;
              return XylophoneKey(
                color: c,
                width: w,
                height: h,
                sound: 'note$i',
              );
            }).toList();

            return Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 100),
                        child: Consumer<ThemeNotifier>(
                          builder: (context, notifier, child) {
                            return Container(
                              height: double.infinity,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: notifier.darkTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 100),
                        child: Consumer<ThemeNotifier>(
                          builder: (context, notifier, child) {
                            return Container(
                              height: double.infinity,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: notifier.darkTheme
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  textDirection: TextDirection.ltr,
                  children: myKeys,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class XylophoneKey extends StatelessWidget {
  final Color color;
  final double width;
  final double height;
  final String sound;

  XylophoneKey({this.color, this.width, this.height, this.sound});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("I was tapped: ${color.toString()}");
        player.play('$sound.wav');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(16.0)),
        ),
      ),
    );
  }
}
