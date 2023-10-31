// ignore_for_file: unused_field

import 'package:car_app/src/configs/base/base.dart';
import 'package:car_app/src/configs/widget/button/button.dart';
import 'package:car_app/src/configs/widget/diaglog/dialog.dart';
import 'package:car_app/src/pages/register_page/sign_up_view_model.dart';
import 'package:car_app/src/pages/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../configs/constants/constants.dart';
import '../../configs/widget/form_field/app_form_field.dart';
import '../../configs/widget/text/paragraph.dart';
import 'components/components.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  SignUpViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      viewModel: SignUpViewModel(), 
      builder: (context, viewModel, child) => buildScreen(),
      onViewModelReady: (viewModel) => _viewModel=viewModel!..init(),
    );
  }

  Widget buildLogo(){
    return Image.asset(AppImages.logoAppBig, color: AppColors.BLACK_500,);
  }

  Widget buildTitleSignUp(){
    return Paragraph(
      content: "Sign up Your Account",
      style: STYLE_LARGE_BIG.copyWith(fontWeight: FontWeight.w700), 
    );
  }

  Widget buildFieldName(){
    return Padding(
      padding: EdgeInsets.only(top: SizeToPadding.sizeBig),
      child: AppFormField(
        labelText: 'Họ và Tên',
        hintText: 'Nhập Họ Tên',
        textEditingController: _viewModel!.nameController,
        iconPrefix: const Icon(Icons.person_outline, color: Colors.black26,),
        validator: _viewModel!.messageName,
        onChanged: (value) => _viewModel!..validateName(value.trim())..onSignUp(),
      ),
    );
  }

  Widget buildFieldPhone(){
    return AppFormField(
      labelText: 'Số điện thoại',
      hintText: 'Nhập số điện thoại',
      textEditingController: _viewModel!.phoneController,
      iconPrefix: const Icon(Icons.phone_outlined, color: Colors.black26,),
      validator: _viewModel!.messagePhone,
      onChanged:(value) => _viewModel!..validatePhone(value.trim())..onSignUp(),
    );
  }

  Widget buildFieldEmail(){
    return AppFormField(
      labelText: 'Email',
      hintText: 'Nhập Email',
      textEditingController: _viewModel!.emailController,
      iconPrefix: const Icon(Icons.mail_outline, color: Colors.black26,),
      validator: _viewModel!.messageEmail,
      onChanged: (value) => _viewModel!..validateEmail(value.trim())..onSignUp(),
    );
  }

  Widget buildFieldPassWord(){
    return AppFormField(
      textEditingController: _viewModel!.passController,
      labelText: 'Mật khẩu',
      hintText: 'Nhập số mật khẩu',
      obscureText: true,
      iconPrefix: const Icon(Icons.lock_outlined, color: Colors.black26,),
      validator: _viewModel!.messagePassword,
      onChanged: (value) => 
        _viewModel!..validPass(value, _viewModel!.cnfController.text.trim())
        ..onSignUp(),
    );
  }

  Widget buildFieldConfirmPass(){
    return AppFormField(
      textEditingController: _viewModel!.cnfController,
      labelText: 'Xác nhận mật khẩu',
      hintText: 'Nhập lại mật khẩu',
      obscureText: true,
      iconPrefix: const Icon(Icons.lock_outlined, color: Colors.black26,),
      validator: _viewModel!.messageConfirmPass,
      onChanged: (value) => 
        _viewModel
        !..validConfirmPass(value.trim(), _viewModel!.passController.text.trim())
        ..onSignUp(),
    );
  }

  Widget buildButtonSignUp(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeToPadding.sizeMedium),
      child: AppButton(
        onTap: ()=> _viewModel!.onSignUpClicked(),
        content: 'Sign up',
        enableButton: _viewModel!.enableButton,
      ),
    );
  }

  Widget buildTitleContinue(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SideBar(),
        Paragraph(
          content: '   or continue with   ',
          style: STYLE_MEDIUM.copyWith(
            color: const Color.fromARGB(255, 98, 95, 95),
            fontWeight: FontWeight.w500
          ),
        ),
        const SideBar(),
      ],
    );
  }

  Widget buildListItemLogin(){
    return Padding(
      padding: EdgeInsets.all(SpaceBox.sizeLarge,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SocialIcon(onTap: () {}, iconPath: AppImages.logoFB),
          SocialIcon(onTap: () {}, iconPath: AppImages.logoGG),
          SocialIcon(onTap: () {}, iconPath: AppImages.logoApple)
        ],
      ),
    );
  }

  Widget buildNoteSwitchLogin(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Paragraph(
          content: 'Already have an account? ',
          style: STYLE_MEDIUM.copyWith(
            color: AppColors.BLACK_500,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(width: SpaceBox.sizeVerySmall,),
        InkWell(
          onTap: () => _viewModel!.goToSignIn(),
          child: Paragraph(
            content: 'SignIn',
            style: STYLE_MEDIUM.copyWith(
              color: AppColors.COLOR_MAROON,
              fontWeight: FontWeight.w600
            ),
          ),
        )
      ],
    );
  }

  Widget buildScreen(){
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: SizeToPadding.sizeBig, 
            horizontal: SizeToPadding.sizeMedium),
          child: Column(
            children: [
              buildLogo(),
              buildTitleSignUp(),
              buildFieldName(),
              buildFieldPhone(),
              buildFieldEmail(),
              buildFieldPassWord(),
              buildFieldConfirmPass(),
              buildButtonSignUp(),
              buildTitleContinue(),
              buildListItemLogin(),
              buildNoteSwitchLogin(),
            ],
          ),
        ),
      ),
    );
  }
}
