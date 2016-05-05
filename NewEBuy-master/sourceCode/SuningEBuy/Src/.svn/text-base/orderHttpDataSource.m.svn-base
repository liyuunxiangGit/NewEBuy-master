//
//  orderHttpDataSource.m
//  SuningEBuy
//
//  Created by zhaojw on 11-9-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "orderHttpDataSource.h"



@implementation orderHttpDataSource


+(OrderStatInfo*)parseOrderInfo:(NSDictionary*)items{
	
	NSArray	*orderLists =[items objectForKey:kResponseMemberOrders];
	
	if (orderLists !=nil && [orderLists count]>0) {
		
		
		OrderStatInfo *_orderStatInfo =[[OrderStatInfo alloc]init];
        
        _orderStatInfo.payedNum  = @"0";
        _orderStatInfo.waitingNum  = @"0";
        _orderStatInfo.canceledNum  = @"0";
        _orderStatInfo.returnedNum = @"0";
		
		for(NSDictionary *dic in orderLists){
			
			//DLog(@"dic =%@",dic);
			
			MemberOrderCenterDTO	*memberOrderCenterDto =[[MemberOrderCenterDTO	alloc] init];
			
			
			[memberOrderCenterDto encodeFromDictionary:dic];
			
			if ([memberOrderCenterDto.orderType isEqualToString:@"C"] || [memberOrderCenterDto.orderType isEqualToString:@"SC"] || [memberOrderCenterDto.orderType isEqualToString:@"SD"] || [memberOrderCenterDto.orderType isEqualToString:@"WD"] || [memberOrderCenterDto.orderType isEqualToString:@"SOMED"]) {
				
				_orderStatInfo.payedNum =  memberOrderCenterDto.orderNum;
                
                
				
			}else if ([memberOrderCenterDto.orderType isEqualToString:@"M"]) {
				
				_orderStatInfo.waitingNum  = memberOrderCenterDto.orderNum;
                
                
				
			}else if ([memberOrderCenterDto.orderType isEqualToString:@"X"]) {
				
				_orderStatInfo.canceledNum  = memberOrderCenterDto.orderNum;
                
                
            }else if ([memberOrderCenterDto.orderType isEqualToString:@"R"]) {
				
				_orderStatInfo.returnedNum  = memberOrderCenterDto.orderNum;
                
                
			}
			
			
			
		}
		return _orderStatInfo;
	}
	
	return nil;
	
	
}

+(NSMutableArray*)parseOrderList:(NSDictionary*)items{
	
	
	if ([[items objectForKey:kResponseHomeTopErrorCode] isEqualToString:@"0"]) {
		
	}else {
		
        
		NSArray	*orderLists =[items objectForKey:kResponseMemberOrdersData];
		
		if (orderLists !=nil && [orderLists count]>0) {
			
			NSMutableArray *retArray = [[NSMutableArray alloc] init];
            
			
			for(NSDictionary *dic in orderLists){
				
				MemberOrderNamesDTO	*memberOrderNamesDto =[[MemberOrderNamesDTO	alloc] init];
				
				[memberOrderNamesDto encodeFromDictionary:dic];
				
				[retArray addObject:memberOrderNamesDto];
				
				
			}
			
			if([retArray count]>0){
				
			    return retArray;
				
			}
            else{
                TT_RELEASE_SAFELY(retArray);
                return nil;
            }
		}
	}
	
	return nil;
}

//xmy  详情head关键字解析
+(NSMutableArray*)parseDetailHeadDTO:(NSDictionary*)items{
    
    NSMutableArray *retArray = [[NSMutableArray alloc] init];
    
    MemberOrderNamesDTO *displayDTO = [[MemberOrderNamesDTO alloc] init];
    
    [displayDTO  encodeFromDictionary:items];
    
    [retArray addObject:displayDTO];
    
    if ([retArray count]>0) {
        
        return retArray ;
        
    }
    else{
        TT_RELEASE_SAFELY(retArray);
        return nil;
    }
	
	return nil;
}

//ordersDisplay
+(NSMutableArray*)parseDetailOrderDTO:(NSDictionary*)items{
    
    NSArray	*orderLists =[items objectForKey:kResponseMemberOrdersDisplay];
	
	if (orderLists !=nil && [orderLists count]>0) {
        
        
		NSMutableArray *retArray = [[NSMutableArray alloc] init];
        
		for(NSDictionary *dic in orderLists){
            MemberOrderDetailsDTO *tempOrderDetailsDTO = [[MemberOrderDetailsDTO alloc] init];
            
			[tempOrderDetailsDTO  encodeFromDictionary:dic];
            
 /*           NSString *productId = tempOrderDetailsDTO.productId;
            
            if(([productId isEqualToString:@""] == YES) || ([productId length] == 0))
            {
                MemberOrderDetailsDTO *lastDto = [retArray lastObject];
                
                lastDto.exWarrantyFlag = @"1";
                
                lastDto.exWarrantyName = tempOrderDetailsDTO.productName;
                lastDto.exWarrantyPrice = tempOrderDetailsDTO.totalProduct;
                
                lastDto.exWarrantyQuantity = tempOrderDetailsDTO.quantityInIntValue;
            }else
            {
                [retArray addObject:tempOrderDetailsDTO];
            }*/
            [retArray addObject:tempOrderDetailsDTO];

		}
        if ([retArray count]>0) {
            
            return retArray ;
            
        }
        else{
            TT_RELEASE_SAFELY(retArray);
            return nil;
        }
    }
	
	return nil;
}
//cShopOrderList

+(NSMutableArray*)parseDetailOrderCSDTO:(NSDictionary*)items{
    
    NSArray	*orderLists =[items objectForKey:@"cShopOrderList"];
	NSString *oiStatus = [items objectForKey:@"oiStatus"];
    if ([oiStatus isEqualToString:L(@"MyEBuy_Completed")]) {
        oiStatus = @"SC";
    }
    else if ([oiStatus isEqualToString:L(@"MyEBuy_WaitingForPay")])
    {
        oiStatus = @"M";
    }
    else if ([oiStatus isEqualToString:L(@"MyEBuy_SomeGoodsDelivered")])
    {
        oiStatus = @"SOMED";
    }
    else if ([oiStatus isEqualToString:L(@"MyEBuy_HaveBeenDelivered")])
    {
        oiStatus = @"SD";
    }
    else if ([oiStatus isEqualToString:L(@"MyEBuy_HavePaid")])
    {
        oiStatus = @"C";
    }
    else if ([oiStatus isEqualToString:L(@"MyEBuy_HaveReturned")])
    {
        oiStatus = @"r";
    }
    else if ([oiStatus isEqualToString:L(@"MyEBuy_HaveCanceled") ])
    {
        oiStatus = @"X";
    }
    else if ([oiStatus isEqualToString:L(@"MyEBuy_OrderAbnormal")] || [oiStatus isEqualToString:@"MyEBuy_OrderProcessing"])
    {
        oiStatus = @"e";
    }
    else if ([oiStatus isEqualToString:L(@"MyEBuy_WaitingDeliver")])
    {
        oiStatus = @"WD";
    }

//    nsa
	if (orderLists !=nil && [orderLists count]>0) {
        
		NSMutableArray *retArray = [[NSMutableArray alloc] init];
        for(NSDictionary *dic in orderLists){
            if ( [oiStatus isEqualToString:@"C"] ||
                [oiStatus isEqualToString:@"D"] ||
                [oiStatus isEqualToString:@"SD"] ||
                [oiStatus isEqualToString:@"SC"] ||
                [oiStatus isEqualToString:@"WD"] ||
                [oiStatus isEqualToString:@"SOMED"] ||
                [oiStatus isEqualToString:@"E"] )
            {
                
                CShopOrderListDTO *tempCShopOrderListDTO = [[CShopOrderListDTO alloc] init];
                [tempCShopOrderListDTO encodeFromDictionary:dic];
                [retArray addObject:tempCShopOrderListDTO];
                
            }
            else
            {
                
                MemberOrderDetailsDTO *tempOrderDetailsDTO = [[MemberOrderDetailsDTO alloc] init];
                
                [tempOrderDetailsDTO  encodeFromDictionary:dic];
                [retArray addObject:tempOrderDetailsDTO];
            }
            
            /*            NSString *productId = tempOrderDetailsDTO.productId;
             
             if(([productId isEqualToString:@""] == YES) || ([productId length] == 0))
             {
             MemberOrderDetailsDTO *lastDto = [retArray lastObject];
             
             lastDto.exWarrantyFlag = @"1";
             
             lastDto.exWarrantyName = tempOrderDetailsDTO.productName;
             lastDto.exWarrantyPrice = tempOrderDetailsDTO.totalProduct;
             
             lastDto.exWarrantyQuantity = tempOrderDetailsDTO.quantityInIntValue;
             }else
             {
             [retArray addObject:tempOrderDetailsDTO];
             }*/
            
		}

//		for(NSDictionary *dic in orderLists){
//            if ( [oiStatus isEqualToString:@"e"] ||
//                [oiStatus isEqualToString:@"X"] ||
//                [oiStatus isEqualToString:@"r"] ||
//                [oiStatus isEqualToString:@"M"] ||
//                [oiStatus isEqualToString:@"H"] )
//            {
//                MemberOrderDetailsDTO *tempOrderDetailsDTO = [[MemberOrderDetailsDTO alloc] init];
//                
//                [tempOrderDetailsDTO  encodeFromDictionary:dic];
//                [retArray addObject:tempOrderDetailsDTO];
//
//            }
//            else
//            {
//                CShopOrderListDTO *tempCShopOrderListDTO = [[CShopOrderListDTO alloc] init];
//                [tempCShopOrderListDTO encodeFromDictionary:dic];
//                [retArray addObject:tempCShopOrderListDTO];
//
//
//            }
        
/*            NSString *productId = tempOrderDetailsDTO.productId;
            
            if(([productId isEqualToString:@""] == YES) || ([productId length] == 0))
            {
                MemberOrderDetailsDTO *lastDto = [retArray lastObject];
                
                lastDto.exWarrantyFlag = @"1";
                
                lastDto.exWarrantyName = tempOrderDetailsDTO.productName;
                lastDto.exWarrantyPrice = tempOrderDetailsDTO.totalProduct;
                
                lastDto.exWarrantyQuantity = tempOrderDetailsDTO.quantityInIntValue;
            }else
            {
                [retArray addObject:tempOrderDetailsDTO];
            }*/
            
//		}
    
        if ([retArray count]>0) {
            
            return retArray ;
            
        }
        else{
            TT_RELEASE_SAFELY(retArray);
            return nil;
        }
    }
	
	return nil;
}



+ (MemberOrderNamesDTO *)parseOrderNameDTO:(NSDictionary *)items
{
    MemberOrderNamesDTO *tempOrderNameDTO = [[MemberOrderNamesDTO alloc] init];
    
    [tempOrderNameDTO encodeFromDictionary:items];
    
    return tempOrderNameDTO;
}


+(NSString*)getOrderTypeInfo:(NSString*)status{
    
	NSString *oiStatusValue = nil;
	
	if ([status isEqualToString:@"A"])
    {
		
		oiStatusValue = L(@"Payment complete");
		
	}
    else if ([status isEqualToString:@"B"])
    {
		
		oiStatusValue = L(@"Payment complete");
		
	}
    else if ([status isEqualToString:@"C"])
    {
		
		oiStatusValue = L(@"Payment complete");
		
	}
    else if ([status isEqualToString:@"D"])
    {
		
		oiStatusValue = L(@"Payment complete");
		
	}
    else if ([status isEqualToString:@"E"])
    {
        
		oiStatusValue = L(@"Payment complete");
        
	}
    else if ([status isEqualToString:@"F"])
    {
        
		oiStatusValue = L(@"Payment complete");
        
	}
    else if ([status isEqualToString:@"SD"])
    {
		
		oiStatusValue = L(@"Payment complete");
		
	}

    else if ([status isEqualToString:@"SC"])
    {
		
		oiStatusValue = L(@"Payment complete");
		
	}
    else if ([status isEqualToString:@"WD"])
    {
		
		oiStatusValue = L(@"Payment complete");
		
	}
    else if ([status isEqualToString:@"SOMED"])
    {
		
		oiStatusValue = L(@"Payment complete");
		
	}

    else if ([status isEqualToString:@"X"])
    {
        
		oiStatusValue = L(@"Order canceled");
        
	}
    else if ([status isEqualToString:@"H"])
    {
        
		oiStatusValue = L(@"Order canceled");
        
	}
    else if ([status isEqualToString:@"G"])
    {
        
		oiStatusValue = L(@"Returned");
        
	}
    else if ([status isEqualToString:@"r"])
    {
        
		oiStatusValue = L(@"Returned");
        
	}
    else if ([status isEqualToString:@"e"])
    {
        
		oiStatusValue = L(@"Abnormal order");
        
	}
    else if ([status isEqualToString:@"M"])
    {
        
		oiStatusValue = L(@"Waiting payment");
        
	}
    else
    {
        
		oiStatusValue = @"";
        
	}
	
	
	return oiStatusValue;
}

//商品订单状态
+(NSString*)getOrderTypeInfo:(NSString*)ormOrder WithOrderStatus:(NSString*)listSt
{
    NSString *detailStatus = nil;
	
	if ([listSt isEqualToString:@"P"]) {
		
		detailStatus =L(@"MyEBuy_InShoppingCart");
		
	}
    else if ([listSt isEqualToString:@"M2"] || [listSt isEqualToString:@"M3"]) {
        
        detailStatus = L(@"MyEBuy_Paying");
        
        return detailStatus;
        
	}
//    else if ([listSt hasPrefix:@"M"]  &&
//             ![ormOrder isEqualToString:@"11601"]) {
//        
//        detailStatus = @"等待支付";
//        
//	}
    else if ([listSt hasPrefix:@"M"]) {
        
        detailStatus = L(@"MyEBuy_WaitingForPay2");
        
	}
    else if(([listSt hasPrefix:@"M"] ||
        [listSt isEqualToString:@"M1"]) &&
       ([ormOrder isEqualToString:@"11601"]))
    {
        detailStatus = L(@"MyEBuy_DeliverProcessing");
    }

    else if ([listSt isEqualToString:@"C"] || [listSt isEqualToString:@"D"] || [listSt isEqualToString:@"E"]) {
        
		detailStatus = L(@"MyEBuy_HavePaid");
        
	}else if ([listSt isEqualToString:@"SC"] ) {
        
		detailStatus = L(@"MyEBuy_Completed");
        
	}else if ([listSt isEqualToString:@"SD"]) {
        
		detailStatus = L(@"MyEBuy_HaveBeenDelivered");
        
	}else if ([listSt isEqualToString:@"WD"]) {
        
		detailStatus = L(@"MyEBuy_WaitingDeliver");
        
	}else if ([listSt isEqualToString:@"SOMED"]) {
        
		detailStatus = L(@"MyEBuy_SomeGoodsDelivered");
        
	}else if ([listSt isEqualToString:@"e"]) {
        
		detailStatus = L(@"MyEBuy_OrderProcessing");
        
	}else if ([listSt isEqualToString:@"X"]) {
        
		detailStatus = L(@"MyEBuy_OrderCanceled");
        
	}else if ([listSt isEqualToString:@"r"]) {
        
		detailStatus = L(@"MyEBuy_ReturnSuccess");
        
	}
    else if ([listSt isEqualToString:@"F"]) {
        
		detailStatus = L(@"MyEBuy_PaidSuccess");
        
	}
    else if ([listSt isEqualToString:@"G"]) {
        
		detailStatus = L(@"MyEBuy_ReturnSuccess");
        
	}
    else if ([listSt isEqualToString:@"H"]) {
        
		detailStatus = L(@"MyEBuy_OrderCanceled");
        
	}
    else if ([listSt isEqualToString:@"W"]) {
        
		detailStatus = L(@"MyEBuy_CashOnDelivery");
        
	}
    else if ([listSt hasPrefix:@"C000"]) {
        
		detailStatus = L(@"MyEBuy_SellerDelivered");
        
	}
    else if ([listSt hasPrefix:@"C010"] || [listSt hasPrefix:@"C015"])
    {
        
		detailStatus = L(@"MyEBuy_ReceivingComplete");
        
	}
    
    return detailStatus;
}

////货到付款订单
//- (BOOL)isCashOnDelivery:(NSString*)ormOrder WithOrderStatus:(NSString*)status
//{
//    if([status hasPrefix:@"M"] && ([ormOrder isEqualToString:@"11601"]))
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//}

//判断门店订单状态
+ (NSString*)setOrderStatus:(NSString*)status
{
    NSString *str = nil;
    
    //    订单行状态（包括线上订单、门店订单）有：10 已提交;12 处理异常;20 已处理;30 已生效;40 已出库;50  货到付款已收已付;60 已完成;70 拒收退货;80 取消;15 退换货处理中;58 冲红完成;75 退款完成。
    if([status isEqualToString:@"10"])
    {
        str = L(@"MyEBuy_Submitted");
    }
    else if([status isEqualToString:@"12"])
    {
        str = L(@"MyEBuy_ExceptionHandling");
    }
    else if([status isEqualToString:@"20"])
    {
        str = L(@"MyEBuy_Processed");
    }
    else if([status isEqualToString:@"30"])
    {
        str = L(@"MyEBuy_Effected");
    }
    else if([status isEqualToString:@"40"])
    {
        str = L(@"MyEBuy_Outbounded");
    }
    else if([status isEqualToString:@"50"])
    {
        str = L(@"MyEBuy_CashOnDelivery_ReceivedAndPaid");
    }
    else if([status isEqualToString:@"60"])
    {
        str = L(@"MyEBuy_Completed");
    }
    else if([status isEqualToString:@"80"])
    {
        str = L(@"Cancel");
    }
    else if([status isEqualToString:@"15"])
    {
        str = L(@"MyEBuy_ReturnsProcessing");
    }
    else if([status isEqualToString:@"75"])
    {
        str = L(@"MyEBuy_RedFinish");
    }
    else if([status isEqualToString:@"75"])
    {
        str = L(@"MyEBuy_RefundCompleted");
    }
    
    return str;
}




@end
