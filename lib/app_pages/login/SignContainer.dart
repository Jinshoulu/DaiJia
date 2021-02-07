
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:demo/z_tools/app_widget/text_container.dart';
import 'package:demo/z_tools/image/AppSubmitImage.dart';
import 'package:demo/z_tools/net/LoadingView.dart';
import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

import '../../public_header.dart';

class SignContainer extends StatefulWidget {

  final Function onSuccess;

  const SignContainer({Key key,@required this.onSuccess}) : super(key: key);


  @override
  _SignContainerState createState() => _SignContainerState();
}

class _SignContainerState extends State<SignContainer> {

  //签名图片
  String signImage;
  BuildContext _buildContext;

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
  );

  @override
  void initState() {
    super.initState();

    _controller.addListener((){

    });

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextContainer(
              showBottomSlide: true,
              slideColor: AppColors.black33Color,
              alignment: Alignment.center,
              title: '协议签名确认',
              height: 50,
              style: TextStyle(
                  fontSize: Dimens.font_sp18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor
              )
          ),
          Container(
            height: 200.0,
            padding: EdgeInsets.only(left: 16,right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Signature(
                  controller: _controller,
                  height: 150.0,
                  backgroundColor: AppColors.bgColor,
                ),
                Container(
                  height: 50.0,
                  alignment: Alignment.center,
                  child: Text('您的签名会经过平台审核，如果不符合规格将不能正常接单',textAlign: TextAlign.center,style: TextStyles.blackAnd12,),
                )
              ],
            ),
          ),
          Container(
            height: 45,
            padding: EdgeInsets.only(left: 16,right: 16,top: 5,bottom: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(child: AppButton(radius: 45,title: '重签',bgColor: AppColors.redBtnColor, textStyle: TextStyles.whiteAnd14,onPress: () {
                  setState(() {
                    _controller.clear();
                  });
                })),
                SizedBox(width: 20,),
                Expanded(child: AppButton(radius: 45,title: '确认',bgColor: AppColors.mainColor, textStyle: TextStyles.whiteAnd14,onPress: () async{

                  if (_controller.isNotEmpty) {
                    final Uint8List data = await _controller.toPngBytes();
                    LoadingView.show(context);
                    uploadFile(data).then((value){
                      LoadingView.hide();
                      if(value == '失败'){
                        Toast.show('签名信息提交失败，请重试');
                      }else{
                        ImageBean bean = ImageBean.fromJson(jsonDecode(value));
                        if(bean.data!=null){
                          if(bean.data.fileurls!=null){
                            DioUtils.instance.post(Api.uploadSignImageUrl,context: context,data: {'autograph':bean.data.fileurls},onSucceed: (response){
                              Navigator.pop(context);
                              widget.onSuccess();
                            },onFailure: (code,msg){

                            });
                          }
                        }
                      }
                    });
                  }
                }))
              ],
            ),
          )

        ],
      ),
    );
  }

  Future uploadFile (Uint8List fileData) async {

    try {
      Response response;
      Map<String, dynamic> headers = new Map();

      String cookie = SpUtil.getString("cookie");
      if (cookie == null || cookie.length == 0) {
      } else {
        headers['Cookie'] = cookie;
      }
      Options options = Options(contentType: 'multipart/form-data');


      MultipartFile multipartFile =
      MultipartFile.fromBytes(fileData, filename: 'signImage.png');

      FormData formData = FormData.fromMap({
        "file": multipartFile
      });

      Dio dio = new Dio();
      response = await dio.post<String>(Api.uploadUrl, data: formData, options: options, onSendProgress: (int progress, int total) {
        print("当前进度是 $progress 总进度是 $total");
      });
      print("POST:URL=" + Api.uploadUrl);
      print("POST:StatusCode=" + response.statusCode.toString());
      print("POST:BODY=" + formData.toString());
      print("POST:RESULT=" + response.data.toString());
      print("POST:header=" + response.headers.toString());
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return "失败";
      }
    } catch (e) {
      print("失败" + "\nPOST:URL=" + Api.baseApi+Api.uploadUrl);
      print("失败" + "\nPOST:ERROR=" + e.toString());
      return "失败";
    }

  }
}


