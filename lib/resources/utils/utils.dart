import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../../data/services/signaling.dart';

class Utils {
  static String? roomId;
  static var localRenderer = RTCVideoRenderer();
  static var remoteRenderer = RTCVideoRenderer();
  static final signaling = Signaling();
  Utils._();
}
