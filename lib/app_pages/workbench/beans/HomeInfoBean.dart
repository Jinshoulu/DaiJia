
class HomeInfoBean {
    int dmoney_count;
    int dorder_count;
    int dstatus;
    int minutes;
    List<Noticelist> noticelist;
    String tmoney;
    int torder;

    HomeInfoBean({this.dmoney_count, this.dorder_count, this.dstatus, this.minutes, this.noticelist, this.tmoney, this.torder});

    factory HomeInfoBean.fromJson(Map<String, dynamic> json) {
        return HomeInfoBean(
            dmoney_count: json['dmoney_count'], 
            dorder_count: json['dorder_count'], 
            dstatus: json['dstatus'], 
            minutes: json['minutes'], 
            noticelist: json['noticelist'] != null ? (json['noticelist'] as List).map((i) => Noticelist.fromJson(i)).toList() : null, 
            tmoney: json['tmoney'].toString(),
            torder: json['torder'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['dmoney_count'] = this.dmoney_count;
        data['dorder_count'] = this.dorder_count;
        data['dstatus'] = this.dstatus;
        data['minutes'] = this.minutes;
        data['tmoney'] = this.tmoney;
        data['torder'] = this.torder;
        if (this.noticelist != null) {
            data['noticelist'] = this.noticelist.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Noticelist {
    int id;
    String title;

    Noticelist({this.id, this.title});

    factory Noticelist.fromJson(Map<String, dynamic> json) {
        return Noticelist(
            id: json['id'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['title'] = this.title;
        return data;
    }
}