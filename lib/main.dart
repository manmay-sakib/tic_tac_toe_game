import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> displayExOh = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  bool ohTurn = true; // the first player is o!
  var myTextStyle = const TextStyle(color: Colors.white, fontSize: 30);
  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Player O",
                          style: myTextStyle,
                        ),
                        Text(
                          ohScore.toString(),
                          style: myTextStyle,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Player X",
                          style: myTextStyle,
                        ),
                        Text(
                          exScore.toString(),
                          style: myTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade700),
                        ),
                        child: Center(
                          child: Text(
                            displayExOh[index],
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayExOh[index] == "") {
        displayExOh[index] = 'o';
        filledBoxes++;
      } else if (!ohTurn && displayExOh[index] == "") {
        displayExOh[index] = 'x';
        filledBoxes++;
      }
      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    // Checks 1st row
    if (displayExOh[0] == displayExOh[1] &&
        displayExOh[0] == displayExOh[2] &&
        displayExOh[0] != "") {
      _showWinDialog(displayExOh[0]);
    }
    // Checks 2st row
    if (displayExOh[3] == displayExOh[4] &&
        displayExOh[3] == displayExOh[5] &&
        displayExOh[3] != "") {
      _showWinDialog(displayExOh[3]);
    }
    // Checks 3rd row
    if (displayExOh[6] == displayExOh[7] &&
        displayExOh[6] == displayExOh[8] &&
        displayExOh[6] != "") {
      _showWinDialog(displayExOh[6]);
    }
    // Checks 1st column
    if (displayExOh[0] == displayExOh[3] &&
        displayExOh[0] == displayExOh[6] &&
        displayExOh[0] != "") {
      _showWinDialog(displayExOh[0]);
    }
    // Checks 2nd column
    if (displayExOh[1] == displayExOh[4] &&
        displayExOh[1] == displayExOh[7] &&
        displayExOh[1] != "") {
      _showWinDialog(displayExOh[1]);
    }
    // Checks 3rd column
    if (displayExOh[2] == displayExOh[5] &&
        displayExOh[2] == displayExOh[8] &&
        displayExOh[2] != "") {
      _showWinDialog(displayExOh[2]);
    }
    // Checks 1st diagonal
    if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != "") {
      _showWinDialog(displayExOh[0]);
    }
    // Checks 2nd diagonal
    if (displayExOh[2] == displayExOh[4] &&
        displayExOh[2] == displayExOh[6] &&
        displayExOh[2] != "") {
      _showWinDialog(displayExOh[2]);
    }
    else if(filledBoxes==9){
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('WINNER IS: $winner'),
            actions: [
              ElevatedButton(
                onPressed: (){
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Play Again!',
                ),
              ),
            ],
          );
        });
    if (winner == 'o') {
      ohScore++;
    } else if (winner == 'x') {
      exScore++;
    }
  }

  void _clearBoard() {
   setState(() {
     for(int i=0; i<9; i++){
       displayExOh[i] = '';
     }
   });
   filledBoxes = 0;
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("DRAW"),
            actions: [
              ElevatedButton(
                onPressed: (){
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Play Again!',
                ),
              ),
            ],
          );
        });
  }
}
