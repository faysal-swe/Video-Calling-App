import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webrtc_flutter/resources/utils/utils.dart';
import '../view_model/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.put(HomeViewModel());

  @override
  void initState() {
    // TODO: implement initState
    Utils.localRenderer.initialize();
    Utils.remoteRenderer.initialize();
    controller.tdtController.addListener(() {
      controller.getIsButtonActive;
    });
    Utils.signaling.onAddRemoteStream = ((stream) {
      Utils.remoteRenderer.srcObject = stream;
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Utils.localRenderer.dispose();
    Utils.remoteRenderer.dispose();
    controller.tdtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(25.0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    controller.createRoom();
                  },
                  child: const Text('Open camera and Create room')),
            ),
            const SizedBox(height: 30),
            const Text('Join the following Room:'),
            GetBuilder<HomeViewModel>(builder: (controller) {
              return TextFormField(
                controller: controller.tdtController,
                maxLength: controller.roomIdLength.value,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: 'room ID',
                    hintStyle: TextStyle(color: Colors.grey.shade400)),
              );
            }),
            const SizedBox(height: 30),
            GetBuilder<HomeViewModel>(builder: (controller) {
              return ElevatedButton(
                  onPressed: controller.isButtonActive.value
                      ? null
                      : () {
                          controller.joinRoom();
                        },
                  style: controller.isButtonActive.value
                      ? ElevatedButton.styleFrom(
                          textStyle: const TextStyle(color: Colors.grey))
                      : ElevatedButton.styleFrom(
                          textStyle: const TextStyle(color: Colors.blue)),
                  child: const Text('Open camera and Join room'));
            })
          ],
        ),
      ),
    ));
  }
}
