import 'package:flutter/material.dart';

enum ArrowDirection {UP, MIDDLE, DOWN}

class ArrowClipPath extends CustomClipper<Path>{
  ArrowDirection direction;
  ArrowClipPath({required this.direction});

  // CLipPath의 자식 위젯의 사이즈가 넘어옴
  @override
  Path getClip(Size size) {
    var path  = Path();

    switch(direction){

      case ArrowDirection.UP:
        path.moveTo(0, size.height);                // 그림 그릴때 시작점
        path.lineTo(size.width * 0.5, 0);           // 맨 위 세모 꼭지점
        path.lineTo(size.width, size.height);
        path.close();
        break;
      case ArrowDirection.MIDDLE:
        path.moveTo(0, size.width * 0.4);
        path.lineTo(size.width, size.height * 0.4);
        path.lineTo(size.width, size.height * 0.6);
        path.lineTo(0, size.width * 0.6);
        break;
      case ArrowDirection.DOWN:
        path.moveTo(0, 0);                // 그림 그릴때 시작점
        path.lineTo(size.width * 0.5, size.height);  // 맨 위 세모 꼭지점
        path.lineTo(size.width, 0);
        path.close();
        break;
    }
    return path;
  }

  // shouldReclip 은 반복해서 어떤 화면이 변할 때 다시 그릴지 말지
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;

}









