import 'package:covid_statistics/src/canvas/arrow_clip_path.dart';
import 'package:covid_statistics/src/utils/DataUtils.dart';
import 'package:flutter/material.dart';

class CovidStatisticsView extends StatelessWidget {
  CovidStatisticsView({
    Key? key,
    required this.title,
    required this.addedCount,
    required this.upDown,
    required this.totalCount,
    this.dense = false,
    this.titleColor = const Color(0xff4c4e5d),
    this.subValueColor = Colors.black,
    this.spacing = 10,
    }) : super(key: key);

  final String title;
  final double addedCount;
  final ArrowDirection upDown;
  final double totalCount;
  final bool dense;      // 밀집? (위에 부분인지 아랫 부분인지)
  final Color titleColor;
  final Color subValueColor;
  final double spacing;  // 간격


  @override
  Widget build(BuildContext context) {
    var color = Colors.black;

    switch(upDown){
      case ArrowDirection.UP:
        color = Color(0xffcf5f51); // 레드
        break;
      case ArrowDirection.MIDDLE:  // 기본색상인 블랙
        break;
      case ArrowDirection.DOWN:
        color = Color(0xff3749be); // 블루
        break;
    }

    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                color: titleColor,
                fontSize: dense ? 14 : 18
            ),
          ),
          SizedBox(height: spacing,),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ↱ borderRadius를 쉽게 주기 위해 ClipRRect로 감쌈
              ClipPath(
                clipper: ArrowClipPath(direction: upDown),
                child: Container(
                  width: dense ? 10 : 20,
                  height: dense ? 10 : 20,
                  color: color,
                ),
              ),
              SizedBox(width: 3,),
              Text(
                DataUtils.myNumberFormat(addedCount),
                style: TextStyle(
                    color: color,
                    fontSize: dense ? 25 : 50,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          SizedBox(height: spacing * 0.5,),

          Text(
            DataUtils.myNumberFormat(totalCount),
            style: TextStyle(
              color: subValueColor,
              fontSize: dense ? 15 : 20,
            ),
          ),
        ],
      ),
    );
  }
}
