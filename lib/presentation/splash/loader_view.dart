import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../core/app_colors.dart';

class LoaderView extends StatelessWidget {
  const LoaderView(
      {Key? key,
      required this.isAsyncCall,
      required this.child,})
      : super(key: key);
  final bool isAsyncCall;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
        color: Colors.white,
        inAsyncCall: isAsyncCall,
        opacity: 0.1,
        progressIndicator: Container(
          height: 45,
          width: 45,
          decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: const SpinKitSquareCircle(
            color: Colors.white,
            size: 20.0,
          ),
        ),
        child: child
    );
  }
}
