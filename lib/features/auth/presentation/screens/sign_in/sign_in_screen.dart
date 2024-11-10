import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:rive/rive.dart';

// config

// utils
import 'package:base/utils/constants/asset_constant.dart';
import 'package:base/utils/commons/widgets/widgets_common_export.dart';
import 'package:base/utils/commons/functions/functions_common_export.dart';
import 'package:base/utils/resources/validations.dart';

// controller
import 'package:base/features/auth/presentation/widgets/custom_scaford.dart';
import 'package:base/features/auth/presentation/screens/sign_in/sign_in_controller.dart';

// SharedPreferences for token management

// AuthService for login

@RoutePage()
class SignInScreen extends HookConsumerWidget with Validations {
  SignInScreen({super.key});

  // handle submit
  void submit({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required WidgetRef ref,
    required String email,
    required String password,
  }) async {
    if (formKey.currentState!.validate()) {
      unfocus(context);
      await ref.read(signInControllerProvider.notifier).signIn(
            email: email,
            password: password,
            context: context,
          );
      print("click : done");
    } else {
      print("Form is not valid.");
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final email = useTextEditingController();
    final password = useTextEditingController();
    final formKey = useMemoized(GlobalKey<FormState>.new, const []);
    final isEmailSelected = useState(true);

    final state = ref.watch(signInControllerProvider);
    print("state: ${state.isLoading}");
    return LoadingOverlay(
      isLoading: state.isLoading,
      child: CustomScaffold(
        child: Column(
          children: [
            const Expanded(flex: 1, child: SizedBox(height: 10)),
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 20.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Rive Animation
                        SizedBox(
                          height: 250,
                          width: 550,
                          child: RiveAnimation.asset(
                            'assets/images/animated_login_character_.riv',
                            fit: BoxFit.fitHeight,
                            stateMachines: const ["Login Machine"],
                            onInit: (artboard) {
                              final controller =
                                  StateMachineController.fromArtboard(
                                      artboard, "Login Machine");
                              if (controller != null) {
                                artboard.addController(controller);
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 25.0),

                        // Email / Phone toggle section
                        LabelText(
                          content: 'Đăng nhập'.toUpperCase(),
                          size: AssetsConstants.defaultFontSize - 2.0,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 20.0),
                        const SizedBox(height: 25.0),

                        if (isEmailSelected.value) ...[
                          TextInput(
                            textController: email,
                            hintTextLable: "Email",
                            hintText: 'Nhập email của bạn',
                            onValidate: (val) => emailErrorText(val),
                            autoFocus: true,
                          ),
                          const SizedBox(height: 25.0),
                        ],

                        PasswordInput(
                          textEditingController: password,
                          hintTextLable: "Mật khẩu",
                          hintText: 'Nhập mật khẩu',
                          // onValidate: (val) => passwordErrorText(val),
                          onValidate: (val) => '',
                          autoFocus: false,
                        ),
                        const SizedBox(height: 25.0),

                        ValueListenableBuilder2(
                          first: email,
                          second: password,
                          builder: (_, a, b, __) => SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              width: size.width,
                              height: size.height * 0.06,
                              content: 'Đăng nhập',
                              onCallback: () {
                                submit(
                                  context: context,
                                  formKey: formKey,
                                  ref: ref,
                                  email: email.text.trim(),
                                  password: password.text.trim(),
                                );
                              },
                              isActive: (isEmailSelected.value &&
                                      a.text.isNotEmpty) &&
                                  b.text.isNotEmpty,
                              size: AssetsConstants.defaultFontSize - 8.0,
                              backgroundColor: (isEmailSelected.value &&
                                          a.text.isNotEmpty) &&
                                      b.text.isNotEmpty
                                  ? AssetsConstants.blue1
                                  : AssetsConstants.blue2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
