import 'package:expense_manager/models/payment_model.dart';
import 'package:expense_manager/models/user_model.dart';

class Materials{



  String materialName;
  String unit;
  String quantity;


  String unitPrice;
  String total;
  Vendor vendor;
  String datePurchsed;
  Usr buyour;

  
  Materials({this.materialName, this.quantity, this.unitPrice,this.total,this.unit,
  this.vendor,this.datePurchsed,this.buyour});

  Map<String, dynamic> toMap() => {
  
  'materialName': materialName,
  'quantity':quantity,
  'unitPrice':unitPrice,
  'unit':this.unit==null?'Unit':this.unit,
  'total':total,
  'vendor':vendor.toMap(),
  'datePurchsed':this.datePurchsed==null?DateTime.now().toString():this.datePurchsed,
  'buyour':buyour.toMap(),

  };
  Materials.fromMap(Map<String, dynamic> map) {
    this.materialName = map['materialName'];
    this.quantity = map['quantity'];
    this.unitPrice = map['unitPrice'];

    this.total = map['total'];
    this.vendor =Vendor.fromMap( map['vendor']);
    this.datePurchsed = map['datePurchsed'];

    this.buyour =Usr.fromMap( map['buyour']);
    this.unit=map['unit'];


  }
}
