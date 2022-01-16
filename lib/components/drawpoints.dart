import 'package:flutter/material.dart';

class KeyPoints extends StatefulWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;

  KeyPoints(this.results, this.previewH, this.previewW, this.screenH,
      this.screenW, this.model);

  @override
  _KeyPointsState createState() => _KeyPointsState();

}

class _KeyPointsState extends State<KeyPoints> {

  late Map<String, List<double>> inputArr;
  late int _counter;
  late bool midCount;
  double upperRange = 200;

  void initState() {
    super.initState();
    _counter = 0;
    midCount = false;
    inputArr=new Map();
  }

  void incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void setMidCount(bool f) {
    setState(() {
      midCount = f;
    });
  }

  void saveCount(){


  }

  Future<void> _countingLogic(Map<String, List<double>> poses) async {
    if (poses != null) {
      if (poses['nose']![1] > upperRange) {
        setMidCount(true);
      }
      if (midCount && poses['nose']![1] < upperRange) {
        incrementCounter();
        setMidCount(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderKeypoints() {
      var lists = <Widget>[];
      widget.results.forEach((re) {
        var list = re["keypoints"].values.map<Widget>((k) {
          var _x = k["x"];
          var _y = k["y"];
          var scaleW, scaleH, x, y;

          if (widget.screenH / widget.screenW > widget.previewH / widget.previewW) {
            scaleW = widget.screenH / widget.previewH * widget.previewW;
            scaleH = widget.screenH;
            var difW = (scaleW - widget.screenW) / scaleW;
            x = (_x - difW / 2) * scaleW;
            y = _y * scaleH;
          } else {
            scaleH = widget.screenW / widget.previewW * widget.previewH;
            scaleW = widget.screenW;
            var difH = (scaleH - widget.screenH) / scaleH;
            x = _x * scaleW;
            y = (_y - difH / 2) * scaleH;
          }

          inputArr[k['part']] = [x,y];

          if (k["part"] == "nose"){
            return Center(
              /*left: x + 65,
              top: y + 70,
              width: 100,
              height: 12,*/
              child: Container(
                child: Text(
                  //"● ${k["part"]} at $y",
                  " ",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 30.0,
                  ),
                ),
              ),
            );}
          else {
            return Positioned(
              left: x + 65,
              top: y + 70,
              width: 100,
              height: 12,
              child: Container(
                child: Text(
                  " ",
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 12.0,
                  ),
                ),
              ),
            );
          }

        }).toList();

        _countingLogic(inputArr);
        lists..addAll(list);
      });

      return lists;
    }

    return Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
//            child: LinearPercentIndicator(
//              animation: true,
//              lineHeight: 20.0,
//              animationDuration: 500,
//              animateFromLastPercent: true,
//              percent: _counter,
//              center: Text("${(_counter).toStringAsFixed(1)}"),
//              linearStrokeCap: LinearStrokeCap.roundAll,
//              progressColor: Colors.green,
//            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(200, 0, 0, 25),
              child: Container(
                height: 70,
                width: 70,
                child: FittedBox(
                  child: FloatingActionButton(
                    backgroundColor: Colors.indigo,
                    onPressed: saveCount,
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),

          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
//            child: LinearPercentIndicator(
//              animation: true,
//              lineHeight: 20.0,
//              animationDuration: 500,
//              animateFromLastPercent: true,
//              percent: _counter,
//              center: Text("${(_counter).toStringAsFixed(1)}"),
//              linearStrokeCap: LinearStrokeCap.roundAll,
//              progressColor: Colors.green,
//            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 200, 25),
              child: Container(
                height: 70,
                width: 70,
                child: FittedBox(
                  child: FloatingActionButton(
                    backgroundColor: Colors.indigo,
                    onPressed: resetCounter,
                    child: Text(
                      'RESET',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),

          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
//            child: LinearPercentIndicator(
//              animation: true,
//              lineHeight: 20.0,
//              animationDuration: 500,
//              animateFromLastPercent: true,
//              percent: _counter,
//              center: Text("${(_counter).toStringAsFixed(1)}"),
//              linearStrokeCap: LinearStrokeCap.roundAll,
//              progressColor: Colors.green,
//            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Container(
                height: 100,
                width: 100,
                child: FittedBox(
                  child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: null,
                    child: Text(
                      '${_counter.toString()}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),

          ),
        ],
      ),
      Stack(
        children: _renderKeypoints(),
      ),
    ]);
  }

}





