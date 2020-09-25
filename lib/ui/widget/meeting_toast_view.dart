
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MeetingToastView {
  OverlayEntry overlayEntry;
  OverlayState overlayState;
  bool dismissed = false;

  show() async {
    overlayState.insert(overlayEntry);
    await Future.delayed(Duration(seconds: 3));
    this.dismiss();
  }

  dismiss() async {
    if(dismissed) return;
    dismissed = true;
    overlayEntry?.remove();
  }
}

class MeetingToastViewHelper{
  static OverlayState overlayState;
  static show(BuildContext context, String msg){
    if(overlayState == null){
      overlayState = Overlay.of(context);
    }
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return buildToastLayout(msg);
    });
    var meetingToastView = MeetingToastView();
    meetingToastView.overlayState = overlayState;
    meetingToastView.overlayEntry = overlayEntry;
    meetingToastView.show();
  }

  static LayoutBuilder buildToastLayout(String msg){
    return LayoutBuilder(
        builder: (context, constraints){
          return IgnorePointer(
            ignoring: true,
            child: Container(
              child: Material(
                color: Colors.white.withOpacity(0),
                child: Container(
                  child: Text(
                    "$msg",
                    style: TextStyle(color: Colors.black),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.all(Radius.circular(5),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
              margin: EdgeInsets.only(
                bottom: constraints.biggest.height*0.15,
                left: constraints.biggest.width*0.2,
                right: constraints.biggest.width*0.2,
              ),
              alignment: Alignment(0, -0.6),
            ),
          );
        }
    );
  }
}
