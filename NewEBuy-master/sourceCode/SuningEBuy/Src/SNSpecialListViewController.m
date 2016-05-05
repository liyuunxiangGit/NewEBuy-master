//
//  SNSpecialListViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-4-10.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SNSpecialListViewController.h"

#import "SNActivityViewController.h"

#define ImageTag   100

@interface SNSpecialListViewController()
{
    BOOL            isOnSaleLoaded;
}

//@property(nonatomic,retain) UIImageView         *titleImageView;   //标题栏背景

//@property(nonatomic,retain) UILabel             *titileLable;      //标题

/*
 *description:点击活动图片出发的事件：跳转到活动详情页面
 *parame:activityId 活动id
 */
-(void)gotoActivityViewControllerWithActivityId:(NSString *) activityId sortType:(NSString *)prdSortType actName:(NSString *)actName;

@end

@implementation SNSpecialListViewController

@synthesize specialSubjectDto = _specialSubjectDto;
//@synthesize titleImageView    = _titleImageView;
//@synthesize titileLable       = _titileLable;
@synthesize service           = _service;


- (id)init {
    self = [super init];
    if (self) {
        
        _specialSubjectDto = [[SNSpecialSubjectDTO alloc] init];
        _specialSubjectDto.areaStyleType = @"9";
        self.pageTitle = L(@"sale_hotPage");
        isOnSaleLoaded = NO;
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
        self.pageTitle = L(@"sale_hotPage");
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)setSpecialSubjectDto:(SNSpecialSubjectDTO *)specialSubjectDto{
    if (_specialSubjectDto != specialSubjectDto) {
        TT_RELEASE_SAFELY(_specialSubjectDto);
        _specialSubjectDto = specialSubjectDto;
        self.title = _specialSubjectDto.areaName;
        self.pageTitle = L(@"sale_hotPage");
        //        UIImageView  *titleImageViewNew = [[UIImageView alloc] init];
        //        NSString *titleColorTemp1 = self.specialSubjectDto.areaBgColor;
        //        NSString *imageName = [NSString stringWithFormat:@"sn_newOnSale_title_background%@.png",titleColorTemp1];
        //        UIImage *image = [UIImage imageNamed:imageName];
        //        UIImage *streImage = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:0];
        //        titleImageViewNew.image=streImage;
        //        titleImageViewNew.frame=CGRectMake(0, 0, 320, 44);
        //        self.titleImageView = titleImageViewNew;
        //        TT_RELEASE_SAFELY(titleImageViewNew);
        //
        //        [self.view insertSubview:self.titleImageView belowSubview:self.titileLable];
        [self.tableView reloadData];
    }
}

-(void) dealloc
{
    
    TT_RELEASE_SAFELY(_specialSubjectDto);
    //    TT_RELEASE_SAFELY(_titleImageView);
    //    TT_RELEASE_SAFELY(_titileLable);
    
    SERVICE_RELEASE_SAFELY(_service);
    
}

#pragma mark -
#pragma mark life cycle

-(void)loadView
{
    [super loadView];
    
//    self.view.backgroundColor = RGBCOLOR(238, 238, 238);
    
//    UIView *contentView = self.view;
//	
//	CGRect frame = contentView.frame;
//	
//	frame.origin.x = 0;
//	
//	frame.origin.y = 0;
//	
//	frame.size.height = contentView.bounds.size.height -  kUITabBarFrameHeight - kUINavigationBarFrameHeight;
	
	self.tableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    
    self.tableView.scrollEnabled = YES;
    
    [self.tableView addSubview:self.refreshHeaderView];
    
    //    [self.view addSubview:self.titileLable];
    
    [self.view addSubview:self.tableView];
    
    self.hasSuspendButton = YES;
    
    self.title = L(@"OSHotPage");
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //使用其他方案进行数据收集，所以不用super了
    //方法必要，需要保留，勿删
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!isOnSaleLoaded) {
        [self displayOverFlowActivityView];
        [self.service beginGetSpecialSubjectsRequest:@"7" withPomAreaId:@""];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //使用其他方案进行数据收集，所以不用super了
    //方法必要，需要保留，勿删
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

//- (UIImageView *)titleImageView
//{
//    if (!_titleImageView)
//    {
//        _titleImageView = [[UIImageView alloc] init];
//        NSString *titleColorTemp1 = self.specialSubjectDto.areaBgColor;
//        NSString *imageName = [NSString stringWithFormat:@"sn_newOnSale_title_background%@.png",titleColorTemp1];
//        UIImage *image = [UIImage imageNamed:imageName];
//        UIImage *streImage = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:0];
//        _titleImageView.image=streImage;
//        _titleImageView.frame=CGRectMake(0, 0, 320, 44);
//    }
//    return _titleImageView;
//}
//
//
//-(UILabel *)titileLable
//{
//    if (!_titileLable)
//    {
//        _titileLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//        _titileLable.text=self.specialSubjectDto.areaName;
//        _titileLable.font = [UIFont boldSystemFontOfSize:20];
//        _titileLable.textAlignment = UITextAlignmentCenter;
//        _titileLable.backgroundColor = [UIColor clearColor];
//        _titileLable.textColor = [UIColor whiteColor];
//        _titileLable.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
//    }
//    return _titileLable;
//}

//每个section的行数：由“模板类型”和“areaAddRow”决定
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger areaStyleType = [self.specialSubjectDto.areaStyleType intValue];
    
    switch (areaStyleType)
    {
        case 1:
        {
            return 4+[self.specialSubjectDto.areaAddRow intValue];
        }
            break;
        case 2:
        {
            return 4+[self.specialSubjectDto.areaAddRow intValue];
        }
            break;
        case 3:
        {
            return 4+[self.specialSubjectDto.areaAddRow intValue];
        }
            break;
        case 4:
        {
            return 5+[self.specialSubjectDto.areaAddRow intValue];
        }
            break;
        case 5:
        {
            return 4+[self.specialSubjectDto.areaAddRow intValue];
        }
            break;
        case 6:
        {
            return 2+[self.specialSubjectDto.areaAddRow intValue];
        }
            break;
        default:
        {
            return 0;
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
            break;
        default:
        {
            return 0;
        }
            break;
    }
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
                
                static NSString *modelOne_ = @"modelOne_ ";
                
                UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:modelOne_];
                
                SNActivityDTO *dto1 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section *2)-1 ];
                SNActivityDTO *dto2 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section *2) ];
                
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelOne_];
                    
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
                
                SNActivityDTO *dto1 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section -1)*3 ];
                SNActivityDTO *dto2 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section -1)*3+1 ];
                SNActivityDTO *dto3 = [self.specialSubjectDto.actList objectAtIndex:(indexPath.section -1)*3+2 ];
                
                if (cell == nil)
                {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:modelThree_];
                    
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
        default:
            break;
    }
    return nil;
}

#pragma mark - refresh Metods
#pragma mark   刷新页面

- (void)refreshData{
    [super refreshData];
    
    [self displayOverFlowActivityView];
    [self.service beginGetSpecialSubjectsRequest:@"7" withPomAreaId:@""];
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
    SNActivityViewController *activityVC=[[SNActivityViewController alloc] initWithActName:actName areaName:self.title];
    activityVC.activityId=activityId;
    activityVC.prdSortType=prdSortType;
    [self.navigationController pushViewController:activityVC animated:YES];
}


#pragma mark -
#pragma mark service

- (SpecialSubjectService *)service
{
    if (!_service) {
        _service = [[SpecialSubjectService alloc] init];
        _service.delegate = self;
    }
    return _service;
}


- (void)getSpecialSubjectsCompletionWithResult:(BOOL)isSuccess
                                      errorMsg:(NSString *)errorMsg
                                   subjectList:(NSArray *)list
{
    [self removeOverFlowActivityView];
    
    if (isSuccess) {
        if (!IsArrEmpty(list)) {
            isOnSaleLoaded = YES;
            
            [self.view hideNetworkErrorView];
            
            NSMutableArray *specialSortArr = [[NSMutableArray alloc] initWithCapacity:[list count]];
            [self sortArr:specialSortArr OriginArr:list];
            
            if (!IsArrEmpty(specialSortArr))
            {
                SNSpecialSubjectDTO *dto = [specialSortArr objectAtIndex:0];
                self.specialSubjectDto = dto;
                DLog(@"areaDisPosition ======  %@",dto.areaDisPosition);
            }
        }
        else
        {
            NSString *error = errorMsg ? errorMsg :L(@"OSNoActivity");
            [self presentSheet:error];
        }
        
        
    }else{
//        NSString *error = errorMsg ? errorMsg :@"暂无相关活动，我们正在努力维护";
//        [self presentSheet:error];
        
        __weak SNSpecialListViewController *weakSelf = self;
        [self.view showNetworkErrorViewWithRefreshBlock:^{
            
            [weakSelf refreshData];
        }];
    }
    
    if (self.isFromHead) {
        [self refreshDataComplete];
    }
}


- (void)sortArr:(NSMutableArray *)specialSortArr OriginArr:(NSArray *)originArr{
    for (int i=0; i<[originArr count]; i++) {
        SNSpecialSubjectDTO *specialSubjectDTO = (SNSpecialSubjectDTO *)[originArr objectAtIndex:i];
        //按照屏幕的排布顺序排序
        if (!IsArrEmpty(specialSortArr)) {
            int index = 0;
            for (SNSpecialSubjectDTO *specialDto in specialSortArr) {
                index ++;
                if ([specialSubjectDTO.areaDisPosition intValue]<[specialDto.areaDisPosition intValue]) {
                    [specialSortArr insertObject:specialSubjectDTO atIndex:index-1] ;
                    break;
                }else if(index == [specialSortArr count]){
                    [specialSortArr addObject:specialSubjectDTO];
                    break;
                }else{
                    continue;
                }
            }
        }else{
            [specialSortArr addObject:specialSubjectDTO];
        }
    }
}

@end
