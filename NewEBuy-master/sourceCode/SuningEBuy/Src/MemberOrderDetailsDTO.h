//
//  MemberOrderDetails.h
//  SuningEMall
//
//  Created by lcj lcj on 11-1-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"

@interface MemberOrderDetailsDTO : BaseHttpDTO {
	NSString	*_productCode;
	NSString	*_productId;
	NSString	*_productName;
	NSString	*_quantityInIntValue;
	NSString	*_totalProduct;
	NSString	*_posOrderNumber;
	NSString	*_verificationCode;
	NSString	*_currentShipModeType;
	NSString	*_taxType;
	NSString	*_itemPlacerName;
	NSString	*_itemMobilePhone;
	NSString	*_address;
	NSString	*_invoice;
	NSString	*_invoiceDescription;
	NSString	*_exWarrantyQuantity;
	NSString	*_exWarrantyPrice;
	NSString	*_exWarrantyName;
	NSString	*_exWarrantyFlag;
    NSString    *_orderItemId;
	
	NSURL		*_imageURL;
}

@property	(nonatomic,copy)	NSString	*orderItemId;

@property	(nonatomic,copy)    NSString	*oiStatus;

@property	(nonatomic,copy)    NSString	*policyDesc;

@property	(nonatomic,copy)	NSString	*productCode;
@property	(nonatomic,copy)	NSString	*productId;
@property	(nonatomic,copy)	NSString	*productName;
@property	(nonatomic,copy)	NSString	*quantityInIntValue;
@property	(nonatomic,copy)	NSString	*totalProduct;
@property	(nonatomic,copy)	NSString	*posOrderNumber;
@property	(nonatomic,copy)	NSString	*verificationCode;
@property	(nonatomic,copy)	NSString	*currentShipModeType;
@property	(nonatomic,copy)	NSString	*taxType;
@property	(nonatomic,copy)	NSString	*itemPlacerName;
@property	(nonatomic,copy)	NSString	*itemMobilePhone;
@property	(nonatomic,copy)	NSString	*address;
@property	(nonatomic,copy)	NSString	*invoice;
@property	(nonatomic,copy)	NSString	*invoiceDescription;
@property	(nonatomic,copy)	NSString	*exWarrantyQuantity;
@property	(nonatomic,copy)	NSString	*exWarrantyPrice;
@property	(nonatomic,copy)	NSString	*exWarrantyName;
@property	(nonatomic,copy)	NSString	*exWarrantyFlag;
@property	(nonatomic,strong)	NSURL		*imageURL;
@property   (nonatomic,copy)    NSString    *isBundle;//小套餐标识

@property	(nonatomic,copy)	NSString	*supplierCode;
@property	(nonatomic,copy)	NSString	*cShopName;
@property	(nonatomic,copy)	NSString	*orderId;

@property	(nonatomic,copy)	NSString	*returnStatus;
@property (nonatomic, strong) NSString      *expressNO;
@property (nonatomic, strong) NSString      *isconfirmReceipt;
@property (nonatomic, strong) NSString      *isShowLogisticsBtn;
@property (nonatomic, strong) NSString      *commentOrNot;//是否能评论;
@property (nonatomic, strong) NSString      *showOrNot;//是否晒单
@property (nonatomic, strong) NSString      *invoiceCode;//发票代码
@property (nonatomic, strong) NSString      *invoiceNumber;//发票号码
@property (nonatomic, strong) NSString      *printPwd;//打印密码

@property (nonatomic, strong) NSString      *simOrPhoneFlag;
@property (nonatomic, strong) NSString      *partName;
@property (nonatomic, strong) NSString      *phoneNum;
@property (nonatomic, strong) NSString      *monthlyAmt;
@property (nonatomic, strong) NSString      *planTypeName;
@property (nonatomic, strong) NSString      *signDuration;
@property (nonatomic, strong) NSString      *simPicPath;
@end

@interface CShopOrderListDTO : BaseHttpDTO

@property (nonatomic, strong) NSString      *expressNO;
@property (nonatomic, strong) NSString      *isconfirmReceipt;
@property (nonatomic, strong) NSMutableArray  *itemList;
- (void)encodeFromDictionary:(NSDictionary *)dic;
@end
