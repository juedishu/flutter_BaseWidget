
import 'dart:async';

import 'package:flutter_base_widget/network/api.dart';
import 'package:flutter_base_widget/network/intercept/base_intercept.dart';
import 'package:rxdart/subjects.dart';


/// T 是最终要得到的 数据类型
abstract class ResponseTransform<T> {

  Completer<T> publishSubject;
  BaseIntercept baseIntercept;

  ResponseTransform();

  void apply(String data);


  void add(T data){
    publishSubject.complete(data);
    cancelLoading();
  }

  void setPublishPubject(Completer publishSubject2){
    publishSubject=publishSubject2;
  }

  void setBaseIntercept(BaseIntercept baseIntercept2){
    baseIntercept=baseIntercept2;
  }


  void cancelLoading() {
    if (baseIntercept != null) {
      baseIntercept.afterRequest();
    }
  }


  ///请求错误以后 做的一些事情
  void callError(MyError error) {
    if(publishSubject!=null) {
      publishSubject.completeError(error);
    }
    cancelLoading();
    if (baseIntercept != null) {
      baseIntercept.requestFailure(error.message);
    }
  }



}
