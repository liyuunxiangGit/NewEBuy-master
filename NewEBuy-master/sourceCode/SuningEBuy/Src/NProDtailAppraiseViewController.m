//
//  NProDtailAppraiseViewController.m
//  SuningEBuy
//
//  Created by xmy on 23/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NProDtailAppraiseViewController.h"
#import "UITableViewCell+BgView.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

@interface NProDtailAppraiseViewController ()

@end

@implementation NProDtailAppraiseViewController
@synthesize isListLoaded = isListLoaded;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_evalutionService);
}

- (id)init
{
    self = [super init];
    if (self) {
        
        self.currentPage = 1;
        self.isLastPage = YES;
    }
    return self;
}

- (void)loadView
{
    //[self.headView addSubview:self.synthesisBtn];
    [self.headView addSubview:self.goodBtn];
    [self.headView addSubview:self.midBtn];
    [self.headView addSubview:self.badBtn];
    //[self.headView addSubview:self.disOrderBtn];
    [self.headView addSubview:self.btnClickedImg];
    
    CGFloat height = [[UIScreen mainScreen] bounds].size.height-20-44-36;
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 36, 320, height)];
    //[self labelView];
    //[self tagList];
    UIView *contentView = self.view;
	CGRect frame = contentView.bounds;
	self.tableView.frame = frame;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin;
    self.tableView.tableHeaderView = self.headView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    //[self.swipe setDirection:UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight];
    //[self.view addGestureRecognizer:self.swipe];
}

- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = [UIColor clearColor];
        _headView.frame = CGRectMake(0, 0, 320, 41);
//        UIImageView *separateLine_Bottom = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39.5, 320, 0.5)];
//        separateLine_Bottom.image = [UIImage streImageNamed:@"line.png"];
//        [_headView addSubview:separateLine_Bottom];
    }
    return _headView;
}

//- (UIView *)labelView
//{
//    if (!_labelView) {
//        _labelView = [[UIView alloc] initWithFrame:CGRectMake(36, 0, 320, 80)];
//        _labelView.backgroundColor = [UIColor clearColor];
//        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
//        [_labelView addSubview:leftLabel];
//    }
//    return _labelView;
//}

-(NSArray *)btnArray{
    
    if (!_btnArray) {
        
        _btnArray = [[NSArray alloc] initWithObjects:self.goodBtn,self.midBtn,self.badBtn, nil];
    }
    return _btnArray;
}

- (void)setBtnsPropetry:(UIButton*)btn
{
    [btn addTarget:self action:@selector(btnChangeAppraiseAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    [btn setTitleColor:[UIColor orange_Light_Color] forState:UIControlStateSelected];
    [btn setBackgroundImage:[UIImage imageNamed:@"button_white_normal.png"] forState:UIControlStateNormal];
    
    [btn setBackgroundImage:[UIImage imageNamed:@"button_white_clicked.png"] forState:UIControlStateSelected];
    
    [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateSelected];
    
    [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    
//    btn.titleLabel.numberOfLines = 2;
//    
//    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
//    if (btn.tag != 10004) {
//        UIImageView *separateLine_Interval = [[UIImageView alloc] initWithFrame:CGRectMake(btn.width - 1, 5, 1, 30)];
//        separateLine_Interval.image = [UIImage imageNamed:@"segment_line_vertical_gray.png"];
//        [btn addSubview:separateLine_Interval];
//    }
    
}
//
//- (UIImageView *)btnClickedImg
//{
//    if (!_btnClickedImg) {
//        _btnClickedImg = [[UIImageView alloc] init];
//        _btnClickedImg.image = [UIImage streImageNamed:@"segment_line_Horizontal_orange.png"];
//        _btnClickedImg.frame = CGRectMake(10, 39, 60, 1);
//    }
//    return _btnClickedImg;
//}
//
//- (UIButton *)synthesisBtn
//{
//    if (!_synthesisBtn) {
//        _synthesisBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 60, 40)];
//        [_synthesisBtn setTitle:[NSString stringWithFormat:@"%@\n(0)",L(@"BTComprehensive")] forState:UIControlStateNormal];
//        _synthesisBtn.tag = 10000;
//        [self setBtnsPropetry:_synthesisBtn];
//        _synthesisBtn.selected = YES;
//    }
//    return _synthesisBtn;
//}

- (UIButton *)goodBtn
{
    if (!_goodBtn) {
//        _goodBtn = [[UIButton alloc] initWithFrame:CGRectMake(70, 0, 60, 40)];
//        [_goodBtn setTitle:[NSString stringWithFormat:@"%@\n(0)",L(@"Product_GoodComment")] forState:UIControlStateNormal];
//        _goodBtn.tag = 10001;
        _goodBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
        [_goodBtn setTitle:[NSString stringWithFormat:@"%@(0)",L(@"Product_GoodComment")] forState:UIControlStateNormal];
        _goodBtn.tag = 10000;
        [self setBtnsPropetry:_goodBtn];
        _goodBtn.selected = YES;
    }
    return _goodBtn;
}

- (UIButton *)midBtn
{
    if (!_midBtn) {
//        _midBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, 0, 60, 40)];
//        [_midBtn setTitle:[NSString stringWithFormat:@"%@\n(0)",L(@"Product_MiddleComment")] forState:UIControlStateNormal];
//        _midBtn.tag = 10002;
        _midBtn = [[UIButton alloc] initWithFrame:CGRectMake(110, 10, 100, 30)];
        [_midBtn setTitle:[NSString stringWithFormat:@"%@(0)",L(@"Product_MiddleComment")] forState:UIControlStateNormal];
        _midBtn.tag = 10001;
        [self setBtnsPropetry:_midBtn];
    }
    return _midBtn;
}

- (UIButton *)badBtn
{
    if (!_badBtn) {
//        _badBtn = [[UIButton alloc] initWithFrame:CGRectMake(190, 0, 60, 40)];
//        [_badBtn setTitle:[NSString stringWithFormat:@"%@\n(0)",L(@"Product_BadComment")] forState:UIControlStateNormal];
//        _badBtn.tag = 10003;
        _badBtn = [[UIButton alloc] initWithFrame:CGRectMake(210, 10, 100, 30)];
        [_badBtn setTitle:[NSString stringWithFormat:@"%@(0)",L(@"Product_BadComment")] forState:UIControlStateNormal];
        _midBtn.tag = 10002;
        [self setBtnsPropetry:_badBtn];
    }
    return _badBtn;
}

//- (UIButton *)disOrderBtn
//{
//    if (!_disOrderBtn) {
//        _disOrderBtn = [[UIButton alloc] initWithFrame:CGRectMake(250, 0, 60, 40)];
//        [_disOrderBtn setTitle:[NSString stringWithFormat:@"%@\n(0)",L(@"MyEBuy_DisplayOrder")] forState:UIControlStateNormal];
//        _disOrderBtn.tag = 10004;
//        [self setBtnsPropetry:_disOrderBtn];
//    }
//    return _disOrderBtn;
//}
//
//-(DWTagListWithoutAnimation *)tagList
//{
//    if (!_tagList)
//    {
//        _tagList=[[DWTagListWithoutAnimation alloc] initWithFrame:CGRectMake(80, 0, 240, 80)];
//        
//        _tagList.tagDelegate = self;
//        [_tagList setAutomaticResize:YES];
//    }
//    return _tagList;
//}
//
//- (UISwipeGestureRecognizer *)swipe
//{
//    if (!_swipe) {
//        _swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(changePageInEvaluation:)];
//        _swipe.delegate = self;
//    }
//    return _swipe;
//}
//
//- (void)changePageInEvaluation:(UISwipeGestureRecognizer *)recognizer
//{
//    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft)
//    {
//        for (UIButton *btn in _btnArray)
//        {
//            if (btn.selected && (btn.tag != 10004))
//            {
//                for (int i=0;i<[self.btnArray count];i++)
//                {
//                    
//                    UIButton *obj1 = (UIButton *)[self.btnArray objectAtIndex:i];
//                    if (btn == obj1)
//                    {
//                        UIButton *obj2 = (UIButton *)[self.btnArray objectAtIndex:(i + 1)];
//                        [self btnChangeAppraiseAction:obj2];
//                    }
//                }
//
//            }
//        }
//    }
//    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight)
//    {
//        for (UIButton *btn in _btnArray)
//        {
//            if (btn.selected && (btn.tag != 10000))
//            {
//                for (int i=0;i<[self.btnArray count];i++)
//                {
//                    
//                    UIButton *obj1 = (UIButton *)[self.btnArray objectAtIndex:i];
//                    if (btn == obj1)
//                    {
//                        UIButton *obj2 = (UIButton *)[self.btnArray objectAtIndex:(i - 1)];
//                        [self btnChangeAppraiseAction:obj2];
//                    }
//                }
//                
//            }
//        }
//    }
//}
//
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    if (!isListLoaded) {
        [self refreshData];
    }
}

- (id)initWithProductBasicDTO:(DataProductBasic *)productBasc
{
    self = [super init];
    
    if (self)
    {
        self.title = L(@"Product Appraisal");
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail"),self.title];
        
        self.productBasic = productBasc;
        
        self.currentPage = 1;
        
    }
    return self;
}

- (DataProductBasic *)productBasic
{
    if (!_productBasic) {
        _productBasic = [[DataProductBasic alloc] init];
    }
    return _productBasic;
}

- (NSMutableArray *)productReviewList
{
    if (!_productReviewList)
    {
        _productReviewList = [[NSMutableArray alloc] init];
    }
    return _productReviewList;
}

- (NewEvalutionService *)evalutionService
{
    if (!_evalutionService) {
        _evalutionService = [[NewEvalutionService alloc] init];
        _evalutionService.delegate = self;
    }
    return _evalutionService;
}

//综合/好评/中评/差评/晒单  切换
- (void)btnChangeAppraiseAction:(UIButton *)btn
{
//    if (btn.tag == 10000) {
//        //[SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121401"], nil]];
//        [self sendLabelHttpRequest];
//    }
//    else
    if (btn.tag == 10000)
    {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121401"], nil]];
    }
    else if (btn.tag == 1001)
    {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121402"], nil]];
    }
    else if (btn.tag == 10002)
    {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121403"], nil]];
    }
//    else if (btn.tag == 10004)
//    {
//        //[SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121403"], nil]];
//    }
    //当改按钮没有选中时 点击该按钮响应一下操作
    if (!btn.isSelected) {
        
        //该按钮设为选中
        //其他按钮改为 非选中
        for (int i=0;i<[self.btnArray count];i++) {
            
            UIButton *obj = (UIButton *)[self.btnArray objectAtIndex:i];
            if (btn != obj) {
                
                obj.selected = NO;
            }
            else{
                
                obj.selected = YES;
//                [UIView animateWithDuration:0.4 animations:^{
//                    self.btnClickedImg.frame = CGRectMake(i*60+10, 39, 60, 1);
//                }];
                self.reviewType = i+1;
            }
        }
        
        self.currentPage = 1;
        [self.productReviewList removeAllObjects];
//        self.isLastPage = YES;
        [self sendHttpRequest];
    }
}

//-(void)sendLabelHttpRequest
//{
//    NSString *string = self.productBasic.productCode;
//    [self.evalutionService beginProductDetailEvaluationLabelHttp:string CurrentPage:self.currentPage ReviewType:self.stringType];
//}
//
//-(void)sendHttpRequest1{
//    NSString *string = self.productBasic.productCode;
//    [self.evalutionService beginProductDetailEvaluationNumberHttp:string CurrentPage:self.currentPage ReviewType:self.stringType];
//}

-(void)sendHttpRequest{
    
    //商品颜色Id，版本Id 和 商品Id之间的联系
    NSArray *list = [self.productBasic colorVersionMap];
    //商品相关颜色信息列表
    NSArray *colorItemList = [self.productBasic colorItemList];
    //商品相关版本信息列表
    NSArray *versionItemList = [self.productBasic versionItemList];
    //当前商品的商品编码
    NSString *string = self.productBasic.productCode;
    
    if (versionItemList.count||colorItemList.count) {
        for (DataProductBasic *basic in list) {
            if (IsStrEmpty(string)) {
                string = basic.productCode;
            }else{
                string = [NSString stringWithFormat:@"%@_%@",string,basic.productCode];
            }
        }
    }
    //[self.evalutionService beginProductDetailEvaluationHttp:string CurrentPage:self.currentPage ReviewType:self.stringType];
    [self.evalutionService beginProductDetailEvaluationHttp:string CurrentPage:self.currentPage ReviewType:self.reviewType];
}

- (void)evaluationProductDetailCompletedWithService:(NewEvalutionService *)service isSuccess:(BOOL)isSuccess errorCode:(NSString *)errorMsg list:(NSArray *)array{
    
    //刷新下拉完成
    if (self.isFromHead)
    {
        [self refreshDataComplete];
    }
    else
    {
        [self loadMoreDataComplete];
    }
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    if(isSuccess)
    {
        isListLoaded = YES;
        
        if (self.isFromHead)
        {
            [self.productReviewList removeAllObjects];
//            self.isLastPage = YES;
            [self.productReviewList addObjectsFromArray:array];
        }
        else
        {
            [self.productReviewList addObjectsFromArray:array];
        }
//    }
//    else{
//        isListLoaded = NO;
//    }
//    [self.tableView reloadData];
//}
//
//- (void)evaluationProductAppraisialNumberWithService:(NewEvalutionService *)service isSuccess:(BOOL)isSuccess errorCode:(NSString *)errorMsg
//{
//    if(isSuccess)
//    {
//        isListLoaded = YES;
//        float a = [service.goodNum intValue]?(float)[service.goodNum intValue]/(float)service.totalNum:0;
//        int rate = (int)(a*100);
//        if ([_delegate respondsToSelector:@selector(backRecordsDelegate:Rate:)]) {
//            [_delegate backRecordsDelegate:[NSString stringWithFormat:@"%i",service.totalNum] Rate:[NSString stringWithFormat:@"%i",rate]];
        if ([_delegate respondsToSelector:@selector(backRecordsDelegate:)]) {
            [_delegate backRecordsDelegate:[NSString stringWithFormat:@"%i",service.totalNum]];
        }
        
//        [self.synthesisBtn setTitle:[NSString stringWithFormat:@"%@\n(%d)",L(@"BTComprehensive"),service.totalNum?service.totalNum:0] forState:UIControlStateNormal];
//        
//        [self.goodBtn setTitle:[NSString stringWithFormat:@"%@\n(%@)",L(@"Product_GoodComment"),service.goodNum?service.goodNum:@"0"] forState:UIControlStateNormal];
//        
//        [self.midBtn setTitle:[NSString stringWithFormat:@"%@\n(%@)",L(@"Product_MiddleComment"),service.midNum?service.midNum:@"0"] forState:UIControlStateNormal];
//        
//        [self.badBtn setTitle:[NSString stringWithFormat:@"%@\n(%@)",L(@"Product_BadComment"),service.badNum?service.badNum:@"0"] forState:UIControlStateNormal];
//        
//        [self.disOrderBtn setTitle:[NSString stringWithFormat:@"%@\n(%@)",L(@"MyEBuy_DisplayOrder"),service.dispNum?service.dispNum:@"0"] forState:UIControlStateNormal];
        [self.goodBtn setTitle:[NSString stringWithFormat:@"%@(%@)",L(@"Product_GoodComment"),service.goodNum?service.goodNum:@"0"] forState:UIControlStateNormal];
        
        [self.midBtn setTitle:[NSString stringWithFormat:@"%@(%@)",L(@"Product_MiddleComment"),service.midNum?service.midNum:@"0"] forState:UIControlStateNormal];
        
        [self.badBtn setTitle:[NSString stringWithFormat:@"%@(%@)",L(@"Product_BadComment"),service.badNum?service.badNum:@"0"] forState:UIControlStateNormal];
        
        if (self.currentPage < service.totalPage)
        {
            self.isLastPage = NO;
            
            self.currentPage++;
        }
        else
        {
            self.isLastPage = YES;
        }
        
    }
    else{
        isListLoaded = NO;
    }
    [self.tableView reloadData];

//    }
//    else
//    {
//        isListLoaded = NO;
//    }
//    [self sendHttpRequest2];
//}
//
//- (void)evaluationProductAppraisialLabelWithService:(NewEvalutionService *)service isSuccess:(BOOL)isSuccess errorCode:(NSString *)errorMsg
//{
//    if (isSuccess) {
//        isListLoaded = YES;
//        [_tagList.fontArray removeAllObjects];
//        [_tagList.fontArray addObject:[UIFont systemFontOfSize:12]];
//        
//        [_tagList display];
//        
//        [_tagList.switchHotKeyButtonView removeAllSubviews];
//        for (DWTagListWithoutAnimationView *subview in [_tagList subviews])
//        {
//            if ([subview isKindOfClass:[DWTagListWithoutAnimationView class]])
//            {
//                
//                subview.button.backgroundColor = [UIColor whiteColor];
//                subview.layer.borderWidth = 1.0;
//                subview.layer.borderColor = [UIColor colorWithRGBHex:0xDCDCDC].CGColor;
//                
//            }
//        }
//        _tagList.textArray = service.labelArr;
//    }
//    else
//    {
//        isListLoaded = NO;
//    }
//}
//
//- (NSString *)stringType
//{
//    switch (_reviewType) {
//        case 0:
//        {
//            _stringType = @"total";
//            break;
//        }
//        case 1:
//        {
//            _stringType = @"good";
//            break;
//        }
//        case 2:
//        {
//            _stringType = @"normal";
//            break;
//        }
//        case 3:
//        {
//            _stringType = @"bad";
//            break;
//        }
//        case 4:
//        {
//            _stringType = @"display";
//            break;
//        }
//        default:
//            break;
//    }
//    return _stringType;
}

#pragma mark -
#pragma mark tableview delegate/datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self hasMore])
    {
        return [self.productReviewList count] + 1;
    }
    return [self.productReviewList count];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (_reviewType == 0) {
//        return 80;
//    }
//    return 0;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.productReviewList count] == 0) {
        return 120;
    }
    return 0.0000001;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    if (_reviewType == 0) {
//        UIView *sectionHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
//        [sectionHeadView addSubview:_labelView];
//        [sectionHeadView addSubview:_tagList];
//        return sectionHeadView;
//    }
//    return nil;
//}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([self.productReviewList count] == 0) {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
        footerView.backgroundColor = [UIColor clearColor];
        
        UILabel *tipLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 320, 20)];
        tipLbl.backgroundColor = [UIColor clearColor];
        tipLbl.textColor = [UIColor grayColor];
        tipLbl.textAlignment = NSTextAlignmentCenter;
        tipLbl.text = L(@"No_Data_Error");
        [footerView addSubview:tipLbl];
        return footerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && indexPath.row == [self.productReviewList count]) {
        return  48;
    }
    else
    {
//        NewProductAppraisial_Json_DTO *dto = [self.productReviewList objectAtIndex:indexPath.row];
//        BOOL hasImages = YES;
//        if (IsArrEmpty(dto.images)) {
//            hasImages = NO;
//        }
//        return [SNProductInfoCell heightWithDeailText:dto.content hasImages:hasImages hasFollowComment:@"" andTime:@"" hasOfficeComment:@"" andHead:@""];
        NewProductAppraisalDTO *dto = [self.productReviewList safeObjectAtIndex:indexPath.row];
        return [NewProductAppraisalCell height:dto];
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasMore] && indexPath.row == [self.productReviewList count])
    {
        static NSString *MoreResultIdentify = @"MoreResultIdentify";
		
		UITableViewMoreCell * cell = [tableView dequeueReusableCellWithIdentifier:MoreResultIdentify];
		
		if (cell == nil)
        {
			cell = [[UITableViewMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoreResultIdentify];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.backgroundColor = [UIColor whiteColor];
            
//            [cell setCoolBgViewWithCellPosition:CellPositionBottom];
            
			cell.title = L(@"Get More...");
            
            cell.animating = NO;
            
			return cell;
		}
        
        cell.title = L(@"Get More...");
        
		cell.animating = NO;
		
		return cell;
    }
    
    static NSString *appraisalIdentify=@"appraisalIdentify";
    
//    SNProductInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:appraisalIdentify];
    NewProductAppraisalCell *cell=[tableView dequeueReusableCellWithIdentifier:appraisalIdentify];
    
    if (cell == nil) {
//        cell = [[SNProductInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:appraisalIdentify];
        cell = [[NewProductAppraisalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:appraisalIdentify];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundColor = [UIColor clearColor];
    }
    
    
//    NewProductAppraisial_Json_DTO *dto = [self.productReviewList safeObjectAtIndex:indexPath.row];
    NewProductAppraisalDTO *dto = [self.productReviewList safeObjectAtIndex:indexPath.row];
    
//    if ([self hasMore]) {
//        [cell setCoolBgViewWithCellPosition:CellPositionMake(self.productReviewList.count + 1, indexPath.row)];
//    }else{
//        [cell setCoolBgViewWithCellPosition:CellPositionMake(self.productReviewList.count, indexPath.row)];
//    }
    [cell setItem:dto];
//    [cell clean];
//    cell.userName = dto.nickname;
//    cell.star = [dto.score intValue];
//    cell.likeCount = 0;
//    cell.detailText = dto.content;
//    cell.timeText = [NSString stringWithFormat:@"%@  %@", dto.publishTime, dto.supplierName];
//    cell.followCommentText = @"";
//    cell.followCommentTime = @"";
//    cell.officeCommentHead = @"";
//    cell.officeCommentText = @"";
//    cell.images = dto.images;
//    [cell refresh];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self hasMore] && [self.productReviewList count] == indexPath.row){
        
//        self.tableView.frame = CGRectMake(0, 0, 320, 400);
        
//        [self.groupTableView reloadData];
        [self loadMoreData];
    }
}

#pragma mark -
#pragma mark 下拉刷新和加载更多

- (void)refreshData
{
    [super refreshData];
    
    //self.reviewType = 0;
    self.reviewType = 1;
    
    self.currentPage = 1;
    
    [self sendHttpRequest];
}

- (void)loadMoreData
{
    [super loadMoreData];
    
    [self startMoreAnimation:YES];
    
    [self sendHttpRequest];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
//        if (self.tableView.contentOffset.y < 0)
//        {
//            self.tableView.scrollEnabled = NO;
//        }
        
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	    
    /*判是否加载更多*/
    CGSize contentOffset = [self.tableView contentSize];
    
    CGRect bounds = [self.tableView bounds];
    
    if (scrollView.contentOffset.y + bounds.size.height >= contentOffset.height && contentOffset.height>=(self.view.frame.size.height-92)) {
        
        if([self hasMore]){
            [self loadMoreData];
        }
    }
}

//- (void)switchHotKeywords
//{
//    
//}
//
//- (void)selectedTag:(NSString *)tagName
//{
//    
//}
//

@end
