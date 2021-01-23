
class SpotCheckBean {
    String create_time;
    List fileurls;
    String format_time;
    int id;
    String msg;
    int num;
    int status;
    int time;
    String up_time;

    SpotCheckBean({this.create_time, this.fileurls, this.format_time, this.id, this.msg, this.num, this.status, this.time, this.up_time});

    factory SpotCheckBean.fromJson(Map<String, dynamic> json) {
        return SpotCheckBean(
            create_time: json['create_time'].toString(),
            fileurls: json['fileurls'] != null ? (json['fileurls'] is List)?json['fileurls']:null : null,
            format_time: json['format_time'].toString(),
            id: json['id'], 
            msg: json['msg'], 
            num: json['num'], 
            status: json['status'], 
            time: json['time'], 
            up_time: json['up_time'].toString(),
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['create_time'] = this.create_time;
        data['format_time'] = this.format_time;
        data['id'] = this.id;
        data['msg'] = this.msg;
        data['num'] = this.num;
        data['status'] = this.status;
        data['time'] = this.time;
        data['up_time'] = this.up_time;
        if (this.fileurls != null) {
            data['fileurls'] = this.fileurls;
        }
        return data;
    }
}