import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:problem_statement/app/modules/home_page/controllers/home_page_controller.dart';
import 'package:problem_statement/app/widgets/custom_app_bar.dart';

import '../../../data/constants/image_constants.dart';

class HomePageView extends StatelessWidget {
  //GetView<HomePageController> {
  final controller = Get.isRegistered<HomePageController>() ? Get.find<HomePageController>() : Get.put(HomePageController());
  HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Home Page',
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => controller.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildProfileImageWidget(),
                    _buildUserTileWidget(title: 'Name', text: controller.profileData.name!),
                    _buildUserTileWidget(title: 'Email Id', text: controller.profileData.email!),
                    _buildUserTileWidget(
                        title: 'Address',
                        text: "${controller.profileData.address!.suite!}, ${controller.profileData.address!.street!}"
                            "\n${controller.profileData.address!.city}-${controller.profileData.address!.zipcode!}"
                            "\nLat: ${controller.profileData.address!.geo!.lat!},Long: ${controller.profileData.address!.geo!.lng}"),
                    _buildUserTileWidget(title: 'Phone Number', text: '+91 123456789'),
                    _buildUserTileWidget(title: 'Company', text: 'Company , company, company'),
                    Obx(
                      () => _buildUserTileWidget(
                          title: 'Current Location',
                          text:
                              'Lat: ${controller.locationData.latitude.toString()},\nLong: ${controller.locationData.longitude.toString()}'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildUserTileWidget({required String title, required String text}) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.verticalSpace,
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            text,
          ),
        ],
      ),
    );
  }

  Stack _buildProfileImageWidget() {
    return Stack(children: [
      CircleAvatar(
        radius: 60,
        child: ClipOval(
            child: Obx(
          () => controller.imageFilePath == ''
              ? Image.asset(ImageConstants.defaultProfile)
              : Image.file(
                  File(controller.imageFilePath),
                  fit: BoxFit.fill,
                  width: 100.w,
                ),
        )),
      ),
      Positioned(
          right: -10,
          bottom: -10,
          child: IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () async => controller.imageSelector(),
          ))
    ]);
  }
}
