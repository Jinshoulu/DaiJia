
class CustomerPhoneBean {
    String kefu_phone;
    List<String> siguan_phone;

    CustomerPhoneBean({this.kefu_phone, this.siguan_phone});

    factory CustomerPhoneBean.fromJson(Map<String, dynamic> json) {
        return CustomerPhoneBean(
            kefu_phone: json['kefu_phone'], 
            siguan_phone: json['siguan_phone'] != null ? new List<String>.from(json['siguan_phone']) : null, 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['kefu_phone'] = this.kefu_phone;
        if (this.siguan_phone != null) {
            data['siguan_phone'] = this.siguan_phone;
        }
        return data;
    }
}