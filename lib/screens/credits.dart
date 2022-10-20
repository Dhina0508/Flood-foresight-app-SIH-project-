import 'package:flutter/material.dart';

class Credits extends StatefulWidget {
  Credits({Key? key}) : super(key: key);

  @override
  State<Credits> createState() => _CreditsState();
}

class _CreditsState extends State<Credits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Credits :  30',
          style: TextStyle(fontFamily: 'Cinzel', fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _onbackbottonpressed(context);
              },
              icon: Icon(
                Icons.question_mark_outlined,
                size: 20,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey.shade300,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Transaction:',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 0.3,
                    endIndent: 10,
                    indent: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Credits Added :  10',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Description: For Downloading the App',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
              height: 150,
              width: 390,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey.shade300,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Transaction:',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 0.3,
                    endIndent: 10,
                    indent: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Credits Added :  10',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Description: For Making First call',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
              height: 150,
              width: 390,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey.shade300,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Transaction:',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 0.3,
                    endIndent: 10,
                    indent: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Credits Added :  10',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Description: For Involving in Social Service',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
              height: 150,
              width: 390,
            ),
            SizedBox(
              height: 20,
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(30),
            //     color: Colors.grey.shade200,
            //   ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text(
            //           'Transaction:',
            //           style: TextStyle(fontSize: 25),
            //         ),
            //       ),
            //       Divider(
            //         color: Colors.black,
            //         thickness: 0.3,
            //         endIndent: 10,
            //         indent: 10,
            //       ),
            //       Padding(
            //         padding: EdgeInsets.all(8),
            //         child: Text(
            //           'Credits Added :  10',
            //           style: TextStyle(
            //               fontSize: 20, fontWeight: FontWeight.bold),
            //         ),
            //       ),
            //       SizedBox(
            //         height: 5,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text(
            //           'Description: For Downloading the App',
            //           style: TextStyle(fontSize: 20),
            //         ),
            //       )
            //     ],
            //   ),
            //   height: 150,
            //   width: 390,
            // ),
          ],
        ),
      ),
    );
  }
}

Future<bool> _onbackbottonpressed(BuildContext context) async {
  bool exitApp = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          content: Text(
              'Credits are given by municipality for contributing to social service of in forming aboout flood risk in our Area'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('ok')),
          ],
        );
      });
  return exitApp;
}
