import 'package:base/configs/routes/app_router.dart';
import 'package:base/features/payment/presentation/widgets/button.dart';
import 'package:base/features/payment/presentation/widgets/destination.dart';
import 'package:base/features/payment/presentation/widgets/note.dart';
import 'package:base/features/payment/presentation/widgets/source.dart';
import 'package:base/features/profile/presentation/screens/change_password/change_password_controller.dart';
import 'package:base/utils/commons/widgets/widgets_common_export.dart';
import 'package:base/utils/constants/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class ChangePasswordScreen extends HookConsumerWidget {
  const ChangePasswordScreen({super.key});

  void submit({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required WidgetRef ref,
    required String email,
    required String newPassword,
    required String oldPassword,
  }) async {
    // if (formKey.currentState!.validate()) {
    // unfocus(context);

    await ref.read(changePasswordControllerProvider.notifier).changePassword(
          email: email,
          newPassword: newPassword,
          oldPassword: oldPassword,
          context: context,
        );
    print("click : done");
  }
  // else {
  //   print("Form is not valid.");
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useTextEditingController();
    final newPassword = useTextEditingController();
    final oldPassword = useTextEditingController();
    final size = MediaQuery.sizeOf(context);
    final isEmailSelected = useState(true);
    final formKey = useMemoized(GlobalKey<FormState>.new, const []);
    final state = ref.watch(changePasswordControllerProvider);

    return LoadingOverlay(
      isLoading: state.isLoading,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0052CC),
                    Color(0xFF00AAFF),
                    Color.fromARGB(255, 111, 194, 208),
                    Color.fromARGB(255, 116, 240, 231),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: Text(
                      'Change Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: const Color(0xFFF0F4FF),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "input information about your account:",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  TextInput(
                    textController: email,
                    hintTextLable: "Email",
                    hintText: 'input your email',
                    onValidate: (val) => '',
                    autoFocus: true,
                  ),
                  const SizedBox(height: 20),
                  PasswordInput(
                    textEditingController: oldPassword,
                    hintTextLable: "old password",
                    hintText: 'input your old password',
                    // onValidate: (val) => passwordErrorText(val),
                    onValidate: (val) => '',
                    autoFocus: false,
                  ),
                  const SizedBox(height: 20),
                  PasswordInput(
                    textEditingController: newPassword,
                    hintTextLable: "new password",
                    hintText: 'Input your new password',
                    // onValidate: (val) => passwordErrorText(val),
                    onValidate: (val) => '',
                    autoFocus: false,
                  ),
                  const SizedBox(height: 30),
                  ValueListenableBuilder3(
                    first: email,
                    second: oldPassword,
                    third: newPassword,
                    builder: (_, a, b, c, __) => SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        width: size.width,
                        height: size.height * 0.06,
                        content: 'Change',
                        onCallback: () {
                          submit(
                            context: context,
                            formKey: formKey,
                            ref: ref,
                            email: email.text.trim(),
                            oldPassword: oldPassword.text.trim(),
                            newPassword: newPassword.text.trim(),
                          );
                        },
                        isActive:
                            (isEmailSelected.value && a.text.isNotEmpty) &&
                                b.text.isNotEmpty,
                        size: AssetsConstants.defaultFontSize - 8.0,
                        backgroundColor:
                            (isEmailSelected.value && a.text.isNotEmpty) &&
                                    b.text.isNotEmpty
                                ? AssetsConstants.blue1
                                : AssetsConstants.blue2,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 30, 144, 255),
                            Color.fromARGB(255, 16, 78, 139),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      // child:
                      // TextButton(
                      //   onPressed:
                      //   //  _isLoading ? null : _handleChangePassword,
                      //   style: TextButton.styleFrom(
                      //     padding: const EdgeInsets.symmetric(
                      //         horizontal: 40, vertical: 15),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(5),
                      //     ),
                      //   ),
                      //   child: _isLoading
                      //       ? const CircularProgressIndicator(
                      //           color: Colors.white,
                      //         )
                      //       : const Text(
                      //           'Đổi mật khẩu',
                      //           style: TextStyle(fontSize: 16, color: Colors.white),
                      //         ),
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
