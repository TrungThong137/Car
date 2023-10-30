import 'dart:io';

class AppValid {
  AppValid._();
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập Họ và tên';
    } else if (value.length < 6) {
      return 'Tên phải trên 6 kí tự';
    }
    final regex = RegExp(
      r'^[a-z A-ZỳọáầảấờễàạằệếýộậốũứĩõúữịỗìềểẩớặòùồợãụủíỹắẫựỉỏừỷởóéửỵẳẹèẽổẵẻỡơôưăêâđỲỌÁẦẢẤỜỄÀẠẰỆẾÝỘẬỐŨỨĨÕÚỮỊỖÌỀỂẨỚẶÒÙỒỢÃỤỦÍỸẮẪỰỈỎỪỶỞÓÉỬỴẲẸÈẼỔẴẺỠƠÔƯĂÊÂĐ]+$',
    );
    if (!regex.hasMatch(value)) {
      return 'Không được nhập kí tự đặc biệt';
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập tên của bạn';
    } else if (value.length < 2) {
      return 'Tên phải trên 2 kí tự';
    }
    final regex = RegExp(
      r'^[a-z A-ZỳọáầảấờễàạằệếýộậốũứĩõúữịỗìềểẩớặòùồợãụủíỹắẫựỉỏừỷởóéửỵẳẹèẽổẵẻỡơôưăêâđỲỌÁẦẢẤỜỄÀẠẰỆẾÝỘẬỐŨỨĨÕÚỮỊỖÌỀỂẨỚẶÒÙỒỢÃỤỦÍỸẮẪỰỈỎỪỶỞÓÉỬỴẲẸÈẼỔẴẺỠƠÔƯĂÊÂĐ]+$',
    );
    if (!regex.hasMatch(value)) {
      return 'Không được nhập kí tự đặc biệt';
    }
    return null;
  }

  static String? validPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (value.length < 8 || value.length > 16) {
      return 'Mật khẩu phải lớn hơn 8 kí tự và nhỏ hơn 16 kí tự';
    }
    return null;
  }

  static String? validatePasswordConfirm(String pass, String? confirmPass) {
    if (confirmPass == null || confirmPass.isEmpty) {
      return 'Vui lòng xác nhận mật khẩu';
    }
    if (confirmPass != pass) {
      return 'Mật khẩu xác nhận không trùng khớp';
    }
    return null;
  }

  static String? validateChangePass(String passOld, String? passNew) {
    if (passOld == passNew) {
      return 'Mật khẩu mới không được trùng với mật khẩu cũ';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập email';
    } else {
      final regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      );

      if (!regex.hasMatch(value)) {
        return 'Email không hợp lệ';
      } else {
        return null;
      }
    }
  }

  static String? validateVerificationCode(String? value) {
    final regex = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
    if (value == null || value.isEmpty) {
      return '';
    } else if (value.length != 6 && !regex.hasMatch(value)) {
      return '';
    } else {
      return null;
    }
  }

  static String? validAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập địa chỉ của bạn';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? value) {
    final regex = RegExp(r'^(?:[+0]9)?[0-9]{10}$');
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập số điện thoại';
    } else {
      final checkPhoneNumber = value.split('')[0];
      if (checkPhoneNumber != '0') {
        return 'Số điện thoại không hợp lệ';
      }
      if (value.length != 10) {
        return 'Số điện thoại không được nhỏ hơn hoặc lớn hơn 10 số';
      } else if (!regex.hasMatch(value)) {
        return 'Không được nhập kí tự đặc biệt và chữ';
      } else {
        return null;
      }
    }
  }

  static bool isNetWork(dynamic value) {
    if (value is SocketException) {
      return false;
    }
    return true;
  }

  static bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }
}
