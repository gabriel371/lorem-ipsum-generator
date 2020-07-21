import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lipsum/lipsum.dart' as Lipsum;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _paragraphs = 1;
  String _text = '';

  FToast fToast;

  _generate() {
    setState(() {
      _text = Lipsum.createText(
        numParagraphs: _paragraphs,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast(context);
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white30,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          SizedBox(width: 12),
          Text('Text copied to clipboard'),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Row(
              children: [
                Text(
                  'Lorem Ipsum',
                  style: TextStyle(fontSize: 40),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Paragraphs',
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_left,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: _paragraphs > 1
                          ? () {
                              _paragraphs--;
                              _generate();
                            }
                          : null,
                    ),
                    Text(
                      _paragraphs.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                        size: 32,
                      ),
                      onPressed: _paragraphs < 20
                          ? () {
                              _paragraphs++;
                              _generate();
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.deepOrange[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.all(20),
                  children: [
                    Text(
                      _text,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Generate',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  onPressed: _generate,
                ),
                _text != ''
                    ? IconButton(
                        icon: Icon(Icons.close),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            _text = '';
                            _paragraphs = 1;
                          });
                        },
                      )
                    : SizedBox(),
                MaterialButton(
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Copy',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.content_copy,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  onPressed: _text != ''
                      ? () {
                          Clipboard.setData(ClipboardData(text: _text))
                              .then((_) => _showToast());
                        }
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
