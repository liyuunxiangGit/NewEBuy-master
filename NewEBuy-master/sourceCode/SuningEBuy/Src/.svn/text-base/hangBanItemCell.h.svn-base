//
//  hangBanItemCell.h
//  SuningEBuy
//
//  Created by xy ma on 12-5-11.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UITableViewCellEx.h"
#import "FlightInfoDTO.h"
#import "FlightRoomInfoDTO.h"

@protocol hangBanItemCellDelegate; 



@interface hangBanItemCell : UITableViewCellEx

{
     
    UILabel *_quFanHangBanLbl;//去返程航班1
    
    UILabel *_hanBanRiQiLbl;//航班日期2
	
	UILabel *_qiFeiLbl;//起飞3
    
    UILabel *_jiangLuoLbl;//降落4
	
	UILabel *_jiPiaoDanJiaLbl;//机票单价5
    
    UILabel *_jiJianRanYouFeiLbl;//机建费燃油税6
    
    UIImage *_hangBanImage;//航空公司logo
    
    FlightInfoDTO *_FlightInfoDto;
    FlightRoomInfoDTO *_FlightRoomInfoDto;
    
    id<hangBanItemCellDelegate> __weak delegate;


}

@property(nonatomic,strong) UILabel    *quFanHangBanLbl;
@property(nonatomic,strong) UILabel    *hanBanRiQiLbl;
@property(nonatomic,strong) UILabel    *qiFeiLbl;
@property(nonatomic,strong) UILabel    *jiangLuoLbl;
@property(nonatomic,strong) UILabel    *jiPiaoDanJiaLbl;
@property(nonatomic,strong) UILabel    *jiPiaoDanJiaValLbl;
@property(nonatomic,strong) UILabel    *jiJianRanYouFeiLbl;
@property(nonatomic,strong) UILabel    *jiJianRanYouFeiValLbl;


@property(nonatomic,strong) UIImage     *hangBanImage;
@property(nonatomic,strong) FlightInfoDTO *FlightInfoDto;
@property(nonatomic,strong) FlightRoomInfoDTO *FlightRoomInfoDto;
@property(nonatomic,strong) UIButton    *refundBtn;//退改签按钮
@property(nonatomic,weak) id<hangBanItemCellDelegate> delegate;
@property(nonatomic,strong) NSString *quFanCheng;


-(void) setHanBanInfoItem:(FlightInfoDTO *)aFlightInfoDto;
-(void)refundTicketAction:(id)sender;


@end


@protocol hangBanItemCellDelegate <NSObject>

//rule为退改签规则的key
-(void)returnRefundTicketAction:(FlightInfoDTO *)ruleInfo;

@end
