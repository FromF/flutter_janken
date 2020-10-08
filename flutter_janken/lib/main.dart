import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Janken APP',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Janken APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int answerNumber = 4;
  String jankenText = 'これからじゃんけんします';
  String jankenImage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: SafeArea(
        child:       Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // スペースを追加
            Spacer(),
            Padding(
              // 左右に余白を設定
              padding: EdgeInsets.only(left: 50,right: 50,),
              // 画像を表示
              child: image(jankenImage),
            ),
            // スペースを追加
            Spacer(),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                  jankenText,
                  style: TextStyle(
                    fontSize: 20,
                  )
              ),
            ),
            SizedBox(
              // 横幅いっぱいを指定
              width: double.infinity,
              // 高さ100
              height: 100,
              // [じゃんけんをする！]ボタン
              child: RaisedButton(
                // 背景をピンクに指定
                color: Colors.pink,
                onPressed: () {
                  // 新しいじゃんけんの結果を一時的に格納する変数を設ける
                  int newAnswerNumber = 0;
                  // ランダムに結果を出すが、前回の結果と異なる場合のみ採用
                  // do {} while は繰り返しを意味する
                  do {
                    // 0,1,2の数値をランダムに算出（乱数）
                    newAnswerNumber = math.Random().nextInt(3);
                    // 前回と同じ結果のときは、再度、ランダムに数値を出す
                    // 異なる結果のときは、while を抜ける
                  } while (answerNumber == newAnswerNumber);
                  // 新しいじゃんけんの結果を格納
                  answerNumber = newAnswerNumber;
                  setState(() {
                    if (answerNumber == 0) {
                      // じゃんけんの数字が0だったら、グー画像を指定
                      jankenImage = 'images/gu.png';
                      jankenText = 'グー';
                    } else if (answerNumber == 1) {
                      // じゃんけんの数字が1だったら、チョキ画像を指定
                      jankenImage = 'images/choki.png';
                      jankenText = 'チョキ';
                    } else if (answerNumber == 2) {
                      // じゃんけんの数字が2だったら、パー画像を指定
                      jankenImage = 'images/pa.png';
                      jankenText = 'パー';
                    }
                  });
                },
                // Buttonに表示する文字を指定
                child: Text(
                    'じゃんけんをする！',
                    style: TextStyle(
                      // 文字サイズを指定
                      fontSize: 30,
                      // 文字色を白に指定
                      color: Colors.white,
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget image(String image) {
  if (image.isEmpty) {
    // 画像のファイル名がない場合には、Container()を返して何も表示しない
    return Container();
  } else {
    // 指定された画像ファイル名を表示する
    return Image.asset(
      image,
      fit: BoxFit.fitWidth,
    );
  }
}