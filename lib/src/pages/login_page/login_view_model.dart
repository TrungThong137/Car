import 'package:car_app/src/configs/base/base.dart';
import 'package:car_app/src/pages/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../configs/widget/loading_dialog/loading_dialog.dart';
import '../../configs/widget/loading_dialog/msg_dialog.dart';
import '../../firebase/firebase_auth.dart';
import '../routers.dart';

class LoginViewModel extends BaseViewModel{

  final FireAuth fireAuth= FireAuth();

  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool isChecked=false;
  bool enableButton=false;

  String? messageEmail;
  String? messagePass;

  dynamic init(){}

  Future<void> goToSignUp () => Navigator.pushReplacementNamed(context, Routers.signUp);

  void onLoginClick() {
    LoadingDialog.showLoadingDialog(context, 'loading...');
    fireAuth.signIn(emailController.text.trim(), passController.text.trim(),
      () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.pushNamed(context, Routers.bottomNavigatorScreen);
      },(msg) {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, 'Error', msg);
    });
  }

  void setCheck(){
    isChecked=!isChecked;
    notifyListeners();
  }

  void validEmail(String value){
    final result= AppValid.validateEmail(value);
    if(result!=null){
      messageEmail=result;
    }else{
      messageEmail=null;
    }
    notifyListeners();
  }

  void validPass(String value){
    final result= AppValid.validPassword(value);
    if(result!=null){
      messagePass=result;
    }else{
      messagePass=null;
    }
    notifyListeners();
  }

  void onEnable(){
    if(messageEmail==null && messagePass==null &&
      emailController.text.trim().isNotEmpty && passController.text.trim().isNotEmpty){
      enableButton=true;
    }else{
      enableButton=false;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    passController.dispose();
    emailController.dispose();
    super.dispose();
  }
}