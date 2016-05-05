//
//  MemberOrderDetails.m
//  SuningEMall
//
//  Created by lcj lcj on 11-1-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MemberOrderDetailsDTO.h"
#import "ProductUtil.h"

@implementation MemberOrderDetailsDTO
@synthesize	productCode=_productCode;
@synthesize	productId=_productId;
@synthesize	productName=_productName;
@synthesize	quantityInIntValue=_quantityInIntValue;

@synthesize	totalProduct=_totalProduct;
@synthesize	posOrderNumber=_posOrderNumber;
@synthesize	verificationCode=_verificationCode;
@synthesize	currentShipModeType=_currentShipModeType;

@synthesize	taxType=_taxType;
@synthesize	itemPlacerName=_itemPlacerName;
@synthesize	itemMobilePhone=_itemMobilePhone;
@synthesize	address=_address;

@synthesize	invoice=_invoice;
@synthesize	invoiceDescription=_invoiceDescription;

@synthesize exWarrantyQuantity = _exWarrantyQuantity;
@synthesize exWarrantyPrice = _exWarrantyPrice;
@synthesize	exWarrantyName = _exWarrantyName;
@synthesize	exWarrantyFlag = _exWarrantyFlag;

@synthesize orderItemId = _orderItemId;

@synthesize oiStatus = _oiStatus;

@synthesize	imageURL=_imageURL;
@synthesize policyDesc = _policyDesc;

@synthesize isBundle = _isBundle;
@synthesize expressNO = _expressNO;
@synthesize isconfirmReceipt = _isconfirmReceipt;


- (void)encodeFromDictionary:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *oiStatuss			=	[dic objectForKey:kResponseMemberOiStatus];
	
	NSString *productCode			=	[dic objectForKey:kResponseMemberProdectCode];
	NSString *productId				=	[dic objectForKey:kResponseMemberProdectId];
	NSString *productName			=	[dic objectForKey:kResponseMemberProdectName];
	NSString *quantityInIntValue	=	[dic objectForKey:kResponseMemberQuantityInIntValue];
	
	NSString *totalProduct			=	[dic objectForKey:kResponseMemberTotalProduct];
	NSString *posOrderNumber		=	[dic objectForKey:kResponseMemberPosOrderNumber];
	NSString *verificationCode		=	[dic objectForKey:kResponseMemberVerificationCode];
	NSString *currentShipModeType	=	[dic objectForKey:kResponseMemberCurrentShipModeType];
	
	NSString *taxType				=	[dic objectForKey:kResponseMemberTaxType];
	NSString *itemPlacerName		=	[dic objectForKey:kResponseMemberItemPlacerName];
	NSString *itemMobilePhone		=	[dic objectForKey:kResponseMemberItemMobilePhone];
	NSString *address				=	[dic objectForKey:kResponseMemberAddress];
	
	NSString *invoice				=	[dic objectForKey:kResponseMemberInvoice];
	NSString *invoiceDescription	=	[dic objectForKey:kResponseMemberInvoiceDescription];
	NSString *invoiceCodeTmp        =   [dic objectForKey:kResponseMemberInvoiceCode];
    NSString *invoiceNumberTmp      =   [dic objectForKey:kResponseMemberInvoiceNumber];
    NSString *invoicePrintPwd       =   [dic objectForKey:kResponseMemberInvoicePrintPwd];
    
    //阳光包
    NSString *warrantyFlag					=	[dic objectForKey:kResponseMemberWarrantyFlag];
	NSString *warrantyQuantity				=	[dic objectForKey:kResponseMemberWarrantyQuantity];
	NSString *warrantyName					=	[dic objectForKey:kResponseMemberWarrantyName];
	NSString *warrantyPrice					=	[dic objectForKey:kResponseMemberWarrantyPrice];
    
    NSString *orderItem             =   [dic objectForKey:KHttpRequestOrderItemId];
    NSString *commentOrNot          =   [dic objectForKey:KHttpRequestCommentOrNot];//能否评论
    NSString *showOrNot             =   [dic objectForKey:KHttpRequestShowOrNot];//能否晒单
    NSString *simOrPhoneFlag        =   [dic objectForKey:KHttpRequestSimOrPhoneFlag];
    NSString *partName              =   [dic objectForKey:KHttpRequestPartName];
    NSString *phoneNum              =   [dic objectForKey:KHttpRequestPhoneNum];
    NSString *monthlyAmt            =   [dic objectForKey:KHttpRequestMonthlyAmt];
    NSString *planTypeName          =   [dic objectForKey:KHttpRequestPlanTypeName];
    NSString *signDuration          =   [dic objectForKey:KHttpRequestSignDuration];
    NSString *simPicPath            =   [dic objectForKey:KHttpRequestSimPicPath];
    
	
    if (NotNilAndNull(warrantyFlag)) {
        
        self.exWarrantyFlag = warrantyFlag;
        
		if ([warrantyFlag isEqualToString:@"0"] == YES) { //0 ：没有阳光包
            
            if (warrantyName != nil && ![warrantyName isEqualToString:@""]) {
                self.exWarrantyName = warrantyName;
            }
            
            if (warrantyPrice != nil && ![warrantyPrice isEqualToString:@""]) {
                self.exWarrantyPrice = warrantyPrice;
            }
            
            if (warrantyQuantity != nil && ![warrantyQuantity isEqualToString:@""]) {
                self.exWarrantyQuantity = warrantyQuantity;
            }
        }
	}
    
	if (NotNilAndNull(oiStatuss)) {
        if ([oiStatuss isEqualToString:L(@"MyEBuy_Completed")]) {
            oiStatuss = @"SC";
        }
        else if ([oiStatuss isEqualToString:L(@"MyEBuy_WaitingForPay")])
        {
            oiStatuss = @"M";
        }
        else if ([oiStatuss isEqualToString:L(@"MyEBuy_SomeGoodsDelivered")])
        {
            oiStatuss = @"SOMED";
        }
        else if ([oiStatuss isEqualToString:L(@"MyEBuy_HaveBeenDelivered")])
        {
            oiStatuss = @"SD";
        }
        else if ([oiStatuss isEqualToString:L(@"MyEBuy_HavePaid")])
        {
            oiStatuss = @"C";
        }
        else if ([oiStatuss isEqualToString:L(@"MyEBuy_HaveReturned")])
        {
            oiStatuss = @"r";
        }
        else if ([oiStatuss isEqualToString:L(@"MyEBuy_HaveCanceled")])
        {
            oiStatuss = @"X";
        }
        else if ([oiStatuss isEqualToString:L(@"MyEBuy_OrderAbnormal")] || [oiStatuss isEqualToString:L(@"MyEBuy_OrderProcessing")])
        {
            oiStatuss = @"e";
        }
        else if ([oiStatuss isEqualToString:L(@"MyEBuy_WaitingDeliver")])
        {
            oiStatuss = @"WD";
        }

		self.oiStatus = oiStatuss;
	}
	
	if (NotNilAndNull(productCode)) {
		self.productCode = productCode;
	}
	
	if (NotNilAndNull(productId)) {
		self.productId = productId;
	}
	
	if (NotNilAndNull(productName)) {
		self.productName = productName;
	}
	
	if (NotNilAndNull(quantityInIntValue)) {
		self.quantityInIntValue = quantityInIntValue;
	}
	
	
	if (NotNilAndNull(totalProduct)) {
		self.totalProduct = totalProduct;
	}
	
	if (NotNilAndNull(posOrderNumber)) {
		self.posOrderNumber = posOrderNumber;
	}
	
	if (NotNilAndNull(verificationCode)) {
		self.verificationCode = verificationCode;
	}
	
	if (NotNilAndNull(currentShipModeType)) {
		self.currentShipModeType = currentShipModeType;
	}
	
	
	if (NotNilAndNull(taxType)) {
		self.taxType = taxType;
	}
	
	if (NotNilAndNull(itemPlacerName)) {
		self.itemPlacerName = itemPlacerName;
	}
	
	if (NotNilAndNull(itemMobilePhone)) {
		self.itemMobilePhone = itemMobilePhone;
	}
	
	if (NotNilAndNull(address)) {
		self.address = address;
	}
	
	if (NotNilAndNull(invoice)) {
		self.invoice = invoice;
	}
	
	if (NotNilAndNull(invoiceDescription)) {
		self.invoiceDescription = invoiceDescription;
	}
	
    if (NotNilAndNull(orderItem)) {
		self.orderItemId = orderItem;
	}
    
    if (NotNilAndNull(commentOrNot)) {
		self.commentOrNot = commentOrNot;
	}
	
	if (NotNilAndNull(showOrNot)) {
		self.showOrNot = showOrNot;
	}
    if (NotNilAndNull(invoiceCodeTmp)) {
        self.invoiceCode = invoiceCodeTmp;
    }
    if (NotNilAndNull(invoiceNumberTmp)) {
        self.invoiceNumber = invoiceNumberTmp;
    }
    if (NotNilAndNull(invoicePrintPwd)) {
        self.printPwd = invoicePrintPwd;
    }
    if (NotNilAndNull(simOrPhoneFlag)) {
        self.simOrPhoneFlag = simOrPhoneFlag;
    }
    if (NotNilAndNull(partName)) {
        self.partName = partName;
    }
    if (NotNilAndNull(phoneNum)) {
        self.phoneNum = phoneNum;
    }
    if (NotNilAndNull(monthlyAmt)) {
        self.monthlyAmt = monthlyAmt;
    }
    if (NotNilAndNull(planTypeName)) {
        self.planTypeName = planTypeName;
    }
    if (NotNilAndNull(signDuration)) {
        self.signDuration = signDuration;
    }
    if (NotNilAndNull(simPicPath)) {
        self.simPicPath = simPicPath;
    }


    self.isBundle = EncodeStringFromDic(dic, @"isBundle");
    
    self.imageURL = [ProductUtil getImageUrlWithProductCode:self.productCode size:ProductImageSize120x120];
    
    
    NSString *returnStatus =   [dic objectForKey:@"returnStatus"];

    if (NotNilAndNull(returnStatus)) {
        self.returnStatus = returnStatus;
	}
}

@end

@implementation CShopOrderListDTO

@synthesize expressNO = _expressNO;
@synthesize isconfirmReceipt = _isconfirmReceipt;
@synthesize itemList = _itemList;

- (void)encodeFromDictionary:(NSDictionary *)dic
{
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *expressNO			=	[dic objectForKey:@"expressNO"];
	NSString *isconfirmReceipt	=	[dic objectForKey:@"isconfirmReceipt"];
	NSMutableArray *itemList	=	[dic objectForKey:@"itemList"];
	   
	if (NotNilAndNull(expressNO))
    {
		self.expressNO = expressNO;
	}
	
	if (NotNilAndNull(isconfirmReceipt))
    {
		self.isconfirmReceipt = isconfirmReceipt;
	}
	
    if (!IsArrEmpty(itemList))
    {
        
        if (!_itemList)
        {
            _itemList = [[NSMutableArray alloc]init];
        }
        
            for (NSDictionary *dic1 in itemList)
            {
        
                MemberOrderDetailsDTO *product = [[MemberOrderDetailsDTO alloc]init];
                [product encodeFromDictionary:dic1];
                product.expressNO = expressNO;
                product.isconfirmReceipt = isconfirmReceipt;
                product.isShowLogisticsBtn = isconfirmReceipt;
                [self.itemList addObject:product];
            }
        
    }

    
//    self.isBundle = EncodeStringFromDic(dic, @"isBundle");
//    
//    self.imageURL = [ProductUtil getImageUrlWithProductCode:self.productCode size:ProductImageSize120x120];
//    
//    
//    NSString *returnStatus =   [dic objectForKey:@"returnStatus"];
//    
//    if (NotNilAndNull(returnStatus)) {
//        self.returnStatus = returnStatus;
//	}
}


@end
