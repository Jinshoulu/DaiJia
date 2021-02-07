
class HomePushScoreBean {
    int cre_order;
    int push_dri;
    int push_user;
    int share_user;

    HomePushScoreBean({this.cre_order, this.push_dri, this.push_user, this.share_user});

    factory HomePushScoreBean.fromJson(Map<String, dynamic> json) {
        return HomePushScoreBean(
            cre_order: json['cre_order'],
            push_dri: json['push_dri'],
            push_user: json['push_user'],
            share_user: json['share_user'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['cre_order'] = this.cre_order;
        data['push_dri'] = this.push_dri;
        data['push_user'] = this.push_user;
        data['share_user'] = this.share_user;
        return data;
    }
}