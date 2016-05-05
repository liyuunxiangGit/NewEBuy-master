//
//  FeedBackTypeChooseViewController.m
//  SuningEBuy
//
//  Created by xie wei on 13-5-29.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "FeedBackTypeChooseViewController.h"

#define kCheckImgTag      100

@interface FeedBackTypeChooseViewController()
{
    NSInteger lastShow;
}

@property (nonatomic, strong) NSArray *itemList;
@property (nonatomic, strong) NSIndexPath *lastSelected;

@end

@implementation FeedBackTypeChooseViewController

@synthesize delegate = _delegate;
@synthesize allType = _allType;

@synthesize itemList = _itemList;
@synthesize lastSelected = _lastSelected;


- (id)init:(NSInteger)selected {
    self = [super init];
    if (self) {
        self.title = L(@"UserFeedBack_FeedBackType");
        _allType = SNFeedBackAll;
        
        lastShow = selected;
        self.lastSelected = [NSIndexPath indexPathForRow:selected inSection:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpDatasource];
    
    self.tableView.frame = self.view.frame;
    
    self.tableView.backgroundColor = [UIColor navTintColor];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.view addSubview:self.tableView];
}

- (void)setUpDatasource
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    //功能
    if (_allType & SNFeedBackFunction)
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             L(@"UserFeedBack_FuncOperationSug"), @"title",
                             @"feedBack_check.png", @"image",
                             __INT(SNFeedBackFunction), @"type",
                             nil];
        [array addObject:dic];
    }
    
    //页面
    if (_allType & SNFeedBackPage)
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             L(@"UserFeedBack_GUISug"), @"title",
                             @"feedBack_check.png", @"image",
                             __INT(SNFeedBackPage), @"type",
                             nil];
        [array addObject:dic];
    }
    
    //新需求
    if (_allType & SNFeedBackNewFunction) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             L(@"UserFeedBack_YourNewNeeds"), @"title",
                             @"feedBack_check.png", @"image",
                             __INT(SNFeedBackNewFunction), @"type",
                             nil];
        [array addObject:dic];
        
    }
    
    //订单咨询
    if (_allType & SNFeedBackConsult)
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             L(@"UserFeedBack_OrderConsult"), @"title",
                             @"feedBack_check.png", @"image",
                             __INT(SNFeedBackConsult), @"type",
                             nil];
        [array addObject:dic];
    }
    
    //送安维咨询
    if (_allType & SNFeedBackLogisticsConsult)
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             L(@"UserFeedBack_RepairConsult"), @"title",
                             @"feedBack_check.png", @"image",
                             __INT(SNFeedBackLogisticsConsult), @"type",
                             nil];
        [array addObject:dic];
    }
    
    //退换货咨询
    if (_allType & SNFeedBackChangeGoodConsult)
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             L(@"UserFeedBack_ReturnAndChangeGoodsConsult"), @"title",
                             @"feedBack_check.png", @"image",
                             __INT(SNFeedBackChangeGoodConsult), @"type",
                             nil];
        [array addObject:dic];
    }
    
    //其他
    if (_allType & SNFeedBackOther)
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             L(@"Others"), @"title",
                             @"feedBack_check.png", @"image",
                             __INT(SNFeedBackOther), @"type",
                             nil];
        [array addObject:dic];
    }
    
    self.itemList = array;
}

#pragma mark -
#pragma mark Table view Datasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_itemList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableViewCellIdentifier = @"tableViewCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier];
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *cellSep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new_home_sep.png"]];
        cellSep.frame = CGRectMake(0, 39, 230,1);
        [cell.contentView addSubview:cellSep];
        

    }
    
    NSDictionary *dic = [self.itemList objectAtIndex:indexPath.row];
    
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 30)];
    titleLbl.backgroundColor = [UIColor clearColor];
    titleLbl.font = [UIFont boldSystemFontOfSize:14.0];
    titleLbl.text = [dic objectForKey:@"title"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[dic objectForKey:@"image"]]];
    imageView.frame = CGRectMake(200, 13, 14, 14);
    imageView.backgroundColor = [UIColor clearColor];
    NSInteger rowNum = indexPath.row;
    imageView.tag = kCheckImgTag + rowNum;
    if (rowNum == lastShow) {
        imageView.hidden = NO;
    }
    else
    {
        imageView.hidden = YES;
    }
    
    [cell.contentView addSubview:titleLbl];
    [cell.contentView addSubview:imageView];
    
    TT_RELEASE_SAFELY(titleLbl);
    TT_RELEASE_SAFELY(imageView);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSInteger lastRowNum = self.lastSelected.row;
    NSArray *lastViewsArray = [tableView cellForRowAtIndexPath:self.lastSelected].contentView.subviews;
    for (UIView *view in lastViewsArray)
    {
        DLog(@"xiejwei %d",kCheckImgTag+lastRowNum);
        
        if (view.tag == (kCheckImgTag+lastRowNum)) {
            view.hidden = YES;
        }
    }
    
    self.lastSelected = indexPath;
    
    NSInteger rowNum = indexPath.row;
    NSArray *viewsArray = [tableView cellForRowAtIndexPath:indexPath].contentView.subviews;
    for (UIView *view in viewsArray)
    {
        DLog(@"xiejwei %d",kCheckImgTag+rowNum);
        
        if (view.tag == (kCheckImgTag+rowNum)) {
            view.hidden = NO;
        }
    }
    
    NSDictionary *dic = [self.itemList objectAtIndex:indexPath.row];
    
    SNFeedBackType selectType = [[dic objectForKey:@"type"] intValue];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didChooseFeedBackType:)])
    {
        [_delegate didChooseFeedBackType:selectType];
    }
    
    [self dismissPopover:YES];
}


@end
