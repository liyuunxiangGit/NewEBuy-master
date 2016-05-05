//
//  ProductPackageView.m
//  SuningEBuy
//
//  Created by  liukun on 13-5-14.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ProductPackageView.h"
#import "ProductUtil.h"

@implementation PackageProductCell

- (void)dealloc
{
    TT_RELEASE_SAFELY(_checkButton);
    TT_RELEASE_SAFELY(_nameLabel);
    TT_RELEASE_SAFELY(_priceLabel);
    TT_RELEASE_SAFELY(_item);
    TT_RELEASE_SAFELY(_suppImageView);
}

- (void)setItem:(DataProductBasic *)item
{
    
    [self detailMark];
    if (_item != item) {
        _item = item;
    }
    
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.productView.imageURL = [ProductUtil getImageUrlWithProductCode:item.productCode size:ProductImageSize160x160];
    }
    else{
        
        self.productView.imageURL = [ProductUtil getImageUrlWithProductCode:item.productCode size:ProductImageSize100x100];
    }
    
    self.nameLabel.text = _item.productName;
    
    if (item.packageType == PackageTypeAccessory)
    {
        [self.contentView addSubview:self.checkButton];
        [self setCheckButtonIsChecked:item.isAccessorySelect];
        //self.nameLabel.left = 44;
        NSString *price = [NSString stringWithFormat:@"￥%.2f",
                           [item.accessoryPackagePrice doubleValue]];
        self.priceLabel.text = price;
        
        self.nameLabel.frame = CGRectMake(107, 12, 200, 40);
        self.suppImageView.frame = CGRectMake(45, 14, 55, 55);
    }
    else
    {
        [self.checkButton removeFromSuperview];
        //self.nameLabel.left = 10;
        NSString *price = [NSString stringWithFormat:@"￥%.2f",
                           [item.suningPrice doubleValue]];
        self.priceLabel.text = price;
        
        self.nameLabel.frame = CGRectMake(70, 12, 205, 40);
        self.suppImageView.frame = CGRectMake(10, 14, 55, 55);
    }
    self.separationLineImg.frame = CGRectMake(15, 76, 305, 0.5);
}

- (UIImageView *)separationLineImg
{
    if (!_separationLineImg) {
        _separationLineImg = [[UIImageView alloc] init];
        _separationLineImg.image = [UIImage imageNamed:@"line.png"];
        
        [self.contentView addSubview:_separationLineImg];
    }
    return _separationLineImg;
}

-(UIImageView *)detailMark{
    
    if (!_detailMark) {
        
        
        _detailMark = [[UIImageView alloc] initWithFrame:CGRectMake(280, 30, 7, 10)];
        
        _detailMark.image = [UIImage imageNamed:@"mobile_point.png"];
        
        // _backView.image = [UIImage imageNamed:@"list_bg1.png"];
        _detailMark.userInteractionEnabled = YES;
//        [self.contentView addSubview:_detailMark];
    }
    
    return _detailMark;
}

//-(UIImageView *)backView{
//    
//    if (!_backView) {
//        
//        _backView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 300, 80)];
//        
//        _backView.image = [[UIImage imageNamed:@"list_bg1.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
//        
//        // _backView.image = [UIImage imageNamed:@"list_bg1.png"];
//        _backView.userInteractionEnabled = YES;
//        [self.contentView addSubview:_backView];
//    }
//    
//    return _backView;
//}
- (EGOImageView *)productView
{
    if (!_productView) {
		
        CGRect productFrame =  CGRectMake(45, 10, 55, 55);
		_productView = [[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
        
		_productView.backgroundColor =[UIColor whiteColor];
        
//        [_productView.layer setBorderWidth:1];
//        [_productView.layer setCornerRadius:0.1];
//        [_productView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        
        _productView.contentMode = UIViewContentModeScaleAspectFill;
                
        _productView.layer.cornerRadius = 5;
        
        _productView.layer.masksToBounds = YES;
        
        _productView.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        
        _suppImageView = [[UIView alloc] initWithFrame:productFrame];
        _suppImageView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview: _suppImageView];
        
        [_suppImageView addSubview:_productView];
       // TT_RELEASE_SAFELY(_suppImageView);
	}
	
	return _productView;
}
- (UIButton *)checkButton
{
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkButton.frame = CGRectMake(10, 25, 30, 30);
        [_checkButton addTarget:self
                         action:@selector(modifyChecked)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _checkButton;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
		_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(107, 12, 200, 40)];
        
		_nameLabel.backgroundColor = [UIColor clearColor];
        
        _nameLabel.font = [UIFont boldSystemFontOfSize:12.0];
        
        _nameLabel.numberOfLines = 0;
        
        _nameLabel.textColor = RGBCOLOR(68, 68, 68);
        
		[self.contentView addSubview:_nameLabel];
    }
    
    return _nameLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel)
    {
		_priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(107, 55, 70, 20)];
        
		_priceLabel.backgroundColor = [UIColor clearColor];
        
        _priceLabel.font = [UIFont boldSystemFontOfSize:12.0];
        
        _priceLabel.textColor = RGBCOLOR(255,119, 0);
        
		[self.contentView addSubview:_priceLabel];
    }
    
    return _priceLabel;
}

#pragma mark -
#pragma mark action

- (void)modifyChecked
{
    self.item.isAccessorySelect = !self.item.isAccessorySelect;
    
    [self setCheckButtonIsChecked:self.item.isAccessorySelect];
    
    if (_myDelegate && [_myDelegate respondsToSelector:@selector(reloadSuperTableView)]) {
        [_myDelegate reloadSuperTableView];
    }
}

- (void)setCheckButtonIsChecked:(BOOL)checked
{
    if (checked)
    {
        [self.checkButton setImage:[UIImage imageNamed:@"checkbox_selected.png"]
                          forState:UIControlStateNormal];
    }
    else
    {
        [self.checkButton setImage:[UIImage imageNamed:@"checkbox_unselect.png"]
                          forState:UIControlStateNormal];
    }
    
}

@end

/*********************************************************************/

@implementation ProductPackageView

- (void)dealloc
{
    _subTableView.dataSource = nil;
    _subTableView.delegate = nil;
    TT_RELEASE_SAFELY(_subTableView);    
    TT_RELEASE_SAFELY(_tipLabel);
    TT_RELEASE_SAFELY(_discountLabel);
    
    for (DataProductBasic *innerDto in _item.allAccessoryProductList)
    {
        [innerDto removeObserver:self forKeyPath:@"isAccessorySelect"];
    }
    TT_RELEASE_SAFELY(_item);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(UILabel *)titleLab{
    
    
    if (!_titleLab) {
        
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
        _titleLab.backgroundColor = [UIColor clearColor];
        
        _titleLab.font = [UIFont systemFontOfSize:13];
        
        _titleLab.textColor = [UIColor colorWithRed:102.0/255 green:102.0/255 blue:102.0/255 alpha:1];
        
        [self.contentView addSubview:_titleLab];
    }
    
    
    return _titleLab;
    
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"isAccessorySelect"])
    {
        [self setTitleLabelText];
        
//        if ([_delegate respondsToSelector:@selector(selectPocket)]) {
//            
//            [_delegate selectPocket];
//        }
    }
}

- (NSMutableAttributedString *)attributedStringWithString:(NSString *)string
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:string];
    return title;
}
-(UIImageView *)separatorLine{
    
    if (!_separatorLine) {
        
        _separatorLine = [[UIImageView alloc] init];
        
        _separatorLine.image = [UIImage imageNamed:@"fengexian.png"];
        
        [self.contentView addSubview:_separatorLine];
    }
    
    return _separatorLine;
}
- (void)setItem:(DataProductBasic *)item
{
    
    
    if (item.packageType == PackageTypeAccessory)
    {
        self.titleLab.text = L(@"Product_Fitting");
        
    }
    else if (item.packageType == PackageTypeSmall)
    {

        self.titleLab.text = L(@"Product_TC");
    }
    
    if (_item != item) {
        
        for (DataProductBasic *innerDto in _item.allAccessoryProductList)
        {
            [innerDto removeObserver:self forKeyPath:@"isAccessorySelect"];
        }
        
        _item = item;
        
        for (DataProductBasic *innerDto in _item.allAccessoryProductList) {
            [innerDto addObserver:self
                       forKeyPath:@"isAccessorySelect"
                          options:NSKeyValueObservingOptionNew
                          context:NULL];
        }
    }
    
    [self setTitleLabelText];
    
    self.separatorLine.frame = CGRectMake(10, 0, 300, 2);
    self.subTableView.frame = CGRectMake(0, 25, 320, [ProductPackageView cellCount:self.item]*100+10);
    self.subTableView.layer.cornerRadius = 20.0;
    [self.subTableView reloadData];
}

- (void)setTitleLabelText
{
    UIFont *font = [UIFont boldSystemFontOfSize:14];
    DataProductBasic *item = self.item;
    NSMutableAttributedString *tip = [[NSMutableAttributedString alloc] init];
    if (item.packageType == PackageTypeAccessory)
    {
        NSMutableAttributedString *temp = [self attributedStringWithString:[NSString stringWithFormat:@"%@:\n",L(@"Product_RecommendSuit")]];
        [temp setFont:font];
        [temp setTextColor:[UIColor darkGrayColor]];
        [tip appendAttributedString:temp];
        
        NSString *yixuan = [NSString stringWithFormat:@"%@(%d)",L(@"Product_SelectedFits"), [item selectAccessoryProductCount]];
        temp = [self attributedStringWithString:yixuan];
        [temp setFont:font];
        [temp setTextColor:[UIColor darkRedColor]];
        [tip appendAttributedString:temp];
        
    }
    else if (item.packageType == PackageTypeSmall)
    {
        NSMutableAttributedString *temp = [self attributedStringWithString:[NSString stringWithFormat:@"%@:\n",L(@"Product_Taocan")]];
        [temp setFont:font];
        [temp setTextColor:[UIColor darkGrayColor]];
        [tip appendAttributedString:temp];
        
        NSString *oldPrice = [NSString stringWithFormat:@"%@￥%.2f",L(@"DJGroup_SaveMoney"),
                              [item.savePrice doubleValue]];
        temp = [self attributedStringWithString:oldPrice];
        [temp setFont:font];
        [temp setTextColor:[UIColor darkRedColor]];
        [tip appendAttributedString:temp];
    }
    
    self.tipLabel.attributedText = tip;
    
    NSMutableAttributedString *discount = [[NSMutableAttributedString alloc] init];
    if (item.packageType == PackageTypeAccessory)
    {
        NSMutableAttributedString *temp = [self attributedStringWithString:L(@"Product_TaocanDiscount")];
        [temp setFont:font];
        [temp setTextColor:[UIColor lightGrayColor]];
        [discount appendAttributedString:temp];
        
        NSString *yixuan = [NSString stringWithFormat:@"￥%.2f", [item totalPrice]];
        temp = [self attributedStringWithString:yixuan];
        [temp setFont:font];
        [temp setTextColor:[UIColor darkRedColor]];
        [discount appendAttributedString:temp];
        
    }
    else if (item.packageType == PackageTypeSmall)
    {
        NSMutableAttributedString *temp = [self attributedStringWithString:L(@"Product_TaocanPrice")];
        [temp setFont:font];
        [temp setTextColor:[UIColor lightGrayColor]];
        [discount appendAttributedString:temp];
        
        NSString *oldPrice = [NSString stringWithFormat:@"￥%.2f",
                              [item.smallPackagePrice doubleValue]];
        temp = [self attributedStringWithString:oldPrice];
        [temp setFont:font];
        [temp setTextColor:[UIColor darkRedColor]];
        [discount appendAttributedString:temp];
    }
    [discount setTextAlignment:kCTTextAlignmentRight lineBreakMode:kCTLineBreakByTruncatingHead];
    
    self.discountLabel.attributedText = discount;
}

- (int)cellCount
{
   // return [ProductPackageView cellCount:self.item];
    
    NSInteger count = 0;
    
    if (self.item.packageType == PackageTypeAccessory)
    {
        count = [self.item.allAccessoryProductList count];
        //count = count > 2 ? 3 : count;
    }
    else if (self.item.packageType == PackageTypeSmall)
    {
        count = [self.item.smallPackageList count];
    }
    
 //   count = count > 2 ? 3 : count;
    
    return count;
}

+ (int)cellCount:(DataProductBasic *)item
{
    NSInteger count = 0;
    
    if (item.packageType == PackageTypeAccessory)
    {
        count = [item.allAccessoryProductList count];
        //count = count > 2 ? 3 : count;
    }
    else if (item.packageType == PackageTypeSmall)
    {
        count = [item.smallPackageList count];
    }
    
    count = count > 2 ? 3 : count;
    
    return count;
}

- (UITableView *)subTableView
{	
	if(!_subTableView){
		
		_subTableView = [[UITableView alloc] initWithFrame:CGRectZero
												  style:UITableViewStyleGrouped];
		
		[_subTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_subTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		//_subTableView.scrollEnabled = NO;
		
		_subTableView.userInteractionEnabled = YES;
		
		_subTableView.delegate =self;
		
		_subTableView.dataSource =self;
		
		_subTableView.backgroundColor =[UIColor clearColor];
        
        _subTableView.backgroundView = nil;
		
        _subTableView.frame = CGRectMake(0, 40, 320, 90);
        [self.contentView addSubview:_subTableView];
	}
	return _subTableView;
}

- (OHAttributedLabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[OHAttributedLabel alloc] init];
        _tipLabel.frame = CGRectMake(10, 5, 170, 40);
        _tipLabel.font = [UIFont systemFontOfSize:14.0f];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.textAlignment = NSTextAlignmentLeft;
        _tipLabel.hidden = YES;
        [self.contentView addSubview:_tipLabel];
    }
    return _tipLabel;
}

- (OHAttributedLabel *)discountLabel
{
    if (!_discountLabel) {
        _discountLabel = [[OHAttributedLabel alloc] init];
        _discountLabel.frame = CGRectMake(120, 20, 160, 20);
        _discountLabel.font = [UIFont systemFontOfSize:14.0f];
        _discountLabel.backgroundColor = [UIColor clearColor];
        _discountLabel.textAlignment = NSTextAlignmentRight;
        _discountLabel.hidden = YES;
        [self.contentView addSubview:_discountLabel];
    }
    return _discountLabel;
}

- (void)seeMore:(id)sender
{
//    if ([_delegate respondsToSelector:@selector(seeMoreAccessoryPackageProduct)]) {
//        [_delegate seeMoreAccessoryPackageProduct];
//    }
}

#pragma mark -
#pragma mark table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self cellCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    PackageProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[PackageProductCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    }
    
    if (self.item.packageType == PackageTypeAccessory)
    {
//        if (indexPath.row < 2)
//        {
            DataProductBasic *dto = [self.item.allAccessoryProductList objectAtIndex:indexPath.row];
            [cell setItem:dto];
//        }
//        else
//        {
//            cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0f];
//            cell.textLabel.text = @"查看更多";
//        }
    }
    else if (self.item.packageType == PackageTypeSmall)
    {
        DataProductBasic *dto = [self.item.smallPackageList objectAtIndex:indexPath.row];
        [cell setItem:dto];
    }
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DataProductBasic *dto = nil;
    if (self.item.packageType == PackageTypeAccessory)
    {
        dto = [self.item.allAccessoryProductList objectAtIndex:indexPath.row];

    }
    else if (self.item.packageType == PackageTypeSmall)
    {
        dto = [self.item.smallPackageList objectAtIndex:indexPath.row];
    }
    
//    if ([_delegate respondsToSelector:@selector(packageView:didSelectProduct:)]) {
//        [_delegate packageView:self didSelectProduct:dto];
//    }
}

+ (CGFloat)height:(DataProductBasic *)item
{
    if (item)
    {
        return 100*[self cellCount:item] + 25;
    }
    return 0;
}
@end
