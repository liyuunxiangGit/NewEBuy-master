//
//  SNOnSaleViewController.m
//  SuningEBuy
//
//  Created by 芳奎 赵 on 12-9-18.
//  Copyright (c) 2012年 苏宁. All rights reserved.
//
//
//  Changed by 孔斌 on 13-7-29.

#import "SNSpecialSubjectViewController.h"

#import "SNActivityViewController.h"

#define ImageTag   100

@interface SNSpecialSubjectViewController()

@property(nonatomic,strong) UIImageView         *titleImageView;   //标题栏背景

@property(nonatomic,strong) UILabel             *titileLable;      //标题

@property(nonatomic,strong) UIButton            *backBtn;          //返回按钮

@property(nonatomic,strong) UIView              *titleView;        //title栏黑色背景

/*
 *description:点击活动图片出发的事件：跳转到活动详情页面
 *parame:activityId 活动id
 */
-(void)gotoActivityViewControllerWithActivityId:(NSString *) activityId sortType:(NSString *)prdSortType actName:(NSString *)actName;

@end

@implementation SNSpecialSubjectViewController

@synthesize specialSubjectDto = _specialSubjectDto;
@synthesize titleImageView    = _titleImageView;
@synthesize titileLable       = _titileLable;
@synthesize backBtn           = _backBtn;
@synthesize superViewController;
@synthesize service = _service;
@synthesize titleView = _titleView;

- (id)init {
    self = [super init];
    if (self) {
        self.title = L(@"OSHotTopic");
        _specialSubjectDto = [[SNSpecialSubjectDTO alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        self.iOS7FullScreenLayout = YES;
    }
    return self;
}

- (id)initWithSpecialSubjectDto:(SNSpecialSubjectDTO *)dto
{
    self = [super init];
    if (self)
    {
        self.specialSubjectDto = dto;
        self.title = dto.areaName;
        self.hidesBottomBarWhenPushed = YES;
        self.iOS7FullScreenLayout = YES;
    }
    return self;
}

- (UIColor *)titleBgColorAtIndex:(NSInteger)index
{
    NSArray *colors = @[RGBCOLOR(235, 49, 111),
                        RGBCOLOR(39, 169, 232),
                        RGBCOLOR(255, 118, 44),
                        RGBCOLOR(140, 118, 218),
                        RGBCOLOR(233, 138, 143),
                        RGBCOLOR(0, 159, 152),
                        RGBCOLOR(251, 181, 63),
                        RGBCOLOR(12, 166, 128),];
    return [colors safeObjectAtIndex:index];
}

- (void)setSpecialSubjectDto:(SNSpecialSubjectDTO *)specialSubjectDto{
    if (_specialSubjectDto != specialSubjectDto) {
        TT_RELEASE_SAFELY(_specialSubjectDto);
        _specialSubjectDto = specialSubjectDto;
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"sale_hotTopic"),_specialSubjectDto.areaName];
        self.title = _specialSubjectDto.areaName;
        self.titileLable.text = _specialSubjectDto.areaName;
        
        
//        NSString *imageName = [NSString stringWithFormat:@"sn_newOnSale_title_background%@.png",titleColorTemp1];
//        self.titleImageView.image = [UIImage streImageNamed:imageName];
//        [self.view insertSubview:self.tableView aboveSubview:self.titleImageView];
        
//        [self.view insertSubview:self.titleImageView aboveSubview:self.titleView];
//        [self.view insertSubview:self.titleImageView belowSubview:self.titileLable];
//        [self.view insertSubview:self.titleImageView belowSubview:self.backBtn];
        [self.tableView reloadData];
    }
}

//- (UINavigationController *)navigationController
//{
//    return self.superViewController.navigationController;
//}

-(void) dealloc
{
    TT_RELEASE_SAFELY(_specialSubjectDto);
    TT_RELEASE_SAFELY(_titleImageView);
    TT_RELEASE_SAFELY(_titileLable);
    SERVICE_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_backBtn);
    TT_RELEASE_SAFELY(_titleView);
}
- (SpecialSubjectService *)service
{
    if (!_service) {
        _service = [[SpecialSubjectService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

#pragma mark -
#pragma mark life cycle

-(void)loadView
{
    [super loadView];
//    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:!self.hidesBottomBarWhenPushed];

	self.tableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    
    self.tableView.scrollEnabled = YES;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView addSubview:self.refreshHeaderView];
    
//    [self.view addSubview:self.titleView];
//    
//    [self.view addSubview:self.backBtn];
//
//    [self.view addSubview:self.titileLable];
//    
//    [self.view addSubview:self.emptyLabel];
//
    
    [self.view addSubview:self.tableView];
    self.hasSuspendButton = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /*
    NSString *titleColorTemp1 = self.specialSubjectDto.areaBgColor;
    UIColor *color = [self titleBgColorAtIndex:[titleColorTemp1 integerValue]];
    if (color)
    {
        AuthManagerNavViewController *nav = (AuthManagerNavViewController *)self.navigationController;
        [nav setNavBarBackgoundWithColor:color];
    }
     */
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    /*
    AuthManagerNavViewController *nav = (AuthManagerNavViewController *)self.navigationController;
    [nav setNavigationBackground:NO];
     */
}

- (void)viewAppear
{
    [super viewWillAppear:NO];
    
}

- (void)viewDisappear
{
    [super viewWillDisappear:NO];
}

#pragma mark -
#pragma mark views

- (UIImageView *)titleImageView
{
    if (!_titleImageView)
    {
        _titleImageView = [[UIImageView alloc] init];
        NSString *titleColorTemp1 = self.specialSubjectDto.areaBgColor;
        NSString *imageName = [NSString stringWithFormat:@"sn_newOnSale_title_background%@.png",titleColorTemp1];
        _titleImageView.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage imageNamed:imageName];
        UIImage *streImage = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:0];
        _titleImageView.image=streImage;
        _titleImageView.frame=CGRectMake(0, 0, 320, 44);
    }
    return _titleImageView;
}


-(UILabel *)titileLable
{
    if (!_titileLable)
    {
        _titileLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        _titileLable.text=self.specialSubjectDto.areaName;
        _titileLable.font = [UIFont boldSystemFontOfSize:20];
        _titileLable.textAlignment = UITextAlignmentCenter;
        _titileLable.backgroundColor = [UIColor clearColor];
        _titileLable.textColor = [UIColor whiteColor];
        _titileLable.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    }
    return _titileLable;
}

- (UILabel *)emptyLabel{
    if (!_emptyLabel) {
        _emptyLabel = [[UILabel alloc] init];
        _emptyLabel.frame = CGRectMake(60, 120, 200, 200);
        _emptyLabel.backgroundColor = [UIColor clearColor];
        _emptyLabel.text = L(@"OSSorryForEnd");
        _emptyLabel.textColor = [UIColor grayColor];
        _emptyLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _emptyLabel.textAlignment = UITextAlignmentCenter;
        _emptyLabel.numberOfLines = 0;
        _emptyLabel.hidden = YES;
    }
    return _emptyLabel;
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        //        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 12, 24, 18)];
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 2, 40, 40)];
        
        
        //        NSString *titleColorTemp1 = self.specialSubjectDto.areaBgColor;
        //        if ([titleColorTemp1 isEqualToString:@"7"]) {
        //            [_backBtn setBackgroundImage:[UIImage imageNamed:@"onSale_backBtn.png"] forState:UIControlStateNormal];
        //        }
        //        else{
        //        [_backBtn setImage:[UIImage imageNamed:@"onSale_backBtn.png"] forState:UIControlStateNormal];
        //        }
        
        //        _backBtn.layer.frame = CGRectMake(0, 0, 40, 40);
        [_backBtn setImage:[UIImage imageNamed:@"onSale_backBtn.png"]
                  forState:UIControlStateNormal];
        
        [_backBtn addTarget:self action:@selector(backToNewHome) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
        _titleView.frame = CGRectMake(0, 0, 320, 40);
        _titleView.backgroundColor = [UIColor blackColor];
    }
    return _titleView;
}

- (void)backToNewHome{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//每个section的行数：由“模板类型”和“areaAddRow”决定
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (IsArrEmpty(self.specialSubjectDto.actList)) {
        
        self.emptyLabel.hidden = NO;
        
        return 0;
    }
    else
    {
        self.emptyLabel.hidden = YES;
    }
    
    NSInteger areaStyleType = [self.specialSubjectDto.areaStyleType intValue];
    
    switch (areaStyleType)
    {
        case 4:
        {
            return 5+[self.specialSubjectDto.areaAddRow intValue];
        }
            break;
        case 6:
        {
            return 2+[self.specialSubjectDto.areaAddRow intValue];
        }
            break;
        case 7:{
            return 2+[self.specialSubjectDto.areaAddRow intValue];
        }
            break;
        case 8:{
            return 3+[self.specialSubjectDto.areaAddRow intValue];
        }
            break;
        case 9:{
            return 3+[self.specialSubjectDto.areaAddRow intValue];
        }
            break;
        case 10:{
            return 3+[self.specialSubjectDto.areaAddRow intValue];
        }
            break;
        case 11:{
            return 3+[self.specialSubjectDto.areaAddRow intValue];
        }
        default:
        {
            return 4+[self.specialSubjectDto.areaAddRow intValue];
        }
            break;
    }
}

//每个section只有一行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//每行的高度
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger areaStyleType = [self.specialSubjectDto.areaStyleType intValue];
    NSInteger section = indexPath.section;
    switch (areaStyleType) {
            // 专题模板1
        case 1:
        {
            if (section==0)
            {
                return 141;
            }
            else
            {
                return 75;
            }
        }
            break;
            // 专题模板2
        case 2:
        {
            if (section==0)
            {
                return 141;
            }
            else
            {
                return 75;
            }
        }
            break;
            // 专题模板3
        case 3:
        {
            if (section==0)
            {
                return 141;
            }
            else
            {
                return 75;
            }
        }
            break;
            // 专题模板4
        case 4:
        {
            return 75;
        }
            break;
            // 专题模板5
        case 5:
        {
            return 91;
        }
            break;
            // 专题模板6
        case 6:
        {
            if (section==0)
            {
                return 291;
            }else
            {
                return 75;
            }
        }
            // 专题模板7
        case 7:
        {
            if (section==0) {
                return 160;
            }else{
                return 305;
            }
        }
            // 专题模板8
        case 8:
        {
            if (section==0) {
                return 160+10;
            }else{
                return 160;
            }
        }
            // 专题模板9
        case 9:
        {
            if (section==0) {
                return 160+10;
            }else{
                return 140;
            }
        }
            // 专题模板10
        case 10:
        {
            if (section==0) {
                return 125;
            }else{
                return 157;
            }
        }
            // 专题模板11
        case 11:
        {
            if (section==0)
            {
                return 160+10;
            }else if(section == 1)
            {
                return 135;
            }else{
                return 80;
            }
            
        }
            break;
        default:
            break;
    }
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger areaStyleType = [self.specialSubjectDto.areaStyleType intValue];
    
    switch (areaStyleType)
    {
            // 专题模板1
        case 1:
        {
            if (indexPath.section == 0) {
                
                static NSString *modelOne_actPositionOne= @"modelOne_actPositionOne";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelOne_actPositionOne];
                
                SNActivityDTO *dto = [self.specialSubjectDto.actList objectAtIndex:0];
                
                if (cell == nil) {
                    
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelOne_actPositionOne];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                    
                    SNOnSaleActivityImageView *imageView = [[SNOnSaleActivityImageView alloc] init];
                    
                    imageView.exDelegate = self;
                    
                    imageView.tag = ImageTag;
                    
                    [cell.contentView addSubview:imageView];
                    
                    TT_RELEASE_SAFELY(imageView);
                    
                }
                
                SNOnSaleActivityImageView *imageView = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                
                imageView.activityId=dto.activityId;
                
                imageView.sortType =dto.prdSortType;
                
                imageView.actName = dto.actName;
                
                imageView.frame=CGRectMake(0, 0, 320, 141);
                
                imageView.imageURL = [NSURL URLWithString:dto.actPictureUrl];
                
                return cell;
            }
            else
            {
                
                static NSString *modelOne_ = @"modelOne_";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelOne_];
                
                SNActivityDTO *dto1 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section *2)-1 ];
                SNActivityDTO *dto2 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section *2) ];
                
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelOne_];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                    SNOnSaleActivityImageView *imageView1 = [[SNOnSaleActivityImageView alloc] init];
                    imageView1.exDelegate = self;
                    SNOnSaleActivityImageView *imageView2 = [[SNOnSaleActivityImageView alloc] init];
                    imageView2.exDelegate = self;
                    
                    imageView1.tag = ImageTag + 1;
                    imageView2.tag = ImageTag + 2;
                    
                    imageView1.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
                    imageView1.layer.borderWidth = 0.5;
                    
                    imageView2.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
                    imageView2.layer.borderWidth = 0.5;
                    
                    [cell.contentView addSubview:imageView1];
                    [cell.contentView addSubview:imageView2];
                    
                    TT_RELEASE_SAFELY(imageView1);
                    
                    TT_RELEASE_SAFELY(imageView2);
                }
                
                SNOnSaleActivityImageView *imageView1 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag + 1];
                SNOnSaleActivityImageView *imageView2 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag + 2];;
                
                imageView1.activityId=dto1.activityId;
                imageView2.activityId=dto2.activityId;
                
                imageView1.actName = dto1.actName;
                imageView2.actName = dto2.actName;
                
                imageView1.sortType=dto1.prdSortType;
                imageView2.sortType=dto2.prdSortType;
                
                imageView1.frame=CGRectMake(0, 0, 160, 75);
                imageView2.frame=CGRectMake(160, 0, 160, 75);
                
                imageView1.imageURL = [NSURL URLWithString:dto1.actPictureUrl];
                imageView2.imageURL = [NSURL URLWithString:dto2.actPictureUrl];
                
                
                return cell;
            }
            
            
        }
            break;
            // 专题模板2
        case 2:
        {
            if (indexPath.section == 0) {
                
                static NSString *modelTwo_actPositionOne= @"modelTwo_actPositionOne";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelTwo_actPositionOne];
                
                SNActivityDTO *dto = [self.specialSubjectDto.actList objectAtIndex:0 ];
                
                if (cell == nil) {
                    
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelTwo_actPositionOne];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];

                    SNOnSaleActivityImageView *imageView = [[SNOnSaleActivityImageView alloc] init];
                    imageView.exDelegate = self;
                    imageView.tag = ImageTag;
                    [cell.contentView addSubview:imageView];
                    
                    TT_RELEASE_SAFELY(imageView);
                    
                }
                
                SNOnSaleActivityImageView *imageView = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                imageView.frame=CGRectMake(0, 0, 320, 141);
                
                imageView.activityId=dto.activityId;
                imageView.imageURL = [NSURL URLWithString:dto.actPictureUrl];
                imageView.sortType = dto.prdSortType;
                imageView.actName = dto.actName;
                
                return cell;
            }
            else
            {
                
                static NSString *modelTwo_ = @"modelTwo_ ";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelTwo_];
                
                SNActivityDTO *dto1 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section *3-2) ];
                SNActivityDTO *dto2 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section *3)-1 ];
                SNActivityDTO *dto3 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section *3) ];
                
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelTwo_];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];

                    SNOnSaleActivityImageView *imageView1 = [[SNOnSaleActivityImageView alloc] init];
                    imageView1.exDelegate = self;
                    SNOnSaleActivityImageView *imageView2 = [[SNOnSaleActivityImageView alloc] init];
                    imageView2.exDelegate = self;
                    SNOnSaleActivityImageView *imageView3 = [[SNOnSaleActivityImageView alloc] init];
                    imageView3.exDelegate = self;
                    
                    imageView1.tag = ImageTag;
                    imageView2.tag = ImageTag+1;
                    imageView3.tag = ImageTag+2;
                    
                    [cell.contentView addSubview:imageView1];
                    [cell.contentView addSubview:imageView2];
                    [cell.contentView addSubview:imageView3];
                    
                    TT_RELEASE_SAFELY(imageView1);
                    
                    TT_RELEASE_SAFELY(imageView2);
                    
                    TT_RELEASE_SAFELY(imageView3);
                    
                }
                
                SNOnSaleActivityImageView *imageView1 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                SNOnSaleActivityImageView *imageView2 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+1];
                SNOnSaleActivityImageView *imageView3 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+2];
                
                imageView1.frame=CGRectMake(0, 0, 106, 75);
                imageView2.frame=CGRectMake(106, 0, 106, 75);
                imageView3.frame=CGRectMake(212, 0, 106, 75);
                
                imageView1.imageURL = [NSURL URLWithString:dto1.actPictureUrl];
                imageView2.imageURL = [NSURL URLWithString:dto2.actPictureUrl];
                imageView3.imageURL = [NSURL URLWithString:dto3.actPictureUrl];
                
                imageView1.activityId=dto1.activityId;
                imageView2.activityId=dto2.activityId;
                imageView3.activityId=dto3.activityId;
                
                imageView1.sortType=dto1.prdSortType;
                imageView2.sortType=dto2.prdSortType;
                imageView3.sortType=dto3.prdSortType;
                
                imageView1.actName = dto1.actName;
                imageView2.actName = dto2.actName;
                imageView3.actName = dto3.actName;
                
                return cell;
            }
            
        }
            break;
            // 专题模板3
        case 3:
        {
            if (indexPath.section==0 ) {
                static NSString *modelThree_actPositionOne= @"modelThree_actPositionOne";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelThree_actPositionOne];
                
                SNActivityDTO *dto = [self.specialSubjectDto.actList objectAtIndex:indexPath.section];
                
                if (cell == nil) {
                    
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelThree_actPositionOne];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];

                    SNOnSaleActivityImageView *imageView = [[SNOnSaleActivityImageView alloc] init];
                    imageView.exDelegate = self;
                    imageView.tag = ImageTag;
                    [cell.contentView addSubview:imageView];
                    TT_RELEASE_SAFELY(imageView);
                    
                }
                
                SNOnSaleActivityImageView *imageView = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                imageView.activityId=dto.activityId;
                imageView.sortType=dto.prdSortType;
                imageView.actName = dto.actName;
                imageView.frame=CGRectMake(0, 0, 320, 141);
                imageView.imageURL = [NSURL URLWithString:dto.actPictureUrl];
                
                return cell;
                
            }else if(indexPath.section==1){
                
                static NSString *modelThree_actPositionTwo= @"modelThree_actPositionTwo";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelThree_actPositionTwo];
                
                SNActivityDTO *dto1 = [self.specialSubjectDto.actList objectAtIndex:indexPath.section];
                SNActivityDTO *dto2 = [self.specialSubjectDto.actList objectAtIndex:indexPath.section+1];
                
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelThree_actPositionTwo];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];

                    SNOnSaleActivityImageView *imageView1 = [[SNOnSaleActivityImageView alloc] init];
                    imageView1.exDelegate = self;
                    SNOnSaleActivityImageView *imageView2 = [[SNOnSaleActivityImageView alloc] init];
                    imageView2.exDelegate = self;
                    
                    imageView1.tag = ImageTag;
                    imageView2.tag = ImageTag + 1;
                    
                    [cell.contentView addSubview:imageView1];
                    [cell.contentView addSubview:imageView2];
                    
                    TT_RELEASE_SAFELY(imageView1);
                    TT_RELEASE_SAFELY(imageView2);
                }
                
                
                SNOnSaleActivityImageView *imageView1 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                SNOnSaleActivityImageView *imageView2 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+1];
                
                imageView1.activityId=dto1.activityId;
                imageView2.activityId=dto2.activityId;
                
                imageView1.sortType=dto1.prdSortType;
                imageView2.sortType=dto2.prdSortType;
                
                imageView1.actName = dto1.actName;
                imageView2.actName = dto2.actName;
                
                imageView1.frame=CGRectMake(0, 0, 160, 75);
                imageView2.frame=CGRectMake(160, 0, 160, 75);
                
                imageView1.imageURL = [NSURL URLWithString:dto1.actPictureUrl];
                imageView2.imageURL = [NSURL URLWithString:dto2.actPictureUrl];
                
                
                return cell;
                
            }else{
                static NSString *modelThree_ = @"modelThree_ ";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelThree_];
                
                SNActivityDTO *dto1 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section-1)*3 ];
                SNActivityDTO *dto2 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section-1)*3+1 ];
                SNActivityDTO *dto3 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section-1)*3+2 ];
                
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelThree_];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];

                    SNOnSaleActivityImageView *imageView1 = [[SNOnSaleActivityImageView alloc] init];
                    imageView1.exDelegate = self;
                    SNOnSaleActivityImageView *imageView2 = [[SNOnSaleActivityImageView alloc] init];
                    imageView2.exDelegate = self;
                    SNOnSaleActivityImageView *imageView3 = [[SNOnSaleActivityImageView alloc] init];
                    imageView3.exDelegate = self;
                    
                    
                    imageView1.tag = ImageTag;
                    imageView2.tag = ImageTag + 1;
                    imageView3.tag = ImageTag + 2;
                    
                    [cell.contentView addSubview:imageView1];
                    [cell.contentView addSubview:imageView2];
                    [cell.contentView addSubview:imageView3];
                    
                    TT_RELEASE_SAFELY(imageView1);
                    TT_RELEASE_SAFELY(imageView2);
                    TT_RELEASE_SAFELY(imageView3);
                    
                }
                SNOnSaleActivityImageView *imageView1 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                SNOnSaleActivityImageView *imageView2 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+1];
                SNOnSaleActivityImageView *imageView3 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+2];
                
                imageView1.frame=CGRectMake(1, 0, 106, 75);
                imageView2.frame=CGRectMake(107, 0, 106, 75);
                imageView3.frame=CGRectMake(213, 0, 106, 75);
                
                imageView1.activityId=dto1.activityId;
                imageView2.activityId=dto2.activityId;
                imageView3.activityId=dto3.activityId;
                
                imageView1.sortType=dto1.prdSortType;
                imageView2.sortType=dto2.prdSortType;
                imageView3.sortType=dto3.prdSortType;
                
                imageView1.imageURL = [NSURL URLWithString:dto1.actPictureUrl];
                imageView2.imageURL = [NSURL URLWithString:dto2.actPictureUrl];
                imageView3.imageURL = [NSURL URLWithString:dto3.actPictureUrl];
                
                imageView1.actName = dto1.actName;
                imageView2.actName = dto2.actName;
                imageView3.actName = dto3.actName;
                
                
                return cell;
            }
            
        }
            break;
            // 专题模板4
        case 4:
        {
            static NSString *modelFour_ = @"modelFour_ ";
            
            UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelFour_];
            
            SNActivityDTO *dto1 = [self.specialSubjectDto.actList objectAtIndex:indexPath.section*2 ];
            SNActivityDTO *dto2 = [self.specialSubjectDto.actList objectAtIndex:indexPath.section*2+1 ];
            
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelFour_];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];

                SNOnSaleActivityImageView *imageView1 = [[SNOnSaleActivityImageView alloc] init];
                imageView1.exDelegate = self;
                SNOnSaleActivityImageView *imageView2 = [[SNOnSaleActivityImageView alloc] init];
                imageView2.exDelegate = self;
                
                imageView1.tag = ImageTag;
                imageView2.tag = ImageTag + 1;
                
                imageView1.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
                imageView1.layer.borderWidth = 0.5;
                
                imageView2.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
                imageView2.layer.borderWidth = 0.5;
                
                [cell.contentView addSubview:imageView1];
                [cell.contentView addSubview:imageView2];
                
                TT_RELEASE_SAFELY(imageView1);
                TT_RELEASE_SAFELY(imageView2);
                
                
            }
            
            SNOnSaleActivityImageView *imageView1 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
            SNOnSaleActivityImageView *imageView2 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+1];
            
            imageView1.activityId=dto1.activityId;
            imageView2.activityId=dto2.activityId;
            
            imageView1.sortType=dto1.prdSortType;
            imageView2.sortType=dto2.prdSortType;
            
            imageView1.frame=CGRectMake(0, 0, 160, 75);
            imageView2.frame=CGRectMake(160, 0, 160, 75);
            
            imageView1.imageURL = [NSURL URLWithString:dto1.actPictureUrl];
            imageView2.imageURL = [NSURL URLWithString:dto2.actPictureUrl];
            
            imageView1.actName = dto1.actName;
            imageView2.actName = dto2.actName;
            
            return cell;
        }
            
            break;
            // 专题模板5
        case 5:
        {
            static NSString *modelFive_ = @"modelFive_ ";
            
            UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelFive_];
            
            SNActivityDTO *dto = [self.specialSubjectDto.actList objectAtIndex:indexPath.section ];
            
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelFive_];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];

                SNOnSaleActivityImageView *imageView = [[SNOnSaleActivityImageView alloc] init];
                imageView.exDelegate = self;
                imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
                imageView.layer.borderWidth = 0.5;
                imageView.tag = ImageTag;
                [cell.contentView addSubview:imageView];
                TT_RELEASE_SAFELY(imageView);
            }
            
            SNOnSaleActivityImageView *imageView = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
            imageView.activityId=dto.activityId;
            imageView.sortType=dto.prdSortType;
            imageView.frame=CGRectMake(0, 0, 320, 91);
            imageView.imageURL = [NSURL URLWithString:dto.actPictureUrl];
            imageView.actName = dto.actName;
            
            return cell;
            
        }
            break;
            // 专题模板6
        case 6:
        {
            if (indexPath.section==0) {
                static NSString *modelSix_ = @"modelSix_ ";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelSix_];
                
                SNActivityDTO *dto1 = [self.specialSubjectDto.actList objectAtIndex:0 ];
                SNActivityDTO *dto2 = [self.specialSubjectDto.actList objectAtIndex:1 ];
                SNActivityDTO *dto3 = [self.specialSubjectDto.actList objectAtIndex:2 ];
                SNActivityDTO *dto4 = [self.specialSubjectDto.actList objectAtIndex:3 ];
                SNActivityDTO *dto5 = [self.specialSubjectDto.actList objectAtIndex:4 ];
                SNActivityDTO *dto6 = [self.specialSubjectDto.actList objectAtIndex:5 ];
                
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelSix_];
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];

                    
                    SNOnSaleActivityImageView *imageView1 = [[SNOnSaleActivityImageView alloc] init];
                    imageView1.exDelegate = self;
                    SNOnSaleActivityImageView *imageView2 = [[SNOnSaleActivityImageView alloc] init];
                    imageView2.exDelegate = self;
                    SNOnSaleActivityImageView *imageView3 = [[SNOnSaleActivityImageView alloc] init];
                    imageView3.exDelegate = self;
                    SNOnSaleActivityImageView *imageView4 = [[SNOnSaleActivityImageView alloc] init];
                    imageView4.exDelegate = self;
                    SNOnSaleActivityImageView *imageView5 = [[SNOnSaleActivityImageView alloc] init];
                    imageView5.exDelegate = self;
                    SNOnSaleActivityImageView *imageView6 = [[SNOnSaleActivityImageView alloc] init];
                    imageView6.exDelegate = self;
                    
                    imageView1.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
                    imageView1.layer.borderWidth = 0.5;
                    
                    imageView2.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
                    imageView2.layer.borderWidth = 0.5;
                    
                    imageView3.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
                    imageView3.layer.borderWidth = 0.5;
                    
                    imageView4.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
                    imageView4.layer.borderWidth = 0.5;
                    
                    imageView5.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
                    imageView5.layer.borderWidth = 0.5;
                    
                    imageView6.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
                    imageView6.layer.borderWidth = 0.5;
                    
                    imageView1.tag = ImageTag;
                    imageView2.tag = ImageTag + 1;
                    imageView3.tag = ImageTag + 2;
                    imageView4.tag = ImageTag + 3;
                    imageView5.tag = ImageTag + 4;
                    imageView6.tag = ImageTag + 5;
                    
                    [cell.contentView addSubview:imageView1];
                    [cell.contentView addSubview:imageView2];
                    [cell.contentView addSubview:imageView3];
                    [cell.contentView addSubview:imageView4];
                    [cell.contentView addSubview:imageView5];
                    [cell.contentView addSubview:imageView6];
                    
                    TT_RELEASE_SAFELY(imageView1);
                    TT_RELEASE_SAFELY(imageView2);
                    TT_RELEASE_SAFELY(imageView3);
                    TT_RELEASE_SAFELY(imageView4);
                    TT_RELEASE_SAFELY(imageView5);
                    TT_RELEASE_SAFELY(imageView6);
                    
                }
                
                SNOnSaleActivityImageView *imageView1 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                SNOnSaleActivityImageView *imageView2 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+1];
                SNOnSaleActivityImageView *imageView3 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+2];
                SNOnSaleActivityImageView *imageView4 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+3];
                SNOnSaleActivityImageView *imageView5 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+4];
                SNOnSaleActivityImageView *imageView6 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+5];
                
                imageView1.activityId=dto1.activityId;
                imageView2.activityId=dto2.activityId;
                imageView3.activityId=dto3.activityId;
                imageView4.activityId=dto4.activityId;
                imageView5.activityId=dto5.activityId;
                imageView6.activityId=dto6.activityId;
                
                imageView1.sortType=dto1.prdSortType;
                imageView2.sortType=dto2.prdSortType;
                imageView3.sortType=dto3.prdSortType;
                imageView4.sortType=dto4.prdSortType;
                imageView5.sortType=dto5.prdSortType;
                imageView6.sortType=dto6.prdSortType;
                
                imageView1.actName = dto1.actName;
                imageView2.actName = dto2.actName;
                imageView3.actName = dto3.actName;
                imageView4.actName = dto4.actName;
                imageView5.actName = dto5.actName;
                imageView6.actName = dto6.actName;
                
                imageView1.frame=CGRectMake(0, 0, 213, 96);
                imageView2.frame=CGRectMake(213,0, 107, 145.5);
                imageView3.frame=CGRectMake(0, 96, 106.5, 99);
                
                imageView4.frame=CGRectMake(106.5, 96,106.5,99);
                imageView5.frame=CGRectMake(213, 145.5, 107, 145.5);
                imageView6.frame=CGRectMake(0, 195, 213, 96);
                
                imageView1.imageURL = [NSURL URLWithString:dto1.actPictureUrl];
                imageView2.imageURL = [NSURL URLWithString:dto2.actPictureUrl];
                imageView3.imageURL = [NSURL URLWithString:dto3.actPictureUrl];
                imageView4.imageURL = [NSURL URLWithString:dto4.actPictureUrl];
                imageView5.imageURL = [NSURL URLWithString:dto5.actPictureUrl];
                imageView6.imageURL = [NSURL URLWithString:dto6.actPictureUrl];
                
                
                return cell;
            }else
            {
                static NSString *modelSix_ = @"modelSix_ ";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelSix_];
                SNActivityDTO *dto1 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section +1)*3 ];
                SNActivityDTO *dto2 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section +1)*3+1];
                SNActivityDTO *dto3 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section +1)*3+2];
                
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelSix_];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];

                    SNOnSaleActivityImageView *imageView1 = [[SNOnSaleActivityImageView alloc] init];
                    imageView1.exDelegate = self;
                    SNOnSaleActivityImageView *imageView2 = [[SNOnSaleActivityImageView alloc] init];
                    imageView2.exDelegate = self;
                    SNOnSaleActivityImageView *imageView3 = [[SNOnSaleActivityImageView alloc] init];
                    imageView3.exDelegate = self;
                    
                    imageView1.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
                    imageView1.layer.borderWidth = 0.5;
                    
                    imageView2.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
                    imageView2.layer.borderWidth = 0.5;
                    
                    imageView3.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
                    imageView3.layer.borderWidth = 0.5;
                    
                    imageView1.tag = ImageTag;
                    imageView2.tag = ImageTag + 1;
                    imageView3.tag = ImageTag + 2;
                    
                    [cell.contentView addSubview:imageView1];
                    [cell.contentView addSubview:imageView2];
                    [cell.contentView addSubview:imageView3];
                    
                    TT_RELEASE_SAFELY(imageView1);
                    TT_RELEASE_SAFELY(imageView2);
                    TT_RELEASE_SAFELY(imageView3);
                }
                
                
                SNOnSaleActivityImageView *imageView1 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                SNOnSaleActivityImageView *imageView2 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+1];
                SNOnSaleActivityImageView *imageView3 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+2];
                
                imageView1.activityId=dto1.activityId;
                imageView2.activityId=dto2.activityId;
                imageView3.activityId=dto3.activityId;
                
                imageView1.sortType=dto1.prdSortType;
                imageView2.sortType=dto2.prdSortType;
                imageView3.sortType=dto3.prdSortType;
                
                imageView1.frame=CGRectMake(1, 0, 106, 75);
                imageView2.frame=CGRectMake(107, 0, 106, 75);
                imageView3.frame=CGRectMake(213, 0, 106, 75);
                
                imageView1.imageURL = [NSURL URLWithString:dto1.actPictureUrl];
                imageView2.imageURL = [NSURL URLWithString:dto2.actPictureUrl];
                imageView3.imageURL = [NSURL URLWithString:dto3.actPictureUrl];
                
                imageView1.actName = dto1.actName;
                imageView2.actName = dto2.actName;
                imageView3.actName = dto3.actName;
                
                
                return cell;
            }
        }
            break;
            // 专题模块7
        case 7:
        {
            if (indexPath.section==0) {
                static NSString *modelSeven_actPositionOne= @"modelSeven_actPositionOne";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelSeven_actPositionOne];
                
                SNActivityDTO *dto = [self.specialSubjectDto.actList objectAtIndex:indexPath.section];
                
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelSeven_actPositionOne];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];

                    SNOnSaleActivityImageView *imageView = [[SNOnSaleActivityImageView alloc] init];
                    imageView.exDelegate = self;
                    imageView.tag = ImageTag;
                    [cell.contentView addSubview:imageView];
                    
                    TT_RELEASE_SAFELY(imageView);
                    
                }
                
                SNOnSaleActivityImageView *imageView = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                imageView.activityId=dto.activityId;
                imageView.sortType=dto.prdSortType;
                imageView.actName = dto.actName;
                imageView.frame=CGRectMake(10, 10, 300, 150);
                imageView.imageURL = [NSURL URLWithString:dto.actPictureUrl];
                
                return cell;
            }
            else {
                static NSString *modelSeven_= @"modelSeven_";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelSeven_];
                
                SNActivityDTO *dto1 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section*5)-4];
                SNActivityDTO *dto2 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section*5)-3];
                SNActivityDTO *dto3 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section*5)-2];
                SNActivityDTO *dto4 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section*5)-1];
                SNActivityDTO *dto5 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section*5)];
                                
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelSeven_];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];
                    
                    UIView *backgroundLineTop = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 320, 1)];
                    backgroundLineTop.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
                    [cell.contentView addSubview:backgroundLineTop];
                    
                    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 11, 320, 293)];
                    backgroundView.backgroundColor = [UIColor whiteColor];
                    [cell.contentView addSubview:backgroundView];
                    
                    UIView *backgroundLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 305, 320, 1)];
                    backgroundLineBottom.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
                    [cell.contentView addSubview:backgroundLineBottom];
                    

                    SNOnSaleActivityImageView *imageView1 = [[SNOnSaleActivityImageView alloc] init];
                    imageView1.exDelegate = self;
                    SNOnSaleActivityImageView *imageView2 = [[SNOnSaleActivityImageView alloc] init];
                    imageView2.exDelegate = self;
                    SNOnSaleActivityImageView *imageView3 = [[SNOnSaleActivityImageView alloc] init];
                    imageView3.exDelegate = self;
                    SNOnSaleActivityImageView *imageView4 = [[SNOnSaleActivityImageView alloc] init];
                    imageView4.exDelegate = self;
                    SNOnSaleActivityImageView *imageView5 = [[SNOnSaleActivityImageView alloc] init];
                    imageView5.exDelegate = self;
                    
                    
                    imageView1.tag = ImageTag;
                    imageView2.tag = ImageTag + 1;
                    imageView3.tag = ImageTag + 2;
                    imageView4.tag = ImageTag + 3;
                    imageView5.tag = ImageTag + 4;
                    
                    
                    [cell.contentView addSubview:imageView1];
                    [cell.contentView addSubview:imageView2];
                    [cell.contentView addSubview:imageView3];
                    [cell.contentView addSubview:imageView4];
                    [cell.contentView addSubview:imageView5];
                    
                    
                    TT_RELEASE_SAFELY(imageView1);
                    TT_RELEASE_SAFELY(imageView2);
                    TT_RELEASE_SAFELY(imageView3);
                    TT_RELEASE_SAFELY(imageView4);
                    TT_RELEASE_SAFELY(imageView5);
                }
                
                SNOnSaleActivityImageView *imageView1 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                SNOnSaleActivityImageView *imageView2 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+1];
                SNOnSaleActivityImageView *imageView3 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+2];
                SNOnSaleActivityImageView *imageView4 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+3];
                SNOnSaleActivityImageView *imageView5 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+4];
                
                imageView1.frame=CGRectMake(10, 20, 145, 180);
                imageView2.frame=CGRectMake(165, 20, 145, 85);
                imageView3.frame=CGRectMake(165, 115, 145, 85);
                imageView4.frame=CGRectMake(10, 210, 145, 85);
                imageView5.frame=CGRectMake(165, 210, 145, 85);
                
                imageView1.activityId=dto1.activityId;
                imageView2.activityId=dto2.activityId;
                imageView3.activityId=dto3.activityId;
                imageView4.activityId=dto4.activityId;
                imageView5.activityId=dto5.activityId;
                
                imageView1.sortType=dto1.prdSortType;
                imageView2.sortType=dto2.prdSortType;
                imageView3.sortType=dto3.prdSortType;
                imageView4.sortType=dto4.prdSortType;
                imageView5.sortType=dto5.prdSortType;
                
                imageView1.imageURL = [NSURL URLWithString:dto1.actPictureUrl];
                imageView2.imageURL = [NSURL URLWithString:dto2.actPictureUrl];
                imageView3.imageURL = [NSURL URLWithString:dto3.actPictureUrl];
                imageView4.imageURL = [NSURL URLWithString:dto4.actPictureUrl];
                imageView5.imageURL = [NSURL URLWithString:dto5.actPictureUrl];
                
                
                imageView1.actName = dto1.actName;
                imageView2.actName = dto2.actName;
                imageView3.actName = dto3.actName;
                imageView4.actName = dto4.actName;
                imageView5.actName = dto5.actName;
                
                
                
                return cell;
                
            }
            //            else{
            //                static NSString *modelSeven_ = @"modelSeven_";
            //
            //                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelSeven_];
            //
            //                SNActivityDTO *dto1 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section*2)];
            //                SNActivityDTO *dto2 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section*2)+1];
            //
            //                if (cell == nil) {
            //                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelSeven_] autorelease];
            //
            //                    SNOnSaleActivityImageView *imageView1 = [[SNOnSaleActivityImageView alloc] init];
            //                    imageView1.exDelegate = self;
            //                    SNOnSaleActivityImageView *imageView2 = [[SNOnSaleActivityImageView alloc] init];
            //                    imageView2.exDelegate = self;
            //
            //                    imageView1.tag = ImageTag;
            //                    imageView2.tag = ImageTag + 1;
            //
            //                    [cell.contentView addSubview:imageView1];
            //                    [cell.contentView addSubview:imageView2];
            //
            //                    TT_RELEASE_SAFELY(imageView1);
            //                    TT_RELEASE_SAFELY(imageView2);
            //                }
            //
            //
            //                SNOnSaleActivityImageView *imageView1 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
            //                SNOnSaleActivityImageView *imageView2 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+1];
            //
            //                imageView1.activityId=dto1.activityId;
            //                imageView2.activityId=dto2.activityId;
            //
            //                imageView1.sortType=dto1.prdSortType;
            //                imageView2.sortType=dto2.prdSortType;
            //
            //                imageView1.actName = dto1.actName;
            //                imageView2.actName = dto2.actName;
            //
            //                imageView1.frame=CGRectMake(10, 6, 147, 70);
            //                imageView2.frame=CGRectMake(162, 6, 147, 70);
            //
            //                imageView1.imageURL = [NSURL URLWithString:dto1.actPictureUrl];
            //                imageView2.imageURL = [NSURL URLWithString:dto2.actPictureUrl];
            //
            //
            //                return cell;
            //
            //            }
        }
            break;
            // 专题模板8
        case 8:
        {
            if (indexPath.section==0) {
                static NSString *modelEight_actPositionOne= @"modelEight_actPositionOne";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelEight_actPositionOne];
                
                SNActivityDTO *dto = [self.specialSubjectDto.actList objectAtIndex:indexPath.section];
                
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelEight_actPositionOne];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];

                    SNOnSaleActivityImageView *imageView = [[SNOnSaleActivityImageView alloc] init];
                    imageView.exDelegate = self;
                    imageView.tag = ImageTag;
                    [cell.contentView addSubview:imageView];
                    
                    TT_RELEASE_SAFELY(imageView);
                    
                }
                
                SNOnSaleActivityImageView *imageView = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                imageView.activityId=dto.activityId;
                imageView.sortType=dto.prdSortType;
                imageView.actName = dto.actName;
                imageView.frame=CGRectMake(10, 10, 300, 150);
                imageView.imageURL = [NSURL URLWithString:dto.actPictureUrl];
                
                return cell;
            }else{
                static NSString *modelEight_ = @"modelEight_";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelEight_];
                
                SNActivityDTO *dto = [self.specialSubjectDto.actList objectAtIndex:indexPath.section];
                
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelEight_];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];

                    SNOnSaleActivityImageView *imageView = [[SNOnSaleActivityImageView alloc] init];
                    imageView.exDelegate = self;
                    //                    imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
                    //                    imageView.layer.borderWidth = 0.8;
                    imageView.tag = ImageTag;
                    [cell.contentView addSubview:imageView];
                    TT_RELEASE_SAFELY(imageView);
                }
                
                SNOnSaleActivityImageView *imageView = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                imageView.activityId=dto.activityId;
                imageView.sortType=dto.prdSortType;
                imageView.frame=CGRectMake(10, 0, 300, 150);
                imageView.imageURL = [NSURL URLWithString:dto.actPictureUrl];
                imageView.actName = dto.actName;
                
                return cell;
            }
        }
            break;
            // 专题模板9
        case 9:
        {
            if (indexPath.section==0) {
                static NSString *modelNine_actPositionOne= @"modelNine_actPositionOne";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelNine_actPositionOne];
                
                SNActivityDTO *dto = [self.specialSubjectDto.actList objectAtIndex:indexPath.section];
                
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelNine_actPositionOne];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];

                    SNOnSaleActivityImageView *imageView = [[SNOnSaleActivityImageView alloc] init];
                    imageView.exDelegate = self;
                    imageView.tag = ImageTag;
                    [cell.contentView addSubview:imageView];
                    
                    TT_RELEASE_SAFELY(imageView);
                    
                }
                
                SNOnSaleActivityImageView *imageView = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                imageView.activityId=dto.activityId;
                imageView.sortType=dto.prdSortType;
                imageView.actName = dto.actName;
                imageView.frame=CGRectMake(10, 10, 300, 150);
                imageView.imageURL = [NSURL URLWithString:dto.actPictureUrl];
                
                return cell;
            }else if(indexPath.section % 2 !=0){
                static NSString *modelNine_actPositionTwo= @"modelNine_actPositionTwo";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelNine_actPositionTwo];
                
                SNActivityDTO *dto1 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section *3-2) ];
                SNActivityDTO *dto2 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section *3)-1 ];
                SNActivityDTO *dto3 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section *3) ];
                
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelNine_actPositionTwo];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];

                    SNOnSaleActivityImageView *imageView1 = [[SNOnSaleActivityImageView alloc] init];
                    imageView1.exDelegate = self;
                    SNOnSaleActivityImageView *imageView2 = [[SNOnSaleActivityImageView alloc] init];
                    imageView2.exDelegate = self;
                    SNOnSaleActivityImageView *imageView3 = [[SNOnSaleActivityImageView alloc] init];
                    imageView3.exDelegate = self;
                    
                    
                    imageView1.tag = ImageTag;
                    imageView2.tag = ImageTag + 1;
                    imageView3.tag = ImageTag + 2;
                    
                    [cell.contentView addSubview:imageView1];
                    [cell.contentView addSubview:imageView2];
                    [cell.contentView addSubview:imageView3];
                    
                    TT_RELEASE_SAFELY(imageView1);
                    TT_RELEASE_SAFELY(imageView2);
                    TT_RELEASE_SAFELY(imageView3);
                }
                
                SNOnSaleActivityImageView *imageView1 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                SNOnSaleActivityImageView *imageView2 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+1];
                SNOnSaleActivityImageView *imageView3 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+2];
                
                imageView1.frame=CGRectMake(10, 0, 210, 130);
                imageView2.frame=CGRectMake(230, 0, 80, 60);
                imageView3.frame=CGRectMake(230, 70, 80, 60);
                
                imageView1.activityId=dto1.activityId;
                imageView2.activityId=dto2.activityId;
                imageView3.activityId=dto3.activityId;
                
                imageView1.sortType=dto1.prdSortType;
                imageView2.sortType=dto2.prdSortType;
                imageView3.sortType=dto3.prdSortType;
                
                imageView1.imageURL = [NSURL URLWithString:dto1.actPictureUrl];
                imageView2.imageURL = [NSURL URLWithString:dto2.actPictureUrl];
                imageView3.imageURL = [NSURL URLWithString:dto3.actPictureUrl];
                
                imageView1.actName = dto1.actName;
                imageView2.actName = dto2.actName;
                imageView3.actName = dto3.actName;
                
                
                return cell;
            }else if(indexPath.section % 2 == 0&&indexPath.section != 0){
                static NSString *modelNine_actPositionThree= @"modelNine_actPositionThree";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelNine_actPositionThree];
                
                SNActivityDTO *dto1 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section *3-2) ];
                SNActivityDTO *dto2 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section *3)-1 ];
                SNActivityDTO *dto3 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section *3) ];
                
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelNine_actPositionThree];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];

                    SNOnSaleActivityImageView *imageView1 = [[SNOnSaleActivityImageView alloc] init];
                    imageView1.exDelegate = self;
                    SNOnSaleActivityImageView *imageView2 = [[SNOnSaleActivityImageView alloc] init];
                    imageView2.exDelegate = self;
                    SNOnSaleActivityImageView *imageView3 = [[SNOnSaleActivityImageView alloc] init];
                    imageView3.exDelegate = self;
                    
                    
                    imageView1.tag = ImageTag;
                    imageView2.tag = ImageTag + 1;
                    imageView3.tag = ImageTag + 2;
                    
                    [cell.contentView addSubview:imageView1];
                    [cell.contentView addSubview:imageView2];
                    [cell.contentView addSubview:imageView3];
                    
                    TT_RELEASE_SAFELY(imageView1);
                    TT_RELEASE_SAFELY(imageView2);
                    TT_RELEASE_SAFELY(imageView3);
                }
                
                SNOnSaleActivityImageView *imageView1 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                SNOnSaleActivityImageView *imageView2 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+1];
                SNOnSaleActivityImageView *imageView3 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+2];
                
                imageView1.frame=CGRectMake(10, 0, 80, 60);
                imageView2.frame=CGRectMake(100, 0, 210, 130);
                imageView3.frame=CGRectMake(10, 70, 80, 60);
                
                imageView1.activityId=dto1.activityId;
                imageView2.activityId=dto2.activityId;
                imageView3.activityId=dto3.activityId;
                
                imageView1.sortType=dto1.prdSortType;
                imageView2.sortType=dto2.prdSortType;
                imageView3.sortType=dto3.prdSortType;
                
                imageView1.imageURL = [NSURL URLWithString:dto1.actPictureUrl];
                imageView2.imageURL = [NSURL URLWithString:dto2.actPictureUrl];
                imageView3.imageURL = [NSURL URLWithString:dto3.actPictureUrl];
                
                imageView1.actName = dto1.actName;
                imageView2.actName = dto2.actName;
                imageView3.actName = dto3.actName;
                
                
                return cell;
            }
            
        }
            break;
            // 专题模板10
        case 10:
        {
            if (indexPath.section==0) {
                static NSString *modelTen_actPositionOne= @"modelTen_actPositionOne";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelTen_actPositionOne];
                
                SNActivityDTO *dto = [self.specialSubjectDto.actList objectAtIndex:indexPath.section];
                
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelTen_actPositionOne];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];

                    SNOnSaleActivityImageView *imageView = [[SNOnSaleActivityImageView alloc] init];
                    imageView.exDelegate = self;
                    imageView.tag = ImageTag;
                    [cell.contentView addSubview:imageView];
                    
                    TT_RELEASE_SAFELY(imageView);
                    
                }
                
                SNOnSaleActivityImageView *imageView = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                imageView.activityId=dto.activityId;
                imageView.sortType=dto.prdSortType;
                imageView.actName = dto.actName;
                imageView.frame=CGRectMake(0, 0, 320, 120);
                imageView.imageURL = [NSURL URLWithString:dto.actPictureUrl];
                
                return cell;
            }else{
                static NSString *modelTen_= @"modelTen_";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelTen_];
                
                SNActivityDTO *dto1 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section*2)-1];
                SNActivityDTO *dto2 = [self.specialSubjectDto.actList objectAtIndex:indexPath.section*2];
                
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelTen_];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];

                    SNOnSaleActivityImageView *imageView1 = [[SNOnSaleActivityImageView alloc] init];
                    imageView1.exDelegate = self;
                    SNOnSaleActivityImageView *imageView2 = [[SNOnSaleActivityImageView alloc] init];
                    imageView2.exDelegate = self;
                    
                    imageView1.tag = ImageTag;
                    imageView2.tag = ImageTag + 1;
                    
                    [cell.contentView addSubview:imageView1];
                    [cell.contentView addSubview:imageView2];
                    
                    TT_RELEASE_SAFELY(imageView1);
                    TT_RELEASE_SAFELY(imageView2);
                }
                
                
                SNOnSaleActivityImageView *imageView1 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                SNOnSaleActivityImageView *imageView2 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+1];
                
                imageView1.activityId=dto1.activityId;
                imageView2.activityId=dto2.activityId;
                
                imageView1.sortType=dto1.prdSortType;
                imageView2.sortType=dto2.prdSortType;
                
                imageView1.actName = dto1.actName;
                imageView2.actName = dto2.actName;
                
                imageView1.frame=CGRectMake(10, 3, 150, 150);
                imageView2.frame=CGRectMake(160, 3, 150, 150);
                
                imageView1.imageURL = [NSURL URLWithString:dto1.actPictureUrl];
                imageView2.imageURL = [NSURL URLWithString:dto2.actPictureUrl];
                
                
                return cell;
            }
        }
            break;
            // 专题模板11
        case 11:{
            if (indexPath.section==0) {
                static NSString *modelEleven_actPositionOne= @"modelEleven_actPositionOne";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelEleven_actPositionOne];
                
                SNActivityDTO *dto = [self.specialSubjectDto.actList objectAtIndex:indexPath.section];
                
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelEleven_actPositionOne];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];

                    SNOnSaleActivityImageView *imageView = [[SNOnSaleActivityImageView alloc] init];
                    imageView.exDelegate = self;
                    imageView.tag = ImageTag;
                    [cell.contentView addSubview:imageView];
                    
                    TT_RELEASE_SAFELY(imageView);
                    
                }
                
                SNOnSaleActivityImageView *imageView = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                imageView.activityId=dto.activityId;
                imageView.sortType=dto.prdSortType;
                imageView.actName = dto.actName;
                imageView.frame=CGRectMake(10, 10, 300, 150);
                imageView.imageURL = [NSURL URLWithString:dto.actPictureUrl];
                
                return cell;
            }else if(indexPath.section == 1){
                static NSString *modelEleven_actPositionTwo = @"modelEleven_actPositionTwo ";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelEleven_actPositionTwo];
                
                SNActivityDTO *dto1 = [self.specialSubjectDto.actList objectAtIndex:indexPath.section ];
                SNActivityDTO *dto2 = [self.specialSubjectDto.actList objectAtIndex:indexPath.section+1 ];
                
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelEleven_actPositionTwo];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];

                    SNOnSaleActivityImageView *imageView1 = [[SNOnSaleActivityImageView alloc] init];
                    imageView1.exDelegate = self;
                    SNOnSaleActivityImageView *imageView2 = [[SNOnSaleActivityImageView alloc] init];
                    imageView2.exDelegate = self;
                    
                    imageView1.tag = ImageTag;
                    imageView2.tag = ImageTag + 1;
                    
                    //                    imageView1.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
                    //                    imageView1.layer.borderWidth = 0.5;
                    //
                    //                    imageView2.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
                    //                    imageView2.layer.borderWidth = 0.5;
                    
                    [cell.contentView addSubview:imageView1];
                    [cell.contentView addSubview:imageView2];
                    
                    TT_RELEASE_SAFELY(imageView1);
                    TT_RELEASE_SAFELY(imageView2);
                    
                    
                }
                
                SNOnSaleActivityImageView *imageView1 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                SNOnSaleActivityImageView *imageView2 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+1];
                
                imageView1.activityId=dto1.activityId;
                imageView2.activityId=dto2.activityId;
                
                imageView1.sortType=dto1.prdSortType;
                imageView2.sortType=dto2.prdSortType;
                
                imageView1.frame=CGRectMake(10, 0, 145, 125);
                imageView2.frame=CGRectMake(165, 0, 145, 125);
                
                imageView1.imageURL = [NSURL URLWithString:dto1.actPictureUrl];
                imageView2.imageURL = [NSURL URLWithString:dto2.actPictureUrl];
                
                imageView1.actName = dto1.actName;
                imageView2.actName = dto2.actName;
                
                return cell;
            }else{
                static NSString *modelEleven_ = @"modelEleven_ ";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelEleven_];
                
                SNActivityDTO *dto1 = [self.specialSubjectDto.actList objectAtIndex:indexPath.section*2-1 ];
                SNActivityDTO *dto2 = [self.specialSubjectDto.actList objectAtIndex:indexPath.section*2 ];
                
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelEleven_];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.backgroundColor = [UIColor clearColor];

                    SNOnSaleActivityImageView *imageView1 = [[SNOnSaleActivityImageView alloc] init];
                    imageView1.exDelegate = self;
                    SNOnSaleActivityImageView *imageView2 = [[SNOnSaleActivityImageView alloc] init];
                    imageView2.exDelegate = self;
                    
                    imageView1.tag = ImageTag;
                    imageView2.tag = ImageTag + 1;
                    
                    //                    imageView1.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
                    //                    imageView1.layer.borderWidth = 0.5;
                    //
                    //                    imageView2.layer.borderColor = RGBCOLOR(204, 204, 204).CGColor;
                    //                    imageView2.layer.borderWidth = 0.5;
                    
                    [cell.contentView addSubview:imageView1];
                    [cell.contentView addSubview:imageView2];
                    
                    TT_RELEASE_SAFELY(imageView1);
                    TT_RELEASE_SAFELY(imageView2);
                    
                    
                }
                
                SNOnSaleActivityImageView *imageView1 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag];
                SNOnSaleActivityImageView *imageView2 = (SNOnSaleActivityImageView *)[cell.contentView viewWithTag:ImageTag+1];
                
                imageView1.activityId=dto1.activityId;
                imageView2.activityId=dto2.activityId;
                
                imageView1.sortType=dto1.prdSortType;
                imageView2.sortType=dto2.prdSortType;
                
                imageView1.frame=CGRectMake(10, 0, 145, 70);
                imageView2.frame=CGRectMake(165, 0, 145, 70);
                
                imageView1.imageURL = [NSURL URLWithString:dto1.actPictureUrl];
                imageView2.imageURL = [NSURL URLWithString:dto2.actPictureUrl];
                
                imageView1.actName = dto1.actName;
                imageView2.actName = dto2.actName;
                
                return cell;
            }
            
        }
            break;
        default:
            break;
    }
    return [UITableViewCell new];
}

#pragma mark - refresh Metods
#pragma mark   刷新页面

- (void)refreshData{
    [super refreshData];
    [self displayOverFlowActivityView];
    [self sendSpecialSubjectListHttpRequest];
    //    [[NSNotificationCenter defaultCenter]postNotificationName:Refresh_SpecialSubject_Views object:nil userInfo:nil];
}

- (void)refreshDataComplete{
    [super refreshDataComplete];
    [self removeOverFlowActivityView];
}

#pragma mark -
#pragma mark EGOImageViewExDelegate method
- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx
{
    SNOnSaleActivityImageView *temp=(SNOnSaleActivityImageView *)imageViewEx;
    
    [self gotoActivityViewControllerWithActivityId:temp.activityId sortType:temp.sortType actName:temp.actName];
    
}


-(void)gotoActivityViewControllerWithActivityId:(NSString *) activityId sortType:(NSString *)prdSortType actName:(NSString *)actName
{
    
    //王家兴添加跳转到活动页面的连接
    SNActivityViewController *activityVC=[[SNActivityViewController alloc] initWithActName:actName areaName:nil];
    activityVC.activityId=activityId;
    activityVC.prdSortType=prdSortType;
    [self.navigationController pushViewController:activityVC animated:YES];
}

- (void)sendSpecialSubjectListHttpRequest
{
    [self.service beginGetSpecialSubjectsRequest:@"10" withPomAreaId:self.specialSubjectDto.areaId];
}

- (void)getSpecialSubjectsCompletionWithResult:(BOOL)isSuccess
                                      errorMsg:(NSString *)errorMsg
                                   subjectList:(NSArray *)list
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        
        [self.view hideNetworkErrorView];
        
        if ([list count] == 1) {
            self.specialSubjectDto = [list objectAtIndex:0];
        }
        
        [self refreshDataComplete];
    }else{
//        [self presentSheet:errorMsg];
        
        __weak SNSpecialSubjectViewController *weakSelf = self;
        [self.view showNetworkErrorViewWithRefreshBlock:^{
            
            [weakSelf refreshData];
        }];
    }
}

@end
