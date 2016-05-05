//
//  AddressChangeDelegate.h
//  SuningEBuy
//
//  Created by xy ma on 11-11-7.
//  Copyright (c) 2011年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddressInfoDTO;

@protocol AddressChangeDelegate <NSObject>

@optional
/*!
 *  新增或修改地址后，列表页面需要刷新
 */
- (void)addressListNeedRefresh;


/*!
 *  选择了某条地址信息
 */
- (void)didSelectAddress:(AddressInfoDTO *)address;

@end
