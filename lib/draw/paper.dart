import 'dart:math';
import 'dart:ui';

import 'package:first_station/draw/conform_dialog.dart';
import 'package:first_station/draw/paper_app_bar.dart';
import 'package:first_station/draw/Line.dart';
import 'package:first_station/storage/spStorage.dart';
import 'package:flutter/material.dart';

///白板绘制的主界面
class Paper extends StatefulWidget {
  const Paper({super.key});

  @override
  State<Paper> createState() => _PaperState();
}

class _PaperState extends State<Paper> with AutomaticKeepAliveClientMixin {
  //放入需要的数据

  List<Line> _lines = []; //线列表
  int _activeColorIndex = 0; //颜色激活索引
  int _activeStorkIndex = 0; //线宽激活索引

  //支持的颜色
  final List<Color> supportColors = [
    Colors.black,
    Colors.grey,
    Colors.redAccent,
    Colors.purple,
    Colors.blue,
    Colors.orangeAccent
  ];

  //支持的线宽
  final List<double> supportStorkWidths = [1, 2, 4, 5, 6, 7, 8];

  //saveConfig  保存触发
  void saveConfig() {
    SpStorage.instance.savePaperConfig(
        list: _lines,
        activeColorIndex: _activeColorIndex,
        activeStorkIndex: _activeStorkIndex);
  }

  @override
  void initState() {
    super.initState();
    _initConfig();
  }

  void _initConfig() async {
    Map<String, dynamic> config = await SpStorage.instance.readPaperConfig();
    _lines = config['lines'] ?? "";
    _activeColorIndex = config["activeColorIndex"] ?? 0;
    _activeStorkIndex = config["activeStorkIndex"] ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PaperAppBar(onClear: _showClearDialog),
      body: GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        child: CustomPaint(
          painter: PaperPainter(lines: _lines),
          child: ConstrainedBox(
            constraints: const BoxConstraints.expand(),
          ),
        ),
      ),
    );
  }

  void _showClearDialog() {
    showDialog(
        context: context,
        builder: (ctx) => ConformDialog(
              title: '清空提示',
              msg: "您的当前操作会清空绘制内容，是否确定删除!",
              conformText: '确定',
              onConform: _clear,
            ));
  }

  //点击清除按钮,清空线列表
  void _clear() => () {
        _lines.clear();
        Navigator.of(context).pop();
        setState(() {});
      };

  //拖拽开始,添加新线
  void _onPanStart(DragStartDetails details) {
    _lines.add(Line(
      points: [details.localPosition],
      //使用激活线宽
      // strokeWidth: supportStorkWidths[_activeStorWidthIndex],
    ));
  }

  //拖拽中,为新线添加点
  void _onPanUpdate(DragUpdateDetails details) {
    _lines.last.points.add(details.localPosition);
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;
}

class PaperPainter extends CustomPainter {
  PaperPainter({required this.lines}) {
    _paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  final List<Line> lines;
  late Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < lines.length; i++) {
      drawLine(canvas, lines[i]);
    }
  }

  void drawLine(Canvas canvas, Line lin) {
    _paint.color = lin.color;
    _paint.strokeWidth = lin.strokeWidth;
    canvas.drawPoints(PointMode.polygon, lin.points, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// @override
// void paint(Canvas canvas, Size size) {
//   //画板上点的位置
//   List<Offset> points = const [
//     Offset(100, 100),
//     Offset(120, 100),
//     Offset(156, 175),
//     Offset(277, 347),
//   ];
//   Paint paint = Paint();
//   paint.strokeWidth = 10;
//   paint.style = PaintingStyle.stroke;
//   paint.color = Colors.yellow;
//   paint.strokeCap = StrokeCap.round;
//   canvas.drawPoints(PointMode.polygon, points, paint);
//   Rect rect =
//       Rect.fromCenter(center: Offset(100, 100), width: 100, height: 80);
//   canvas.drawOval(rect, paint);
//   //绘制圆弧
//   canvas.drawArc(rect.translate(100, 100), 0, pi * 1.5, true, paint);
// }
//
// @override
// bool shouldRepaint(covariant CustomPainter oldDelegate) => true;}
