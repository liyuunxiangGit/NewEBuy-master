//
//  AccessoryPackageListViewController.m
//  SuningEBuy
//
//  Created by  liukun on 13-5-14.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "AccessoryPackageListViewController.h"
#import "AccessoryProductListCell.h"
#import "ProductDetailViewController.h"

@interface AccessoryPackageListViewController ()
{
    int *checkedState;
}

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation AccessoryPackageListViewController

- (void)dealloc
{
    TT_RELEASE_SAFELY(_baseProductDTO);
    TT_RELEASE_SAFELY(_accessoryList);
    TT_RELEASE_SAFELY(_titleLabel);
    
    free(checkedState);
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"Product_RecommendSuit");
        self.pageTitle = L(@"show_productDetail_recommend");
    }
    return self;
}

- (void)setBaseProductDTO:(DataProductBasic *)baseProductDTO
{
    if (_baseProductDTO != baseProductDTO) {
        _baseProductDTO = baseProductDTO;
        
        self.accessoryList = _baseProductDTO.allAccessoryProductList;
        
    }
}

- (void)setAccessoryList:(NSArray *)accessoryList
{
    if (_accessoryList != accessoryList) {
        
        if (checkedState)   free(checkedState);
        
        _accessoryList = accessoryList;
        
        unsigned int count = [_accessoryList count];
        checkedState = (int *)malloc(count*sizeof(int));
        
        for (int i = 0; i < count; i++)
        {
            DataProductBasic *pro = [_accessoryList objectAtIndex:i];
            checkedState[i] = pro.isAccessorySelect;
        }
    }
}

- (void)setLabelText
{
    int selectedCount = 0;
    double price = 0.0;
    unsigned int count = [_accessoryList count];
    
    price += [self.baseProductDTO.suningPrice doubleValue];
    
    for (int i = 0; i < count; i++)
    {
        DataProductBasic *pro = [_accessoryList objectAtIndex:i];
        
        if (checkedState[i]) {
            selectedCount ++;
            price += [pro.accessoryPackagePrice doubleValue];
        }
    }
    
    NSString *formatStr = [NSString stringWithFormat:@"%@(%d)%@￥%.2f",L(@"Product_SelectedFits"),
                           selectedCount,L(@"Product_TaocanYouhui"), price];
    
    CGFloat width = [formatStr sizeWithFont:self.titleLabel.font].width;
    
    NSMutableString *start = [NSMutableString stringWithString:formatStr];
    NSString *space = @" ";
    NSMutableString *spaceRow = [NSMutableString string];
    while (width < 300) {
        [start appendString:space];
        width = [start sizeWithFont:self.titleLabel.font].width;
        [spaceRow appendString:space];
    }
    
    NSString *resultStr = [NSString stringWithFormat:@"%@(%d)%@%@￥%.2f",L(@"Product_SelectedFits"),
                           selectedCount, spaceRow,L(@"Product_TaocanYouhui"), price];
    
    self.titleLabel.text = resultStr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.view addSubview:self.titleLabel];
    [self setLabelText];
    
    CGRect frame = self.view.bounds;
    frame.origin.y = 30;
    frame.size.height -= 122;
    self.groupTableView.frame = frame;
    [self.view addSubview:self.groupTableView];
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:L(@"Done")
//                                                             style:UIBarButtonItemStylePlain
//                                                            target:self
//                                                            action:@selector(done:)];
//    self.navigationItem.rightBarButtonItem = item;
//    [item release];
    self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"Done")];

}

- (void)righBarClick
{
    [self done:nil];
}

- (void)done:(id)sender
{
    unsigned int count = [_accessoryList count];
    
    for (int i = 0; i < count; i++)
    {
        DataProductBasic *pro = [_accessoryList objectAtIndex:i];
        pro.isAccessorySelect = checkedState[i];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)titleLabel
{
    if (!_titleLabel)
    {
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
		_titleLabel.backgroundColor = [UIColor grayColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = UITextAlignmentCenter;
    }
    return _titleLabel;
}

#pragma mark -
#pragma mark table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_accessoryList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [AccessoryProductListCell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    AccessoryProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[AccessoryProductListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.delegate = self;
    }
    
    cell.item = [_accessoryList objectAtIndex:indexPath.row];
    cell.tag = indexPath.row;
    [cell setCheckButtonIsChecked:checkedState[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DataProductBasic *dto = [_accessoryList objectAtIndex:indexPath.row];
    
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] initWithDataBasicDTO:dto];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark check delegate

- (BOOL)accessoryProductCheckStateShouldChange:(int)index
{
    if (index >= [_accessoryList count])
    {
        return NO;
    }
    
    checkedState[index] = !checkedState[index];
    [self setLabelText];
    return YES;
}

@end
