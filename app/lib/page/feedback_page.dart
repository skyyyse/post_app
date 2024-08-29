import 'package:app/color/color.dart';
import 'package:app/controller/User_controller.dart';
import 'package:app/page/CircularProgressIndicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class feedback_page extends StatelessWidget {
  feedback_page({super.key});
  final user=Get.put(User_controller());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: TColor.Container,
      appBar: AppBar(
        elevation: 0,
        title: Text("FeedBack",style: TextStyle(color: Colors.white),),
        backgroundColor: TColor.appbar,
        foregroundColor:  Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.blue, width: 1.0),
                ),
                child: TextFormField(
                  controller: user.feedback,
                  decoration: InputDecoration(
                    labelText: 'Text',
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    border: InputBorder.none, // Remove the default border
                  ),
                  maxLines: 5,
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColor.button,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  onPressed: () {
                    user.store();
                  },
                  child: Obx((){
                    return user.isLoading.value?CircularProgressIndicator_page():Text('Feedback',style: TextStyle(color: Colors.white),);
                  })
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
