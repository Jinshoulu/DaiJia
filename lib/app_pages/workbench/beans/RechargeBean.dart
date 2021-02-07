
class RechargeBean {
    String imoney;
    List<Data> list;
    String phone;

    RechargeBean({this.imoney, this.list, this.phone});

    factory RechargeBean.fromJson(Map<String, dynamic> json) {
        return RechargeBean(
            imoney: json['imoney'], 
            list: json['list'] != null ? (json['list'] as List).map((i) => Data.fromJson(i)).toList() : null, 
            phone: json['phone'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['imoney'] = this.imoney;
        data['phone'] = this.phone;
        if (this.list != null) {
            data['list'] = this.list.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Data {
    int id;
    String money;
    int money_int;

    Data({this.id, this.money, this.money_int});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            id: json['id'], 
            money: json['money'].toString(),
            money_int: json['money_int'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['money'] = this.money;
        data['money_int'] = this.money_int;
        return data;
    }
}