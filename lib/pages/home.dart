import 'package:flutter/material.dart';
import 'package:multi_quiz_s_t_tt9/constants.dart';
import 'package:multi_quiz_s_t_tt9/pages/level_describtion.dart';
import 'package:multi_quiz_s_t_tt9/widgets/my_outline_btn.dart';

import '../modules/level.dart';
import '../widgets/my_level_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Level> levels = [
    Level(
        title: 'True or False',
        subTitle: 'Level 1',
        colors: const [kL1, kL12],
        iconData: Icons.check,
        routeName: '/true_false_screen',
        image: 'assets/images/bags.png'),
    Level(
        routeName: '/multiple_choose_screen',
        title: 'Multiple Choice',
        subTitle: 'Level 2',
        colors: const [kL2, kL22],
        iconData: Icons.play_arrow,
        image: 'assets/images/ballon-s.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.favorite,
                    size: 25,
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    fixedSize: Size(40, 40),
                    padding: EdgeInsets.all(0),
                    shape: CircleBorder(),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.person_2,
                    size: 30,
                  ),
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size.zero,
                    fixedSize: Size(40, 40),
                    padding: EdgeInsets.all(0),
                    shape: CircleBorder(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Let\'s Play',
              style: TextStyle(
                fontSize: 32,
                color: kRedFont,
                fontWeight: FontWeight.bold,
                fontFamily: kFontFamily,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Be the First!',
              style: TextStyle(
                fontSize: 18,
                color: kGreyFont,
                fontFamily: kFontFamily,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: levels.length,
                itemBuilder: (context, index) {
                  return MyLevelWidget(
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LevelDescription(
                                  routeName: levels[index].routeName,
                                  titleQuestion: levels[index].title,
                                  color: levels[index].colors,
                                  subTitle: levels[index].subTitle,
                                  imageSource: levels[index].image!),
                            ));
                      },
                      icon: levels[index].iconData!,
                      title: levels[index].title,
                      subtitle: levels[index].subTitle,
                      image: levels[index].image!,
                      colors: levels[index].colors);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
