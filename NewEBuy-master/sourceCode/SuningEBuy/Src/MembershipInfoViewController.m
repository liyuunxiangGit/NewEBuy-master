//
//  MembershipInfoViewController.m
//  SuningEBuy
//
//  Created by zl on 14-11-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "MembershipInfoViewController.h"
#import "EfubaoUnboundPhoneViewController.h"
#import "EfubaoUnActiveViewController.h"
#import "EfubaoUnBoundEmailViewController.h"
@interface MembershipInfoViewController ()

@end

@implementation MembershipInfoViewController

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = @"会员资料";
        self.pageTitle = @"会员资料";
        iswdy = 0;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    self.tpTableView = (id)self.groupTableView;
    self.tpTableView.frame = frame;
    self.tpTableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.tpTableView];
    iswdy = (int)(([SNSwitch yaoqinghaoyou244])?1:0)+(int)([UserCenter defaultCenter].isGetRedPack?1:0);
    
    isGetRedPack = [UserCenter defaultCenter].isGetRedPack;
    [self queryUserImage];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==2) {
        return iswdy;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSMutableArray* array = [NSMutableArray arrayWithObjects:@"个人信息",@"账号管理",nil];
    if (iswdy)
    {
        [array addObject:@"会员社区"];
    }
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    v.backgroundColor = [UIColor clearColor];
    UILabel* lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 320, 25)];
    lab.text = array[section];
    lab.font = [UIFont boldSystemFontOfSize:13];
    lab.textColor = [UIColor colorWithRGBHex:0xa2a2a2];
    lab.backgroundColor = [UIColor clearColor];
    [v addSubview:lab];
    return v;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (iswdy > 0)
    {
        return 3;
    }
    else
    {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            return 80;
        }
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            static NSString *cellIndentifier = @"headerIndentifierID";
            
            SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            
            if (nil == cell)
            {
                cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor cellBackViewColor];
                
                
                cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
                cell.textLabel.backgroundColor = [UIColor clearColor];
                cell.textLabel.textColor = [UIColor light_Black_Color];
                
            }
            cell.textLabel.text = @"头像";
            [cell.contentView addSubview:self.userImageView];
            return cell;

        }
        
    }
    static NSString *cellIndentifier = @"IndentifierID";
    
    SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if (nil == cell)
    {
        cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor cellBackViewColor];
        
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor light_Black_Color];
        
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellDetail.png"]];
        cell.accessoryView = arrow;
        
    }
    if (indexPath.section == 0)
    {
        if(indexPath.row == 1)
        {
            cell.textLabel.text = @"云钻";
            NSString *_achieve =  [NSString stringWithFormat:@"%@",[UserCenter defaultCenter].userDiscountInfoDTO.achievement];
            CGSize sizeToFit = [_achieve sizeWithFont:[UIFont systemFontOfSize:SIZEFONT-5] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 30) lineBreakMode:UILineBreakModeWordWrap];
            UILabel* _jifenValLbl = [[UILabel alloc]initWithFrame:CGRectMake(295-sizeToFit.width, 5, sizeToFit.width, 30)];
            _jifenValLbl.userInteractionEnabled = YES;
            _jifenValLbl.text = _achieve;
            _jifenValLbl.font = [UIFont systemFontOfSize:SIZEFONT-5];
            _jifenValLbl.textColor = [UIColor light_Black_Color];
            _jifenValLbl.textAlignment = UITextAlignmentLeft;
            [cell.contentView addSubview:_jifenValLbl];
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            cell.textLabel.text = @"电子会员卡绑定";
        }
        else
        {
            cell.textLabel.text = @"收货信息管理";
        }
    }
    else if(indexPath.section == 2)
    {
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(273-10, 13, 25, 12)];
        icon.image = [UIImage imageNamed:@"myegouhot.png"];
        [cell.contentView addSubview:icon];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 200, 20)];
        label.font = cell.textLabel.font;
        
        label.font = [UIFont boldSystemFontOfSize:15];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor light_Black_Color];
        [cell.contentView addSubview:label];
        cell.textLabel.text=@"";
        switch (indexPath.row)
        {
                
            case 0:
            {
                if (isGetRedPack)
                {
                    label.text = [SNSwitch lingquhongbao244];
                }
                else
                {
                    label.text =[SNSwitch yaoqinghaoyou244];
                }
                break;
                
            }
            case 1:
            {
                label.text =[SNSwitch yaoqinghaoyou244];
            }
                break;
            default:
                break;
        }

    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            [self changeUserImage];
        }
        else if(indexPath.row == 1)
        {
            [self SNDataCollection:@"740502"];
            [self gotoIntegral];
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            [self SNDataCollection:@"740603"];
            [self gotoMyCard];
        }
        else if(indexPath.row ==1)
        {
            [self SNDataCollection:@"740608"];
            [self gotoAddressInfo];
        }
    }
    else
    {
        if (iswdy!=0)
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    if (isGetRedPack)
                    {//对暗号领取新人红包
                        [self SNDataCollection:@"740611"];
                        NewGetRedPackViewController *getred = [[NewGetRedPackViewController alloc] init];
                        [self.navigationController pushViewController:getred animated:YES
                         ];
                        break;
                    }
                    else
                    {//查看奖励－邀请好友奖励
                        [self SNDataCollection:@"620201"];
                        [self gotoinviteFriend];
                    }
                    break;
                }
                case 1:{//查看奖励－邀请好友奖励
                    [self SNDataCollection:@"620201"];
                    [self gotoinviteFriend];
                }
                    break;
                default:
                    break;
            }
            
        }

    }
}

//换头像
- (void)changeUserImage
{
    [self SNDataCollection:@"740501"];
    UIActionSheet *selectChangeType = [[UIActionSheet alloc] initWithTitle:L(@"MyEBuy_SelectChangeIconWay") delegate:self cancelButtonTitle:L(@"Cancel") destructiveButtonTitle:nil otherButtonTitles:L(@"BTTakePic"),L(@"BTPhotoAlbum"),nil];
    selectChangeType.tag = 100;
    [selectChangeType showInView:[UIApplication sharedApplication].keyWindow];
}
#pragma mark - UIPickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    /*添加代码，处理选中图像又取消的情况*/
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil)
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    double size = image.size.height*image.size.width;
    
    UIImage *newImage;
    if ( size > 640 * 640)
    {
        CGRect thumbnailRect = CGRectZero;
        thumbnailRect.origin = CGPointMake(0, 0);
        thumbnailRect.size.width  = 640;
        thumbnailRect.size.height = 640;
        UIGraphicsBeginImageContext(thumbnailRect.size); // this will crop
        
        
        
        [image drawInRect:thumbnailRect];
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        

        UIGraphicsEndImageContext();
    }
    else
        newImage = [image copy];
    
    self.userImage = newImage;
    
    [self.groupTableView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self  saveDetail];
    
    
    // Do something with the image
    //    [self.imageView setImage:image];
}

//头像发请求
- (void)saveDetail
{
    UIImage *image = [[UIImage alloc] init];
    
    NSData *data = UIImageJPEGRepresentation([image fixOrientation:self.userImage],0.1);
    NSString *str = [data base64Encoding];
    
    self.cardDetailBaseDto = [[CardDetailBaseDTO alloc] init];
    
    self.cardDetailBaseDto.imgData = str;
    
    self.cardDetailBaseDto.sysHeadPicFlag = @"100000000020";//self.cardDto.sysHeadPicFlag;// @"100000000020";
    
    self.cardDetailBaseDto.sysHeadPicNum = @"";//self.cardDto.sysHeadPicNum;//@"";
    
    self.cardDetailBaseDto.custNum = [UserCenter defaultCenter].userInfoDTO.custNum;//self.cardDto.custNum;
    
    [self.service beginSaveDetailInfo:self.cardDetailBaseDto];
    
    [self displayOverFlowActivityView];
    
}

- (CardWbSerVice *)service
{
    if (!_service)
    {
        _service = [[CardWbSerVice alloc] init];
        
        _service.delegate = self;
    }
    
    return _service;
}
//UIActionSheet代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (actionSheet.tag) {
        case 100:{
            switch (buttonIndex) {
                case 0:
                    [self changeImageByCamera];
                    break;
                case 1:
                    [self changeImageByPhoto];
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

//UIActionSheet相册按钮响应事件
- (void)changeImageByPhoto
{
    //    UIApplication *myApp = [UIApplication sharedApplication];
    //    [myApp setStatusBarHidden:YES];//先把状态栏隐藏起来
    
	UIImagePickerController* picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.allowsEditing=YES;
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:picker animated:YES completion:nil];
    
}

//UIActionSheet相机按钮响应事件
- (void)changeImageByCamera
{
    UIImagePickerController  *eImagePickerController = [[UIImagePickerController alloc] init];
    eImagePickerController.delegate=self;
    
    
    eImagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //    eImagePickerController.cameraDevice = UIImagePickerControllerSourceTypeCamera;
    eImagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    eImagePickerController.showsCameraControls = YES;
    eImagePickerController.navigationBarHidden = NO;
    eImagePickerController.cameraDevice=UIImagePickerControllerCameraDeviceRear;
    eImagePickerController.wantsFullScreenLayout = NO;
    //    eImagePickerController.cameraViewTransform = CGAffineTransformScale(eImagePickerController.cameraViewTransform, CAMERA_TRANSFORM_X, CAMERA_TRANSFORM_Y);
    
    [self presentViewController:eImagePickerController animated:YES completion:nil];
}

//我的云钻
- (void)gotoIntegral{
    
    UserCenter *defaultCenter = [UserCenter defaultCenter];
    switch (defaultCenter.efubaoStatus) {//defaultCenter.efubaoStatus
            
        case eLoginByPhoneUnBound:{
            //手机登录、易付宝激活
            EfubaoUnboundPhoneViewController *efubaoController = [[EfubaoUnboundPhoneViewController alloc] init];
            
            [self.navigationController pushViewController:efubaoController animated:YES];
            
            TT_RELEASE_SAFELY(efubaoController);
            
        }
            break;
            
        case eLoginByPhoneActive:{
            
            MyIntegralExchangeViewController *nextViewController = [[MyIntegralExchangeViewController alloc] init];
            
            [self.navigationController pushViewController:nextViewController animated:YES];

        }
            
            break;
            
        case eLoginByPhoneUnActive:{
            
            
            EfubaoUnActiveViewController *efubaoController = [[EfubaoUnActiveViewController alloc] init];
            
            [self.navigationController pushViewController:efubaoController animated:YES];
            
            TT_RELEASE_SAFELY(efubaoController);
            
        }
            
            break;
            
        case eLoginByEmailUnBound:{
            
            EfubaoUnBoundEmailViewController *efubaoController = [[EfubaoUnBoundEmailViewController alloc] init];
            
            [self.navigationController pushViewController:efubaoController animated:YES];
            
            TT_RELEASE_SAFELY(efubaoController);
        }
            break;
            
        case eLoginByEmailUnActive:{
            
            EfubaoUnActiveViewController *efubaoController = [[EfubaoUnActiveViewController alloc] init];
            
            [self.navigationController pushViewController:efubaoController animated:YES];
            
            TT_RELEASE_SAFELY(efubaoController);
        }
            break;
            
        case eLoginByEmailPhoneUnBound:{
            EfubaoUnActiveViewController *efubaoController = [[EfubaoUnActiveViewController alloc] init];
            
            [self.navigationController pushViewController:efubaoController animated:YES];
            
            TT_RELEASE_SAFELY(efubaoController);
        }
            break;
            
            
        case eLoginByEmailActive:{
            
            MyIntegralExchangeViewController *nextViewController = [[MyIntegralExchangeViewController alloc] init];
            
            [self.navigationController pushViewController:nextViewController animated:YES];

        }
            break;
            
        default:{
            
        }
            break;
    }

    
}

//查看奖励－邀请好友奖励
-(void)gotoinviteFriend{
    
    self.navigationController.navigationBarHidden = YES;
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"620201"], nil]];
    NewInviteFriendViewController *invitef = [[NewInviteFriendViewController alloc] init];
    [self.navigationController pushViewController:invitef animated:YES];
    TT_RELEASE_SAFELY(invitef);
    
}

//地址管理
- (void)gotoAddressInfo
{
    AddressInfoListViewController *vc = [AddressInfoListViewController controller];
    vc.cellType = FromEbuy;
    [self.navigationController pushViewController:vc animated:YES];
}

//电子会员卡
- (void)gotoMyCard
{
    MyCardViewController *mycard = [[MyCardViewController alloc] init];
    [self.navigationController pushViewController:mycard animated:YES];
}

-(void)SNDataCollection:(NSString*)aStr
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:aStr, nil]];
}

//头像图片
- (UIImageView*)userImageView
{
    
    if(_userImageView == nil)
    {
        _userImageView = [[UIImageView alloc] init];
        _userImageView.userInteractionEnabled = YES;
        _userImageView.backgroundColor = [UIColor clearColor];
        _userImageView.frame = CGRectMake(240, 8, 64, 64);
        [_userImageView setImage:[UIImage imageNamed:@"New_UserPhoto.png"]];
        
        [_userImageView.layer setCornerRadius:32.0];
        
        _userImageView.layer.borderWidth = 1.0;
        
        _userImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        [_userImageView.layer setMasksToBounds:YES];
        
    }
    
    return _userImageView;
}

-(CardService*)cardService
{
    if (nil == _cardService)
    {
        _cardService = [[CardService alloc] init];
        
        _cardService.delegate = self;
    }
    
    return _cardService;
}

//请求查询头像
- (void)queryUserImage
{
    //[self displayOverFlowActivityView];
//    if (KPerformance)
//    {
//        if (self.isLogined)
//        {
//            self.isLogined = NO;
//        }
//        else
//        {
//            PerformanceStatisticsData* temp = [[PerformanceStatisticsData alloc] init];
//            temp.startTime = [NSDate date];
//            temp.functionId = @"4";
//            temp.interfaceId = @"406";
//            temp.taskId = @"1004";
//            temp.count = 1;
//            [[PerformanceStatistics sharePerformanceStatistics].arrayData addObject:temp];
//        }
//        
//    }
    [self.cardService beginGetCardInfo:[UserCenter defaultCenter].userInfoDTO.custNum WithName:nil];
}

//保存头像返回提示
- (void)savePersonDetailComplete:(BOOL)isSuccess ErrorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    if (isSuccess)
    {
        self.userImageView.image = self.userImage;
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:L(@"AlertTips")
                                                         message:L(@"AlertSaveSuccess")
                                                        delegate:self
                                               cancelButtonTitle:L(@"Ok")
                                               otherButtonTitles:nil, nil];
        [alertView show];
    }
    
    else
    {
        [self presentSheet:errorMsg posY:60];
    }
}

-(void)getCardInfoCompletedWithResult:(BOOL)isSuccess infoDto:(CardDTO *)dto errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess)
    {
        if (KPerformance)
        {
            if ([PerformanceStatistics sharePerformanceStatistics].arrayData.count > 0)
            {
                
                [PerformanceStatistics sharePerformanceStatistics].countStatus += 1;
                if ([PerformanceStatistics sharePerformanceStatistics].countStatus == [PerformanceStatistics sharePerformanceStatistics].arrayData.count)
                {
                    PerformanceStatisticsData* temp = [[PerformanceStatistics sharePerformanceStatistics].arrayData safeObjectAtIndex:0];
                    temp.endTime = [NSDate date];
                    [[PerformanceStatistics sharePerformanceStatistics]sendData:temp];
                    [[PerformanceStatistics sharePerformanceStatistics].arrayData removeAllObjects];
                }
                
            }
            
        }
        self.cardDto = dto;
        NSString *urlStr = [NSString stringWithFormat:@"%@?version=%@",WBHeadUrlString(dto.sysHeadPicFlag, dto.sysHeadPicNum, CGSizeMake(640, 640),dto.custNum),dto.sysHeadPicNum];
        if (![urlStr isEqualToString:@""]) {
            NSURL *url = [NSURL URLWithString:urlStr];
            if ([url.scheme hasPrefix:@"http"]) {
                
                UIImageView *__weak i_portraitView = self.userImageView;
                
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    NSData *imageData    = [NSData dataWithContentsOfURL:url];
                    UIImage *portraitImg = [UIImage imageWithData:imageData];
                    if (nil != portraitImg) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            i_portraitView.image = portraitImg;
                        });
                    }
                });
            }
        }
    }
}

@end
