import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../resources/utils/utils.dart';
import '../view/on_calling_view.dart';

class HomeViewModel extends GetxController {
  RxInt roomIdLength = 20.obs;
  RxBool isButtonActive = false.obs;
  final TextEditingController tdtController = TextEditingController();

  void get getIsButtonActive {
    tdtController.value.text.length != roomIdLength.value
        ? isButtonActive.value = true
        : isButtonActive.value = false;
    update();
  }

  void createRoom() async {
    await Utils.signaling
        .openUserMedia(Utils.localRenderer, Utils.remoteRenderer)
        .then((_) async {
      update();
    });
    Utils.roomId = await Utils.signaling.createRoom(Utils.remoteRenderer);
    Get.to(const OnCallingView());
  }

  void joinRoom() async {
    await Utils.signaling
        .openUserMedia(Utils.localRenderer, Utils.remoteRenderer)
        .then((_) async {
      update();
    });
    Utils.signaling.joinRoom(
      tdtController.text.trim(),
      Utils.remoteRenderer,
    );
    Utils.roomId = tdtController.text.trim();
    Get.to(const OnCallingView());
  }
}
