import 'package:expense_manager/models/payment_model.dart';
import 'package:expense_manager/models/user_model.dart';

class Material{



  String materialName;
  String quantity;
  String costPerItem;
  String total;
  Vendor vendor;
  String datePurchsed;
  Usr buyour;

  
  Material({this.materialName, this.quantity, this.costPerItem,this.total,
  this.vendor,this.datePurchsed,this.buyour});

  Map<String, dynamic> toMap() => {
  
  'materialName': materialName,
  'quantity':quantity,
  'costPerItem':costPerItem,
  'total':total,
  'vendor':vendor.toMap(),
  'datePurchsed':datePurchsed,

  'buyour':buyour.toMap(),

  };
  Material.fromMap(Map<String, dynamic> map) {
    this.materialName = map['materialName'];
    this.quantity = map['quantity'];
    this.costPerItem = map['costPerItem'];

    this.total = map['total'];
    this.vendor =Vendor.fromMap( map['vendor']);
    this.datePurchsed = map['datePurchsed'];

    this.buyour =Usr.fromMap( map['buyour']);


  }
}
