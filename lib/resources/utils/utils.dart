import 'dart:math';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../../data/services/signaling.dart';

class Utils {
  static String? roomId;
  static var localRenderer = RTCVideoRenderer();
  static var remoteRenderer = RTCVideoRenderer();
  static final signaling = Signaling();
  static int getRandomID() {
    final random = Random();
    int randomID = 10000 + random.nextInt(90000);

    return randomID;
  }

  Utils._();
}
