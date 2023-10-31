import 'package:car_app/src/configs/base/base.dart';
import 'package:car_app/src/pages/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../configs/widget/loading_dialog/loading_dialog.dart';
import '../../configs/widget/loading_dialog/msg_dialog.dart';
import '../../firebase/firebase_auth.dart';
import '../routers.dart';

class SignUpViewModel extends BaseViewModel{

  FireAuth fireAuth=FireAuth();
  
  TextEditingController nameController= TextEditingController();
  TextEditingController passController= TextEditingController();
  TextEditingController phoneController= TextEditingController();
  TextEditingController emailController= TextEditingController();
  TextEditingController cnfController= TextEditingController();

  String? messageName;
  String? messagePhone;
  String? messageEmail;
  String? messagePassword;
  String? messageConfirmPass;

  bool enableButton=false;
  bool isPassword=false;
  bool isConfirmPass=false;

  dynamic init(){}

  Future<void> goToSignIn () => Navigator.pushReplacementNamed(context, Routers.signIn);

  void validateEmail(String? value){
    final result= AppValid.validateEmail(value);
    if(result!=null){
      messageEmail=result;
    }else{
      messageEmail=null;
    }
    notifyListeners();
  }

  void validatePhone(String? value){
    final result= AppValid.validatePhoneNumber(value);
    if(result!=null){
      messagePhone=result;
    }else{
      messagePhone=null;
    }
    notifyListeners();
  }

  void validateName(String? value){
    final result= AppValid.validateFullName(value);
    if(result!=null){
      messageName=result;
    }else{
      messageName=null;
    }
    notifyListeners();
  }

  void validPass(String? value, String? confirmPass) {
    final result = AppValid.validPassword(value);
    if (result != null) {
      messagePassword = result;
    } else {
      messagePassword = null;
    }
    if (confirmPass!.isNotEmpty) {
      final result = AppValid.validatePasswordConfirm(value!, confirmPass);
      if (result != null) {
        messageConfirmPass = result;
      } else {
        messageConfirmPass = null;
      }
    }
    notifyListeners();
  }

  void validConfirmPass(String? confirmPass, String? pass) {
    final result = AppValid.validatePasswordConfirm(pass!, confirmPass);
    if (result != null) {
      messageConfirmPass = result;
    } else {
      messageConfirmPass = null;
    }
    notifyListeners();
  }

  void onSignUp() {
    if (messagePhone == null && messageEmail==null
      && messageName==null && messageConfirmPass==null && messagePassword==null) {
      enableButton = true;
    } else {
      enableButton = false;
    }
    notifyListeners();
  }

  void onSignUpClicked(){
    LoadingDialog.showLoadingDialog(context, 'Loading...');
    fireAuth.signUp(
      emailController.text.toString().trim(), 
      passController.text.toString().trim(),
      nameController.text.toString().trim(),
      phoneController.text.toString().trim(),
      (){
        LoadingDialog.hideLoadingDialog(context);
          Navigator.pushNamed(context, Routers.bottomNavigatorScreen);
      },
      (msg){
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, 'Sign-In', msg);
      }
    );
    notifyListeners();
  }
    
}