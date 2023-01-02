class listModel {
  int? status;
  String? message;
  Data? data;

  listModel({this.status, this.message, this.data});

  listModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  OrderInfo? orderInfo;
  int? totalRecord;

  Data({this.orderInfo, this.totalRecord});

  Data.fromJson(Map<String, dynamic> json) {
    orderInfo = json['orderInfo'] != null
        ? new OrderInfo.fromJson(json['orderInfo'])
        : null;
    totalRecord = json['total_record'];
  }
}

class OrderInfo {
  List<Orders>? orders;

  OrderInfo({this.orders});

  OrderInfo.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
  }
}

class Orders {
  int? orderId;

  int? sequenceNo;

  String? orderType;

  String? expectedDate;

  Orders({
    this.orderId,
    this.sequenceNo,
    this.orderType,
    this.expectedDate,
  });

  Orders.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];

    sequenceNo = json['sequence_no'];

    orderType = json['order_type'];

    expectedDate = json['expected_date'];
  }
}
