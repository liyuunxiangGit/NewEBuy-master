//
//  ChooseShareWayViewController.m
//  SuningEBuy
//
//  Created by  on 12-9-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ChooseShareWayViewController.h"

@interface ChooseShareWayViewController()

@property (nonatomic, strong) NSArray *itemList;

@end

/*********************************************************************/

@implementation ChooseShareWayViewController

@synthesize delegate = _delegate;
@synthesize allType = _allType;

@synthesize itemList = _itemList;


- (id)init {
    self = [super init];
    if (self) {
        self.title = L(@"Please_Choose_Share_Way");
        _allType = SNShareAll;
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUpDatasource];
    
    self.tableView.frame = self.view.frame;
    
    self.tableView.backgroundColor = [UIColor navTintColor];
    
    [self.view addSubview:self.tableView];
}

- (void)setUpDatasource
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    //微博
    if (_allType & SNShareSinaWeibo)
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             L(@"Share_To_Sina_WeiBo"), @"title",
                             @"xinlang.png", @"image",
                             __INT(SNShareSinaWeibo), @"type",
                             nil];
        [array addObject:dic];
    }
    
    //腾讯微博
    if (_allType & SNShareTCWeiBo)
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             L(@"Share_To_TC_WeiBo"), @"title",
                             @"tengxun.png", @"image",
                             __INT(SNShareTCWeiBo), @"type",
                             nil];
        [array addObject:dic];
    }
    
    if (_allType & SNShareWeiXin) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             L(@"Share_To_WeiXin"), @"title",
                             @"weixin.png", @"image",
                             __INT(SNShareWeiXin), @"type",
                             nil];
        [array addObject:dic];

    }
    //短信
    if (_allType & SNShareSMS)
    {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             L(@"Share_With_SMS"), @"title",
                             @"message.png", @"image",
                             __INT(SNShareSMS), @"type",
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
    }
    
    NSDictionary *dic = [self.itemList objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dic objectForKey:@"title"];
    UIImage *image = [UIImage imageNamed:[dic objectForKey:@"image"]];
    cell.imageView.image = image;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    return 40;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
        
    NSDictionary *dic = [self.itemList objectAtIndex:indexPath.row];
    
    SNShareType selectType = [[dic objectForKey:@"type"] intValue];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didChooseShareWay:)])
    {
        [_delegate didChooseShareWay:selectType];
    }
    
    [self dismissPopover:YES];
}



@end
