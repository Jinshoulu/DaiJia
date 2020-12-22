import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../public_header.dart';



class LoadingView {
 static  GlobalKey dialogKey;
  static hide() {
    if (dialogKey!=null&&dialogKey.currentContext != null) {
      Navigator.pop(dialogKey.currentContext);
      dialogKey = null;
    }
  }

  static show(BuildContext context) {
    hide();
    if (context != null) {
      dialogKey = GlobalKey();
      showGeneralDialog(
        context: context,
        barrierLabel: "",
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 1),
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          return Center(
            key: dialogKey,
            child: Loading(),
          );
        },
      );
    }
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      child: new Material(
        borderOnForeground: false,
        color: Colors.transparent,
        child: new Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color(0x00000000),
          child: new Center(
            child: new Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              decoration: new BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(3),
              ),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // SpinKitPouringHourglass(
                  //   color: AppColors.primary_color,
                  //   size: 20,
                  // )
                  Container(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(AppColors.mainColor),
                    // backgroundColor: AppColors.mainColor,//Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () {
        return Future.value(false);
      },
    );
  }
}
