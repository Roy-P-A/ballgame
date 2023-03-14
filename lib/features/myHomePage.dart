import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class BallGameScreen extends StatefulWidget {
  const BallGameScreen({Key? key}) : super(key: key);

  @override
  _BallGameScreenState createState() => _BallGameScreenState();
}

class _BallGameScreenState extends State<BallGameScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  AssetsAudioPlayer player1 = AssetsAudioPlayer();
  AssetsAudioPlayer player2 = AssetsAudioPlayer();

  List<bool> isImageVisibleList1 = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];

  final List<int> numberlist1 = [
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30),
    nextNumber(min: 2, max: 30)
  ];

  final numberDiv = nextNumber(min: 2, max: 6);

  List<RiveAnimation> iconList1 = const [
    RiveAnimation.asset('assets/rive/ball_click.riv'),
    RiveAnimation.asset('assets/rive/ball_click.riv'),
    RiveAnimation.asset('assets/rive/ball_click.riv'),
    RiveAnimation.asset('assets/rive/ball_click.riv'),
    RiveAnimation.asset('assets/rive/ball_click.riv'),
    RiveAnimation.asset('assets/rive/ball_click.riv'),
    RiveAnimation.asset('assets/rive/ball_click.riv'),
    RiveAnimation.asset('assets/rive/ball_click.riv'),
    RiveAnimation.asset('assets/rive/ball_click.riv'),
    RiveAnimation.asset('assets/rive/ball_click.riv'),
    RiveAnimation.asset('assets/rive/ball_click.riv'),
    RiveAnimation.asset('assets/rive/ball_click.riv'),
    RiveAnimation.asset('assets/rive/ball_click.riv'),
    RiveAnimation.asset('assets/rive/ball_click.riv'),
    RiveAnimation.asset('assets/rive/ball_click.riv'),
    RiveAnimation.asset('assets/rive/ball_click.riv')
  ].toList();
  int score = 0;
  int correctAnswers = 0;
  int wrongAnswers = 0;

  Image balloonImage = const Image(
      fit: BoxFit.contain, image: AssetImage('assets/images/ball.png'));

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    super.initState();

    player1.open(Audio('assets/audio/Win.mp3'),
        autoStart: false, showNotification: true);

    player2.open(Audio('assets/audio/Lose.wav'),
        autoStart: false, showNotification: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
            image: const AssetImage('assets/images/background.jpg'),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const Text(
                  'I have 40 soccer balls. I need 1/5 of them.How many do I need?',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                Expanded(
                  flex: 8,
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 9,
                    children: List.generate(
                        numberlist1.length,
                        (index) => Column(
                              children: [
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (numberlist1[index] % numberDiv ==
                                            0) {
                                          player1.play();
                                          isImageVisibleList1[index] = false;

                                          iconList1[index] =
                                              const RiveAnimation.asset(
                                                  'assets/rive/ball_click.riv');
                                          score++;
                                          correctAnswers++;
                                        } else {
                                          player2.play();
                                          isImageVisibleList1[index] = false;
                                          iconList1[index] =
                                              const RiveAnimation.asset(
                                                  'assets/rive/ball_click.riv');
                                          //score--;
                                          wrongAnswers++;
                                        }
                                      });
                                    },
                                    child: Stack(
                                      alignment:
                                          AlignmentDirectional.bottomCenter,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: isImageVisibleList1[index]
                                              ? balloonImage
                                              : const Text(''),
                                        ),
                                        SizedBox(
                                          height: 80,
                                          width: 80,
                                          child: isImageVisibleList1[index]
                                              ? const Center(
                                                  child: Text(
                                                    '',
                                                  ),
                                                )
                                              : iconList1[index],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// create a method to show randow numbers between 2 numbers
int nextNumber({required int min, required int max}) =>

    //max 50 , min 5
    //1.50-5 = 45
    //2.Random.nextInt(45+1)=>0...45
    //3.5 + 0 ... 45 => 5...50

    min + Random().nextInt(max - min + 1);
