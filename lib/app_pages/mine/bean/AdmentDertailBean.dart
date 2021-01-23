
/*
{
    "id": 2,//公告ID
    "title": "公告1",//公告标题
    "content": "<p>你还好吗？gvv</p>",//公告内容（富文本）
    "seconds": 100,//需要时长（秒）
    "create_time": "2020-12-19 14:28:32",//添加时间
    "format_seconds": "01:40",//需要时长
    "status": 0,//状态：0未学习1已学习2学习中
    "time": 0,//已学习时长(秒)
    "format_time": "00:00",//已学习时长
    "have_time": 100,//剩余学习时长（秒）
    "format_have_time": "01:40",//剩余学习时长
    "msg": "未学习"//状态说明
  }
 */

///公告详情
class AdmentDetailBean {
    String content;
    String create_time;
    String format_have_time;
    String format_seconds;
    String format_time;
    int have_time;
    int id;
    String msg;
    int seconds;
    int status;
    int time;
    String title;

    AdmentDetailBean({this.content, this.create_time, this.format_have_time, this.format_seconds, this.format_time, this.have_time, this.id, this.msg, this.seconds, this.status, this.time, this.title});

    factory AdmentDetailBean.fromJson(Map<String, dynamic> json) {
        return AdmentDetailBean(
            content: json['content'], 
            create_time: json['create_time'], 
            format_have_time: json['format_have_time'].toString(),
            format_seconds: json['format_seconds'].toString(),
            format_time: json['format_time'].toString(),
            have_time: json['have_time'], 
            id: json['id'], 
            msg: json['msg'], 
            seconds: json['seconds'], 
            status: json['status'], 
            time: json['time'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['content'] = this.content;
        data['create_time'] = this.create_time;
        data['format_have_time'] = this.format_have_time;
        data['format_seconds'] = this.format_seconds;
        data['format_time'] = this.format_time;
        data['have_time'] = this.have_time;
        data['id'] = this.id;
        data['msg'] = this.msg;
        data['seconds'] = this.seconds;
        data['status'] = this.status;
        data['time'] = this.time;
        data['title'] = this.title;
        return data;
    }
}