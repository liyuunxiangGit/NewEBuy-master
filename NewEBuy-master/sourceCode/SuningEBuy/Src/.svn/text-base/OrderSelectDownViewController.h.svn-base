//
//  OrderSelectDownViewController.h
//  SuningEBuy
//
//  Created by xmy on 21/11/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>


@class OrderSelectDownViewController;

@protocol OrderSelectDownDelegate <NSObject>

- (void)selectedOrderStyleOrTime:(NSString*)str WithRow:(NSInteger)row;

-(void)btnsImage;

@end

@interface OrderSelectDownViewController : CommonViewController

@property (nonatomic,strong)UIImageView *backView;
@property (nonatomic,strong) NSArray *orderArr;//订单类型数组
@property (nonatomic,strong) NSArray *orderTimeArr;//订单时间
@property (nonatomic) BOOL           isTime;//选择的是时间还是订单类型 1时间 0订单类型

//@property (nonatomic) BOOL         isOnlineOrder;//选择的是普通订单还是门店订单 1普通订单 0门店订单

@property (nonatomic,assign) id<OrderSelectDownDelegate> delegate;

//isOnlineOrder选择的是普通订单还是门店订单 1普通订单 0门店订单
- (id)initWithIsOnlineOrder:(BOOL)isOnlineOrder;

@end
