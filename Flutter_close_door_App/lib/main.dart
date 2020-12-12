import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  // modify with your true address/port
  Socket sock = await Socket.connect('Your İp Adress',80); //and your port
  runApp(MyApp(sock));
}


class MyApp extends StatelessWidget {
  Socket socket;

  MyApp(Socket s) {
    this.socket = s;
  }

  @override
  Widget build(BuildContext context) {
    final title = 'IOT Aç Kapa | FSM';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,

      theme: ThemeData(
        primarySwatch: Colors.pink, //renk; su rengi seviyorum güzel duruyor
      ),
      home: MyHomePage(
        title: title,
        channel: socket,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final Socket channel;

  MyHomePage({Key key, @required this.title, @required this.channel})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text("Kapıyı Aç",
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 20.0
                  )
                ),
                color: Colors.red,
                onPressed: _acKapi,
              ),
              RaisedButton(
                child: Text("#Evde Kal - Kapat Kapıyı",
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 20.0
                    )
                ),
                color: Colors.red,
                onPressed: _kapaKapi,
              ),
              RaisedButton(
                child: Text("Sürpriz Buton",
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 20.0
                    )
                ),

                color: Colors.red,

                onPressed: _launchURL,
              ),
            ],
          ),
        )
      )
    );
  }

  void _acKapi() {
    widget.channel.write("kapi_Ac\n");
  }

  void _kapaKapi() {
    widget.channel.write("kapi_Kapa\n");
  }


  _launchURL() async {
    const url = 'https://play.google.com/store/apps/details?id=com.fsm.cartoonballs&hl=ln';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  void dispose() {
    widget.channel.close();
    super.dispose();
  }
}
