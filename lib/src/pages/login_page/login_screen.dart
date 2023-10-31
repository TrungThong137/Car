// ignore_for_file: unused_field

import 'package:car_app/src/configs/base/base.dart';
import 'package:car_app/src/configs/constants/constants.dart';
import 'package:car_app/src/configs/widget/button/button.dart';
import 'package:car_app/src/configs/widget/diaglog/dialog.dart';
import 'package:car_app/src/configs/widget/form_field/app_form_field.dart';
import 'package:car_app/src/configs/widget/text/paragraph.dart';
import 'package:car_app/src/pages/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../configs/widget/check_box/check_box.dart';
import 'components/components.dart';
import 'login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  LoginViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      viewModel: LoginViewModel(),
      onViewModelReady: (viewModel) => _viewModel=viewModel!..init(), 
      builder: (context, viewModel, child) => buildScreen(),
    );
  }

  Widget buildLogoApp(){
    return Image.asset(
      AppImages.logoAppSmall,
      color: AppColors.BLACK_500,
    );
  }

  Widget buildNameApp(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Paragraph(
          content: 'AutoTECH',
          style: STYLE_BIG.copyWith(fontWeight: FontWeight.bold)
        ),
        SizedBox(height: SpaceBox.sizeVerySmall),
        Paragraph(
          content: 'write your own journey',
          style: STYLE_SMALL.copyWith(fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Widget buildTitleLogin(){
    return Padding(
      padding: EdgeInsets.only(top: SizeToPadding.sizeBig*2),
      child: Paragraph(
        content: "Login to Your Account",
        style: STYLE_BIG.copyWith(
          fontWeight: FontWeight.w700
        ),
      ),
    );
  }

  Widget buildFieldEmail(){
    return Padding(
      padding: EdgeInsets.only(top: SizeToPadding.sizeMedium),
      child: AppFormField(
        textEditingController: _viewModel!.emailController,
        labelText: 'Email',
        hintText: 'Nhập Email',
        iconPrefix: const Icon(
          Icons.mail_outline,
          color: AppColors.BLACK_300,
        ),
        onChanged: (value) => _viewModel!..validEmail(value.trim())
          ..onEnable(),
        validator: _viewModel!.messageEmail,
      ),
    );
  }

  Widget buildFieldPassWord(){
    return AppFormField(
      textEditingController: _viewModel!.passController,
      labelText: 'Password',
      hintText: 'Nhập mật khẩu',
      obscureText: true,
      iconPrefix: const Icon(
        Icons.lock_outline_rounded,
        color: AppColors.BLACK_300,
      ),
      onChanged: (value) => _viewModel!..validPass(value.trim())
          ..onEnable(),
        validator: _viewModel!.messagePass,
    );
  }

  Widget buildSupport(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CheckBox(
          isChecked: _viewModel!.isChecked,
          content: ' Remember Me ',
          onTap: () => _viewModel!.setCheck(),
        ),
        SizedBox(width: SpaceBox.sizeLarge),
        Paragraph(
          content: 'Forgot password?',
          style: STYLE_MEDIUM.copyWith(
            color: AppColors.BLACK_400, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget buildButton(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SpaceBox.sizeLarge),
      child: AppButton(
        onTap:()=> _viewModel!.onLoginClick(),
        content: 'Sign In',
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

  Widget buildNoteSwitchSignUp(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Paragraph(
          content: 'Don\'t have an account?',
          style: STYLE_MEDIUM.copyWith(
            color: AppColors.BLACK_500,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(width: SpaceBox.sizeVerySmall,),
        InkWell(
          onTap: () => _viewModel!.goToSignUp(),
          child: Paragraph(
            content: 'Sign up',
            style: STYLE_MEDIUM.copyWith(
              color: AppColors.COLOR_MAROON,
              fontWeight: FontWeight.w600
            ),
          ),
        )
      ],
    );
  }

  Widget buildHeader(){
    return Padding(
      padding: EdgeInsets.only(top: SizeToPadding.sizeBig*2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildLogoApp(),
          const SizedBox(width: 10,),
          buildNameApp(),
        ],
      ),
    );
  }

  Widget buildScreen(){
    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () => showExitPopup(context),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: SizeToPadding.sizeMedium),
              child: Column(
                children: [
                  buildHeader(),
                  buildTitleLogin(),
                  buildFieldEmail(),
                  buildFieldPassWord(),
                  buildSupport(),
                  buildButton(),
                  buildTitleContinue(),
                  buildListItemLogin(),
                  buildNoteSwitchSignUp(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
