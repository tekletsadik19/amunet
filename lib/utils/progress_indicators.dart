import 'package:flutter/material.dart';

circularProgress(context){
  return Container(
    alignment: Alignment.center,
    padding:const EdgeInsets.only(top: 10),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
    ),
  );
}
linearProgress(context){
  return Container(
    alignment: Alignment.topCenter,
    padding:const EdgeInsets.only(bottom: 10),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor),
    ),
  );
}