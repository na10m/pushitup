import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import '../camera.dart';
import '../drawpoints.dart';
import 'dart:math' as math;

import 'dart:developer';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraScreen(this.cameras);
  static const String id = "camera_screen";

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = '';
  late List<dynamic> _recognitions;
  @override
  void initState() {
    super.initState();
    _loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  _loadModel() async {
    String? res;
    res = await Tflite.loadModel(model: "assets/posenet.tflite");
    log(res!);
    _model = 'posenet';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    log('res');
    Size screen = MediaQuery.of(context).size;
    return _model == ""
        ? Center(
      child: Text('Loading'),
    )
        : Stack(children: <Widget>[
      Camera(
        widget.cameras,
        _model,
        setRecognitions,
      ),
      KeyPoints(
          _recognitions == null ? [] : _recognitions,
          math.max(_imageHeight, _imageWidth),
          math.min(_imageHeight, _imageWidth),
          screen.height,
          screen.width,
          _model),
    ]);
  }
}
