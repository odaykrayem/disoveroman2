import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../common/values/color.dart';

AppBar buildAppBar(){
  return  AppBar(
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1.0),
      child: Container(
        color: Colors.black54.withOpacity(1),
        // height defines the thickness of the line
        height: 1,
      ),
    ),
    title: Center(
      child: Text(
        "Log In",
        style: TextStyle(
          color: Colors.black54,
          fontSize: 25.sp,
          fontWeight: FontWeight.normal,
          fontFamily: "BebasNeue",

        ),
      ),
    ),
  );
}

//we need context to accessing bloc
Widget buildThirdPartyLogin(BuildContext context){
  return Container(
    margin: EdgeInsets.only(top: 40.h, bottom: 20.h, ),
    padding: EdgeInsets.only(left: 100.w,right: 100.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _reusableIcons("google"),
        _reusableIcons("apple"),
        _reusableIcons("facebook"),
      ],
    )

  );
}

Widget _reusableIcons(String iconName){
  return GestureDetector(
    onTap: (){

    },
    child: Container(
      width: 40.w,
      height: 40.w,
      child: Image.asset("assets/icons/$iconName.png"),
    ),
  );
}

Widget reusableText(String text){
  return Container(
    margin: EdgeInsets.only(bottom: 5.h),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.black38.withOpacity(0.4),
        fontSize: 19.sp,
        fontWeight: FontWeight.normal,
        fontFamily: "BebasNeue"
      ),
    ),

  );
}

Widget buildTextField(String hintText, textType, String iconName,
    void Function(String value)? func

    ){
  return Container(
    margin: EdgeInsets.only(bottom: 20.h),
    width: 325.w,
    height: 50.h,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(15.w)),
      border: Border.all(color: AppColors.primaryFourthElementText),
      
    ),
    child:Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 17.w),
          width: 16.w,
          height: 16.w,
          child: Image.asset("assets/icons/$iconName.png"),
        ),
        //Keyboard
        SizedBox(
          child: Container(
            width: 270.w,
            height: 50.h,
            child:  TextField(
              onChanged: (value)=>func!(value),
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: hintText,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent
                  )
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  )
                ),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    )
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    )
                ),
                hintStyle: const TextStyle(
                  color: AppColors.primarySecondaryElementText,
                ),

              ),
              style: TextStyle(
                color: AppColors.primaryText,
               // fontFamily: "Lobster",
                fontWeight: FontWeight.normal,
                fontSize: 17.sp,
              ),
              autocorrect: false,
              obscureText: textType=="password"?true:false,
            ),

          ),
        )
      ],
    )
  );
}

Widget forgetPassword(){
  return Container(
    margin: EdgeInsets.only(left: 25.w),
    width: 260.w,
    height: 44.h,
    child: GestureDetector(
      onTap: (){

      },
      child: Text(
        "Forget password",
        style: TextStyle(
          color: AppColors.primaryText,
          fontSize: 16.w,
          decoration: TextDecoration.underline,
          decorationColor: AppColors.primaryText,
          fontFamily: "BebasNeue"
        ),
      ),
    ),
  );
}

Widget buildLogInAdnRegButton(String buttonName,String buttonType, void Function()? func){
  return GestureDetector(
    onTap: func,
    child: Container(
      width: 325.w,
      height: 50.h,
      margin: EdgeInsets.only(left: 25.w,right: 25.w,top: buttonType=="login"?40.h:10.h),
      decoration: BoxDecoration(
          color: buttonType == "login" ? AppColors.primaryElement : AppColors.primaryBackground,
          borderRadius: BorderRadius.circular(15.w),
          border: Border.all(
            color: buttonType=="login"?Colors.transparent:AppColors.primaryFourthElementText,
          ) ,
        boxShadow:[
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0,1),
            color: Colors.grey.withOpacity(0.4),
        )]
      ),
      child: Center(
          child: Text(
            buttonName,
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.normal,
              fontFamily: "BebasNeue",
              color:buttonType == "login" ?AppColors.primaryBackground: AppColors.primaryText,
            ),
          )
      ),

    ),

  );
}

