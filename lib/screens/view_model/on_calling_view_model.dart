import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:webrtc_flutter/resources/utils/utils.dart';
import '../../data/services/signaling.dart';

class OnCallingViewModel extends GetxController {
  var remoteStream = Utils.remoteRenderer.obs;
  var localStream = Utils.localRenderer.obs;

  RxBool isVideoEnable = true.obs;
  RxBool isAudioEnable = true.obs;

  void toggleVideo() {
    var videoTracks = Utils.localRenderer.srcObject?.getVideoTracks();
    if (videoTracks != null && videoTracks.isNotEmpty) {
      videoTracks[0].enabled = isVideoEnable.value; // Enable or disable video
    }
  }

  void toggleAudio() {
    var audioTracks = Utils.localRenderer.srcObject?.getAudioTracks();
    if (audioTracks != null && audioTracks.isNotEmpty) {
      audioTracks[0].enabled = isAudioEnable.value; // Enable or disable audio
    }
  }

  void hangUp() async {
    // Close the WebRTC Peer Connection
    Utils.signaling.peerConnection?.close();
    Utils.signaling.peerConnection = null;

    // Stop local and remote streams
    Utils.localRenderer.srcObject?.getTracks().forEach((track) {
      track.stop();
    });
    Utils.remoteRenderer.srcObject?.getTracks().forEach((track) {
      track.stop();
    });

    // Dispose of video renderers
    Utils.localRenderer.dispose();
    Utils.remoteRenderer.dispose();

    // Update the state to reflect that the call has ended
    update();
  }
}
