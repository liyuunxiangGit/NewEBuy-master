//
//  ProductParameterNewView.m
//  SuningEBuy
//
//  Created by xmy on 17/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ProductParameterNewView.h"

#define kDefualCellHight         10

#define kDefaulMarkWidth        60

#define kDefaulContendWidth     (320 - kDefaulMarkWidth-60)

#define kDefaulContendFont      12


@implementation ProductParameterNewView

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray*)parameterArr
{
    if(!_parameterArr)
    {
        _parameterArr = [[NSArray alloc] init];
    }
    
    return _parameterArr;
}

- (void)setLbl:(UILabel*)lbl
{
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
    lbl.textColor = [UIColor colorWithRed:112.0/255 green:112.0/255 blue:112.0/255 alpha:1];
    
    lbl.font = [UIFont systemFontOfSize:12];
    
    lbl.numberOfLines = 0;
    
    lbl.lineBreakMode = UILineBreakModeCharacterWrap;
}

- (void)setContendTDO:(ProductParaDTO *)aItem Withlbl:(UILabel*)lbl WithDetailLbl:(UILabel*)detailLbl{
   	
    
    NSString *nameTemp  = [[[NSString stringWithFormat:@"%@:",aItem.parameterName] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] replacedWhiteSpacsByString:@""];
    
    CGSize nameSize = [nameTemp sizeWithFont:lbl.font constrainedToSize:CGSizeMake(lbl.frame.size.width, 50) lineBreakMode:UILineBreakModeCharacterWrap];
    CGRect markFrame = lbl.frame;
    markFrame.size.height = nameSize.height;
    lbl.frame = markFrame;
    
    lbl.text = nameTemp;
    
    NSString *cotendTemp  = [[[NSString stringWithFormat:@"%@",aItem.parameterContents] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] replacedWhiteSpacsByString:@""];
    
    CGSize infoSize = [cotendTemp sizeWithFont:detailLbl.font constrainedToSize:CGSizeMake(detailLbl.frame.size.width, 1000) lineBreakMode:UILineBreakModeCharacterWrap];
    CGRect frame = detailLbl.frame;
    frame.size.height = infoSize.height;
    detailLbl.frame = frame;
    
    detailLbl.text = cotendTemp;
    
    
}

- (CGFloat)cellHeight:(ProductParaDTO *)dto
{
    CGFloat cellHight = kDefualCellHight;
    
    if (IsNilOrNull(dto)) {
        return 0;
    }
    
    return ([self getRowHeight:dto]+ cellHight);
}

- (CGFloat)getRowHeight:(ProductParaDTO *)tempDto{
    if (IsNilOrNull(tempDto)) {
        return 0;
    }
    
    UIFont *font = [UIFont systemFontOfSize:kDefaulContendFont];
    
    NSString *nameTemp  = [[[NSString stringWithFormat:@"%@:",tempDto.parameterName] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] replacedWhiteSpacsByString:@""];
    
    CGFloat nameHeight = [nameTemp heightWithFont:font width:kDefaulMarkWidth linebreak:UILineBreakModeCharacterWrap].height;
    
    NSString *contentString = [[tempDto.parameterContents stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] replacedWhiteSpacsByString:@""];
    
    CGFloat contentHeight  = [contentString heightWithFont:font width:kDefaulContendWidth linebreak:UILineBreakModeCharacterWrap].height;
    
    return nameHeight>contentHeight ? nameHeight : contentHeight;
    
}


- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.scrollEnabled = NO;
    
    self.tableView.frame = CGRectMake(10, 30, 300, self.view.frame.size.height);
    
    [self.tableView reloadData];
        
}

- (void)loadParameterView:(NSArray *)paramList
{
    self.tableView.frame = CGRectMake(10, 30, 300, [ProductParameterNewView height:paramList]);
    
    [self.tableView reloadData];

}


#pragma mark -
#pragma UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.parameterArr count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *parameterCell = @"parameterCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:parameterCell];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:parameterCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        [cell.contentView removeAllSubviews];
    }
    
    UILabel *parameterLbl = [[UILabel alloc] init];
    UILabel *parameterDetailLbl = [[UILabel alloc] init];
    
    [self setLbl:parameterLbl];
    [self setLbl:parameterDetailLbl];
    
    parameterLbl.frame = CGRectMake(10, 4, 60, 15);
    parameterDetailLbl.frame = CGRectMake(parameterLbl.right+32, 4, kDefaulContendWidth, 15);
    
    [cell.contentView addSubview:parameterLbl];
    [cell.contentView addSubview:parameterDetailLbl];
    
    if(indexPath.row%2 == 0)
    {
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    else if(indexPath.row%2 == 1)
    {
        cell.contentView.backgroundColor = [UIColor colorWithRGBHex:0xF8F4EB];

    }
    
    ProductParaDTO *dto = [self.parameterArr objectAtIndex:indexPath.row];
  
    [self setContendTDO:dto Withlbl:parameterLbl WithDetailLbl:parameterDetailLbl];
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IsNilOrNull(self.parameterArr)||[self.parameterArr count]==0) {
        
        return 0;
    }
    
    ProductParaDTO *tempDto = [self.parameterArr objectAtIndex:indexPath.row];
    
    if (tempDto != nil)
    {
        return [self cellHeight:tempDto];
    }

    return 0;
}

+ (CGFloat)height:(NSArray *)paramList
{
    float cellHeight = 0.0;
    
    for (ProductParaDTO *dto in paramList)
    {
        if (dto != nil)
        {
            cellHeight += [[[ProductParameterNewView alloc] init] cellHeight:dto];
        }
    
    }
    
    return cellHeight;
}

@end
