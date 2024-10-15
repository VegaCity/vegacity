import 'package:base/configs/routes/app_router.dart';
import 'package:base/features/profile/domain/entities/profile_entity.dart';
import 'package:base/features/profile/presentation/screens/profile_screen/profile_controller.dart';
import 'package:base/features/profile/presentation/widgets/menu_item.dart';
import 'package:base/features/profile/presentation/widgets/textInput.dart';
import 'package:base/hooks/use_fetch_obj.dart';
import 'package:base/utils/commons/widgets/widgets_common_export.dart';
import 'package:base/utils/constants/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:io';
//

@RoutePage()
class ProfileDetailsScreen extends HookConsumerWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> _formKey =
        GlobalKey<FormState>(); // Tạo key cho form
    final size = MediaQuery.sizeOf(context);
    final state = ref.watch(profileControllerProvider);

    final useFetchResult = useFetchObject<ProfileEntity>(
      function: (context) =>
          ref.read(profileControllerProvider.notifier).getUser(context),
      context: context,
    );

    // Kiểm tra xem dữ liệu đã được lấy về hay chưa
    if (useFetchResult.isFetchingData) {
      return const Center(
          child: CircularProgressIndicator()); // Hiển thị vòng tròn loading
    }

    // Kiểm tra xem dữ liệu có tồn tại hay không
    if (useFetchResult.data == null) {
      return const Center(
          child: Text('No data found')); // Thông báo không có dữ liệu
    }

    // Lấy thông tin từ dữ liệu trả về
    final user = useFetchResult.data!.user;
    File? _image;
    final Dio _dio = Dio();

    Future<void> _pickImage() async {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        // setState không dùng trong HookWidget, cần cách khác để cập nhật
        _image = File(pickedFile.path);
      }
    }

    Future<void> _updateProfile() async {
      if (!_formKey.currentState!.validate()) {
        return; // Dừng lại nếu form không hợp lệ
      }
      // Thực hiện cập nhật profile
    }

    void _saveProfile() {
      _updateProfile();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            ClipPath(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0052CC), // Blue
                      Color(0xFF00AAFF), // Light Blue
                      Color.fromARGB(255, 111, 194, 208),
                      Color.fromARGB(255, 116, 240, 231), // Pastel Light Purple
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 160,
              bottom: 100,
              right: 30,
              left: 30,
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10), // Set to 10 for rounded corners
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        10), // Set to 10 for rounded corners
                  ),
                  height: MediaQuery.of(context).size.height * .9,
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          buildTextField(
                            'Họ và tên',
                            '${user.fullName}',
                            Icons.person,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Tên không được để trống';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          buildTextField(
                            'Ngày sinh (dd/mm/yyyy)',
                            '${user.birthday}',
                            Icons.calendar_today,
                            keyboardType: TextInputType.datetime,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Ngày sinh không được để trống';
                              }
                              // Check date format (dd/mm/yyyy)
                              RegExp regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                              if (!regex.hasMatch(value)) {
                                return 'Ngày sinh phải theo định dạng dd/mm/yyyy';
                              }

                              // Parse day, month, year
                              List<String> parts = value.split('/');
                              int day = int.parse(parts[0]);
                              int month = int.parse(parts[1]);
                              int year = int.parse(parts[2]);

                              // Check month validity (1-12)
                              if (month < 1 || month > 12) {
                                return 'Tháng không hợp lệ';
                              }

                              // Days in each month
                              List<int> daysInMonth = [
                                31,
                                28,
                                31,
                                30,
                                31,
                                30,
                                31,
                                31,
                                30,
                                31,
                                30,
                                31
                              ];

                              // Leap year check for February
                              if ((year % 4 == 0 && year % 100 != 0) ||
                                  (year % 400 == 0)) {
                                daysInMonth[1] = 29;
                              }

                              if (day < 1 || day > daysInMonth[month - 1]) {
                                return 'Ngày không hợp lệ trong tháng $month';
                              }

                              return null; // Valid
                            },
                          ),
                          const SizedBox(height: 10),
                          buildTextField(
                            'Email',
                            '${user.email}',
                            Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email không được để trống';
                              }
                              // Check email contains @gmail.com
                              if (!value.contains('@gmail.com')) {
                                return 'Email phải có dạng @gmail.com';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          buildTextField(
                            'Số điện thoại',
                            '${user.phoneNumber}',
                            Icons.phone,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Số điện thoại không được để trống';
                              }

                              // Check only numbers
                              if (!RegExp(r'^\d+$').hasMatch(value)) {
                                return 'Số điện thoại chỉ được nhập số';
                              }

                              // Check digit count (e.g., 10 digits)
                              if (value.length != 10) {
                                return 'Số điện thoại phải có đúng 10 chữ số';
                              }

                              return null; // Valid
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(3),
                                        bottomLeft: Radius.circular(3),
                                      ),
                                    ),
                                    textStyle:
                                        const TextStyle(color: Colors.white),
                                  ),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _saveProfile,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 116, 240, 231),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(3),
                                        bottomRight: Radius.circular(3),
                                      ),
                                    ),
                                    textStyle:
                                        const TextStyle(color: Colors.white),
                                  ),
                                  child: const Text(
                                    'Save',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 70,
              left: MediaQuery.of(context).size.width / 2 - 65,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(75),
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    color: Colors.grey[300],
                    width: 120,
                    height: 120,
                    child: _image != null
                        ? Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            Icons.camera_alt,
                            size: 50,
                            color: Colors.grey,
                          ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 30,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
