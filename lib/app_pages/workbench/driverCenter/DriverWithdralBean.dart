
class DriverWithdralBean {
    String headimg;
    int id;
    String msg;
    String nickname;
    int type;

    DriverWithdralBean({this.headimg, this.id, this.msg, this.nickname, this.type});

    factory DriverWithdralBean.fromJson(Map<String, dynamic> json) {
        return DriverWithdralBean(
            headimg: json['headimg'], 
            id: json['id'], 
            msg: json['msg'], 
            nickname: json['nickname'], 
            type: json['type'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['headimg'] = this.headimg;
        data['id'] = this.id;
        data['msg'] = this.msg;
        data['nickname'] = this.nickname;
        data['type'] = this.type;
        return data;
    }
}