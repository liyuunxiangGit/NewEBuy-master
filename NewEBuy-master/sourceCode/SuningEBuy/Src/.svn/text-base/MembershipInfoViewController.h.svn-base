//
//  MembershipInfoViewController.h
//  SuningEBuy
//
//  Created by zl on 14-11-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "SNSwitch.h"
#import "MyEBuyViewCell.h"
#import "MyCardViewController.h"
#import "AddressInfoListViewController.h"
#import "NewGetRedPackViewController.h"
#import "NewInviteFriendViewController.h"
#import "MyIntegralExchangeViewController.h"
#import "CardDetailBaseDTO.h"
#import "CardWbSerVice.h"
#import "CardDTO.h"
#import "CardService.h"
#define SIZEFONT     20
@interface MembershipInfoViewController : CommonViewController<UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,CardWbSerViceDelegate,cardServiceDelegate>
{
    int iswdy;//优惠卷的个数
    BOOL isGetRedPack;
}
@property (nonatomic, strong) UIImage       *userImage;
@property (nonatomic, strong) CardDetailBaseDTO     *cardDetailBaseDto;
@property (nonatomic, strong) CardWbSerVice         *service;
@property (nonatomic,strong) UIImageView *userImageView;//头像
@property (nonatomic, strong) CardDTO *cardDto;
@property (nonatomic, strong) CardService *cardService;
@end
