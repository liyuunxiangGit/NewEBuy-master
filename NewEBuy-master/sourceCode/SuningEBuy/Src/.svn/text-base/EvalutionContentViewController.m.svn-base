//
//  EvalutionContentViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-4-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "EvalutionContentViewController.h"
#import "ProductUtil.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
@interface EvalutionContentViewController ()
{
    BOOL    _isAnonFlag;
    
}
@end

@implementation EvalutionContentViewController

@synthesize contentTextView                 = _contentTextView;
@synthesize evalutionService                = _evalutionService;
@synthesize evalutionDto                    = _evalutionDto;
@synthesize headView                        = _headView;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_evalutionDto);
    SERVICE_RELEASE_SAFELY(_evalutionService);
    
    TT_RELEASE_SAFELY(_contentTextView);
    
    TT_RELEASE_SAFELY(_headView);
    
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"Evaluation");
        
        self.pageTitle = L(@"member_myEbuy_userEvaluate");
        
        _isAnonFlag = NO;
        
        if (!_evalutionDto) {
            _evalutionDto = [[EvalutionDetailDTO alloc] init];
        }
        
        if (!_evalDto) {
            _evalDto = [[EvalutionDTO alloc] init];
        }
        
        
//        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:@"发表"];
        
    }
    return self;
}

- (void)righBarClick
{
    [self commitEvaluate];
}

- (void)commitEvaluate
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:@"770705", nil]];
    NSString *contentString = [self.contentTextView.text trim];
 
    if(IsStrEmpty(self.evaluationBasicDto.qualityStar) || [self.evaluationBasicDto.qualityStar intValue] == 0){
        [self presentSheet:L(@"PVGrade") posY:100];
        return;
    }
    
    if (IsStrEmpty(contentString)) {
        [self presentSheet:L(@"PVPleaseEnterUseExperience") posY:100];
        [self.contentTextView becomeFirstResponder];
        return;
    }
    if (contentString.length < 5 || contentString.length > 500) {
        [self presentSheet:L(@"PVUseExperienceShouldBeFiveToFivehundredWords") posY:100];
        [self.contentTextView becomeFirstResponder];
        return;
    }
    
    [self.contentTextView resignFirstResponder];
    
    self.evaluationBasicDto.content = contentString;
    if (!self.showReviewStatus) {
        if (IsStrEmpty(self.evaluationBasicDto.attitudeStar) || [self.evaluationBasicDto.attitudeStar intValue] == 0) {
            [self presentSheet:L(@"PVPleaseEvaluateServiceSatisfaction") posY:100];
            return;
        }

        if (IsStrEmpty(self.evaluationBasicDto.dlvrSpeedStar) || [self.evaluationBasicDto.dlvrSpeedStar intValue] == 0) {
            [self presentSheet:L(@"PVPleaseEvaluateExpressSatisfaction") posY:100];
            return;
        }
    }

    [self displayOverFlowActivityView];
    
//    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    
    [self.evalutionService beginEvalutionPublish:self.evaluationBasicDto];
    
}

- (EvaluationBsicDTO *)evaluationBasicDto{
    if (!_evaluationBasicDto) {
        _evaluationBasicDto = [[EvaluationBsicDTO alloc] init];
        _evaluationBasicDto.orderItemId = _evalutionDto.orderItemId;
        _evaluationBasicDto.orderId = _evalDto.orderId;
        _evaluationBasicDto.partNumber = _evalutionDto.partNumber;
        _evaluationBasicDto.anonFlag = @"0";
    }
    return _evaluationBasicDto;
}

- (void)evalutionPublishCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
//    self.navigationItem.rightBarButtonItem.enabled = YES;
    if (isSuccess) {
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"AlertTips") message:L(@"AlertSubmitSuccess") delegate:self cancelButtonTitle:L(@"Ok") otherButtonTitles:nil];

        [alert setCancelBlock:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"sffff" object:self];
        }];
        [alert show];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SuccessEvalution" object:nil];
    }
    else{
        NSString *errorMsg1 = errorMsg ? errorMsg :L(@"Evaluate failed,please try again later");
        [self presentSheet:errorMsg1];
    }
}


- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)loadView
{
    [super loadView];
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    
    self.tpTableView.frame = [self setViewFrame:self.hasNav];
    self.tpTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tpTableView];
    
    
    [self useBottomNavBar];
    [self.bottomNavBar addSubview:self.bottomCell];
    self.bottomCell.yiGouBtn.hidden = YES;
    self.bottomCell.backBtn.hidden = YES;
    self.bottomCell.payBtn.hidden = NO;
    self.bottomCell.payBtn.frame = CGRectMake(32.5, 6.5, 255, 35);
    
    [self.bottomCell.payBtn setTitle:L(@"BTPublish") forState:UIControlStateNormal];
    [self.bottomCell.payBtn addTarget:self action:@selector(commitEvaluate) forControlEvents:UIControlEventTouchUpInside];
    
}

- (NewEvalutionService *)evalutionService
{
    if (!_evalutionService) {
        _evalutionService = [[NewEvalutionService alloc] init];
        _evalutionService.delegate = self;
    }
    return _evalutionService;
}

#pragma mark -
#pragma mark views

- (UIImageView *)headView
{
    if (!_headView) {
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 115)];
        _headView.backgroundColor = [UIColor clearColor];
        _headView.userInteractionEnabled = YES;
        

        
        EGOImageView *productimg = [[EGOImageView alloc] initWithFrame:CGRectMake(15, 15, 85, 85)];
        productimg.backgroundColor = [UIColor clearColor];

        productimg.delegate = self;
        productimg.layer.borderWidth = 0.4;
        productimg.layer.borderColor = RGBCOLOR(235, 235, 235).CGColor;
        productimg.layer.masksToBounds = YES;

        productimg.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];

        productimg.contentMode = UIViewContentModeScaleToFill;
        
        productimg.imageURL = self.evalutionDto.productUrl;
        [_headView addSubview:productimg];
        
        UILabel *productName = [[UILabel alloc] init];
        UIFont *cellFont =[UIFont systemFontOfSize:15.0];
        productName.numberOfLines = 2;
        productName.backgroundColor = [UIColor clearColor];
        //        productName.lineBreakMode = NSLineBreakByCharWrapping;
        productName.font = cellFont;
        productName.textColor = [UIColor blackColor];
        productName.text = self.evalutionDto.catentryName;
        //        CGSize mainContendSize = [productName.text sizeWithFont:cellFont
        //                                                      constrainedToSize:CGSizeMake(220, 10000)
        //                                                          lineBreakMode:NSLineBreakByCharWrapping];
        productName.frame = CGRectMake(110, 16, 193, 38);
        
        [_headView addSubview:productName];
        
//        UILabel *priceLbl = [[UILabel alloc] init];
//        priceLbl.backgroundColor = [UIColor clearColor];
//        priceLbl.textColor = [UIColor colorWithRGBHex:0xFF0000];
//		priceLbl.font = [UIFont systemFontOfSize:17];
//        priceLbl.text = @"￥";
//		priceLbl.autoresizingMask = UIViewAutoresizingNone;
//        priceLbl.frame = CGRectMake(110, 62, 140, 20);
//		[_headView addSubview:priceLbl];
//        
//        EGOImageView *priceImg = [[EGOImageView alloc] init];
//        priceImg.backgroundColor = [UIColor clearColor];
//        priceImg.contentMode = UIViewContentModeLeft;
//        priceImg.placeholderImage = nil;
//        priceImg.cacheAge = kEGOCacheAgeOneLifeCycle;
//        priceImg.frame = CGRectMake(125, 62, 135, 16);
//        NSString *cityId = [Config currentConfig].defaultCity;
//        priceImg.imageURL = [ProductUtil bestPriceImageOfProductId:self.evalutionDto.catentryId
//                                                                   city:cityId];
//		[_headView addSubview:priceImg];
        
        UILabel *supplierNameLbl = [[UILabel alloc] init];
        supplierNameLbl.backgroundColor = [UIColor clearColor];
        supplierNameLbl.textColor = RGBCOLOR(151, 151, 151);
        supplierNameLbl.font = [UIFont systemFontOfSize:12];
        supplierNameLbl.text = self.evalutionDto.supplierName;
        supplierNameLbl.frame = CGRectMake(110, 84, 195, 12);
        [_headView addSubview:supplierNameLbl];
        
        UIImageView *seperateLineImg = [[UIImageView alloc] init];
        seperateLineImg.image = [UIImage imageNamed:@"line.png"];
        seperateLineImg.backgroundColor = [UIColor clearColor];
        seperateLineImg.frame = CGRectMake(0, 114, 320, 0.5);
        [_headView addSubview:seperateLineImg];
        
    }
    return _headView;
}

- (UIView *)evalutionView
{
    if (!_evalutionView) {
        _evalutionView = [[UIView alloc] init];
        _evalutionView.backgroundColor = [UIColor clearColor];
        _evalutionView.frame = CGRectMake(0, 0, 320, 152);
        
        UILabel *lable = [[UILabel alloc] init];
        lable.frame = CGRectMake(15, 18, 60, 15);
        lable.textColor = [UIColor dark_Gray_Color];//RGBCOLOR(97, 97, 97);
        lable.text = L(@"HGrade");
        lable.font = [UIFont systemFontOfSize:14];
        lable.backgroundColor = [UIColor clearColor];
        lable.textAlignment = UITextAlignmentLeft;
        [_evalutionView addSubview:lable];
        
        [_evalutionView addSubview:self.StarRatingControl];
        
        [_evalutionView addSubview:self.contentTextView];
        
    }
    return _evalutionView;
}

- (UIView *)evaluServiceView{
    if (!_evaluServiceView) {
        _evaluServiceView = [[UIView alloc] init];
        _evaluServiceView.frame = CGRectMake(0, 0, 310, 160);
        _evaluServiceView.backgroundColor = [UIColor clearColor];
        
        UIImageView *seperateLineImg = [[UIImageView alloc] init];
        seperateLineImg.frame = CGRectMake(15, 0, 320, 0.5);
        seperateLineImg.image = [UIImage imageNamed:@"line.png"];
        seperateLineImg.backgroundColor = [UIColor clearColor];
       [_evaluServiceView addSubview:seperateLineImg];
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.frame = CGRectMake(15, 12, 170, 20);
        label1.textColor = [UIColor colorWithRGBHex:0x313131];
        label1.font = [UIFont systemFontOfSize:15.0];
        label1.backgroundColor = [UIColor clearColor];
        label1.text = L(@"HIsSatisfied");
        [_evaluServiceView addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc] init];
        label2.frame = CGRectMake(15, 44, 90, 20);
        label2.textColor = [UIColor dark_Gray_Color];
        label2.font = [UIFont systemFontOfSize:14.0];
        label2.text = L(@"HServiceSatisfaction");
//        label2.textColor = RGBCOLOR(99, 99, 99);
        label2.backgroundColor = [UIColor clearColor];
        [_evaluServiceView addSubview:label2];
        
        UILabel *label3 = [[UILabel alloc] init];
        label3.frame = CGRectMake(15, 80, 90, 20);
        label3.backgroundColor = [UIColor clearColor];
        label3.font = [UIFont systemFontOfSize:14.0];
//        label3.text = @"发货及时性";
        label3.text = L(@"HExpressSatisfaction");
        label3.textColor = [UIColor dark_Gray_Color];
        [_evaluServiceView addSubview:label3];

        
        DLStarRatingControl *starRating1 = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(90, 38, 190, 35)];
        starRating1.delegate = self;
        starRating1.tag = 101;
      //  starRating1.backgroundColor = [UIColor grayColor];
        [_evaluServiceView addSubview:starRating1];
        
        DLStarRatingControl *starRating2 = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(90, 75, 190, 35)];
        starRating2.delegate = self;
        starRating2.tag = 102;
      //  starRating2.backgroundColor = [UIColor blueColor]
        [_evaluServiceView addSubview:starRating2];
        
        
        
        
        UIView *footView = [[UIView alloc] init];
        footView.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] init];
        
        if (self.showReviewStatus == NO)
        {
            footView.frame = CGRectMake(0, 105, 320, 50);

            label.frame = CGRectMake(45, 0, 100, 40);

//            _anonBtn.frame = CGRectMake(5, 5, 45, 30);

        }
        else
        {
            footView.frame = CGRectMake(0, 0, 320, 50);
            
            label.frame = CGRectMake(45, 5, 100, 40);
            
//            _anonBtn.frame = CGRectMake(5, 15, 45, 30);

        }
        label.backgroundColor = [UIColor clearColor];
        label.text = L(@"HAnonymousEvaluate");
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor blackColor];
        [footView addSubview:label];
       
        [footView addSubview:self.anonBtn];
        
        [_evaluServiceView addSubview:footView];
        
        
        if (self.showReviewStatus == NO)
        {
            seperateLineImg.hidden = NO;
            label1.hidden = NO;
            label2.hidden = NO;
            label3.hidden = NO;
            
            starRating1.hidden = NO;
            starRating2.hidden = NO;
            
            self.anonBtn.hidden = NO;
            label.hidden = NO;
        }
        else
        {
            seperateLineImg.hidden = YES;
            label1.hidden = YES;
            label2.hidden = YES;
            label3.hidden = YES;

            starRating1.hidden = YES;
            starRating2.hidden = YES;

            self.anonBtn.hidden = NO;
            label.hidden = NO;
        }
        
    }
    return _evaluServiceView;
}

- (UIButton *)anonBtn{
    if (!_anonBtn) {
        _anonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (self.showReviewStatus == NO)
        {
            _anonBtn.frame = CGRectMake(5, 5, 45, 30);

        }
        else
        {
            _anonBtn.frame = CGRectMake(5, 10, 45, 30);

        }

        
//        _anonBtn.layer.masksToBounds = YES;
//        _anonBtn.layer.cornerRadius = .8;
        
        [_anonBtn setImage:[UIImage imageNamed:@"singleCheck_unselect.png"] forState:UIControlStateNormal];
        
        [_anonBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _anonBtn;
}

- (DLStarRatingControl *)StarRatingControl{
    if (!_StarRatingControl) {
        _StarRatingControl = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(75, 0, 180, 49)];
        _StarRatingControl.delegate = self;
       // _StarRatingControl.backgroundColor = [UIColor grayColor];
        _StarRatingControl.tag = 100;
        
    }
    return _StarRatingControl;
}

- (PlaceholderTextView *)contentTextView
{
    if (!_contentTextView)
    {
        _contentTextView = [[PlaceholderTextView alloc] init];
        
        _contentTextView.frame = CGRectMake(15, 50, 290, 87);
        
        _contentTextView.placeholder = L(@"HTellTheseWordsToFriends");//@"请输入使用心得(5-500个字以内)";
        
        _contentTextView.layer.borderWidth = 0.4;
        _contentTextView.layer.borderColor = RGBCOLOR(232, 232, 232).CGColor;
        _contentTextView.layer.masksToBounds = YES;
        
        _contentTextView.textColor = [UIColor blackColor];
        _contentTextView.font = [UIFont systemFontOfSize:15.0];
        _contentTextView.backgroundColor = [UIColor clearColor];
        _contentTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        
        _contentTextView.keyboardType = UIKeyboardTypeDefault;
        
        _contentTextView.returnKeyType = UIReturnKeyDone;

        _contentTextView.delegate = self;
    }
    return _contentTextView;
}


- (void)click{
    if (_isAnonFlag == NO) {
        self.evaluationBasicDto.anonFlag = @"1";
        [self.anonBtn setImage:[UIImage imageNamed:@"singleCheck_selected.png"] forState:UIControlStateNormal];
        _isAnonFlag = YES;
    }else{
        self.evaluationBasicDto.anonFlag = @"0";
        [self.anonBtn setImage:[UIImage imageNamed:@"singleCheck_unselect.png"] forState:UIControlStateNormal];
        _isAnonFlag = NO;
    }
}

#pragma mark -
#pragma mark tableview delegate/datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if (!self.isBook && section == 1) {
    //        return 0;
    //    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //    if (self.isBook) {
//    if (self.showReviewStatus) {
//        return 1;
//    }
    
    return 3;
    //    }
    //    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        return 115;
    }
    else if(indexPath.section == 1)// && self.isBook)
    {
        return 152;
    }
    else if(indexPath.section == 2){
        
        if (self.showReviewStatus == NO)
        {
            return 160;
        }
        else
        {
            return 50;
        }

        return 160;//138;
    }
    
    
    //    }else if (indexPath.section == 2 && !self.isBook){
    //        return 100;
    //    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (section == 0) {
//        return 115;
//    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section == 1 || (section == 0 && self.showReviewStatus)) {
//        return ;
//    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    if (section == 0) {
//        return self.headView;
//    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    
//    if (section == 1 || (section == 0 && self.showReviewStatus)) {
//        UIView *footView = [[UIView alloc] init];
//        footView.frame = CGRectMake(0, 0, 320, 50);
//        footView.backgroundColor = [UIColor grayColor];
//        
//        UILabel *label = [[UILabel alloc] init];
//        label.frame = CGRectMake(43, 15, 100, 40);
//        label.backgroundColor = [UIColor clearColor];
//        label.text = @"匿名评价";
//        label.font = [UIFont systemFontOfSize:15.0];
//        label.textColor = [UIColor blackColor];
//        [footView addSubview:label];
//        
//        [footView addSubview:self.anonBtn];
//        
//        return footView;
//    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *evalutionContontIdentifier = @"evalutionContontIdentifier";
    
    SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:evalutionContontIdentifier];
    
    if(cell == nil)
    {
        cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:evalutionContontIdentifier];
        cell.textLabel.textColor = [UIColor dark_Gray_Color];//[UIColor darkTextColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.backgroundView.size = CGSizeMake(290, 80);
    
    if(indexPath.section == 0)
    {
        [cell.contentView addSubview:self.headView];
    }
    else if(indexPath.section == 1)
    {
        [cell.contentView addSubview:self.evalutionView];
    }else if (indexPath.section == 2)
    {
        [cell.contentView addSubview:self.evaluServiceView];
    }
    
    cell.clipsToBounds = YES;
    
    return cell;
}


#pragma mark -
#pragma mark uitextfield delegate
//点击完成按钮或者done时，失去焦点
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

//点击完成按钮或者done时，失去焦点
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }else{
        return YES;
    }
    
}


#pragma mark -
#pragma mark  DlStarRatingDelegate Method

- (void)newRating:(DLStarRatingControl *)control :(NSUInteger)rating{
    if (control.tag == 100) {
        DLog(@"100");
        self.evaluationBasicDto.qualityStar = STR_FROM_INT(rating);
    }else if(control.tag == 101){
        DLog(@"101");
        self.evaluationBasicDto.attitudeStar = STR_FROM_INT(rating);
    }else if(control.tag == 102){
        DLog(@"102");
        self.evaluationBasicDto.dlvrSpeedStar = STR_FROM_INT(rating);

//        self.evaluationBasicDto.sellerSpeedStar = STR_FROM_INT(rating);
    }
//    else if(control.tag == 103){
//        DLog(@"103");
//        self.evaluationBasicDto.dlvrSpeedStar = STR_FROM_INT(rating);
//    }
}


@end
