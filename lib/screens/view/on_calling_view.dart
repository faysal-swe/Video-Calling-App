import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import '../../resources/utils/utils.dart';
import '../view_model/on_calling_view_model.dart';

class OnCallingView extends StatefulWidget {
  const OnCallingView({super.key});

  @override
  State<OnCallingView> createState() => _OnCallingViewState();
}

class _OnCallingViewState extends State<OnCallingView> {
  final controller = Get.put(OnCallingViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Obx(() {
            return Positioned.fill(
              child: RTCVideoView(
                controller.remoteStream.value,
              ),
            );
          }),
          Obx(() {
            return Positioned(
              top: 50, // Position from the bottom
              right: 20, // Position from the right
              width: 120, // Width of local video
              height: 200, // Height of local video
              child: RTCVideoView(
                controller.localStream.value,
                mirror: true, // Typically mirror local video
              ),
            );
          }),
          GetBuilder<OnCallingViewModel>(builder: (controller) {
            return Positioned(
              top: 0, // Position from the top
              left: (MediaQuery.of(context).size.width - 120) /
                  2, // Center horizontally
              width: 120, // Width of local video
              height: 200, // Height of local video
              child: Text("roomID: ${Utils.roomId.toString()}"),
            );
          }),
          Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Obx((){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          controller.isVideoEnable.value = !controller.isVideoEnable.value;
                          controller.toggleVideo();
                        },
                        child: controller.isVideoEnable.value ? const Icon(Icons.video_call): const Icon(Icons.videocam_off)),
                    ElevatedButton(
                        onPressed: (){
                          controller.isAudioEnable.value = !controller.isAudioEnable.value;
                          controller.toggleAudio();
                        },
                        child: controller.isAudioEnable.value ?const Icon(Icons.mic) : const Icon(Icons.mic_off)),
                    ElevatedButton(
                        onPressed: (){
                          controller.hangUp();
                        },
                        child: const Icon(Icons.call))
                  ],
                );
              }))
        ],
      ),
    ));
  }
}
