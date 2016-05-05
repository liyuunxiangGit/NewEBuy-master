//
//  MemberOrderCenterDTO.h
//  SuningEMall
//
//  Created by lcj lcj on 11-1-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"

@interface MemberOrderCenterDTO : BaseHttpDTO {
	NSString	*_orderType;//订单类型
	NSString	*_orderNum;	//订单数
}

@property	(nonatomic,copy)	NSString	*orderType;
@property	(nonatomic,copy)	NSString	*orderNum;

@end
