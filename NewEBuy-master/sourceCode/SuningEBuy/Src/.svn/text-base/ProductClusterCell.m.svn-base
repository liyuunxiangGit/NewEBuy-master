//
//  ProductClusterCell.m
//  SuningEBuy
//
//  Created by shasha on 12-4-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ProductClusterCell.h"
#define kClusterColorId   @"colorId"
#define kClusterColorName @"colorNm"

#define kClusterVersionId @"versionId"
#define kClusterVersionName @"versionNm"

@interface ProductClusterCell (){
    BOOL     isColorButtonTaped;
    int      colorRowCur_;
    int      versionRowCur_;
    
    int     clusterCount_;
}


- (NSString *)getColorName:(NSString *)curColorId  inColorArray:(NSArray *)colorsArr;
- (NSString *)getVersionName:(NSString *)curVersionId  inVersionsArray:(NSArray *)versionsArr;

- (DataProductBasic *)getProductMap:(NSString *)colorId versionId:(NSString *)versionId;
- (void)refreshTableView:(DataProductBasic *)selectDTO;

@end


@implementation ProductClusterCell
@synthesize colorButton = colorButton_;
@synthesize versionButton = versionButton_;
@synthesize items = items_;
@synthesize picker = picker_;
@synthesize clusterDelegate = clusterDelegate_;

@synthesize colorNameLabel = colorNameLabel_;
@synthesize versionNameLabel = versionNameLabel_;
-(void)dealloc{
    
    TT_RELEASE_SAFELY(items_);
    TT_RELEASE_SAFELY(colorButton_);
    TT_RELEASE_SAFELY(versionButton_);
    TT_RELEASE_SAFELY(picker_);
    TT_RELEASE_SAFELY(colorNameLabel_);
    TT_RELEASE_SAFELY(versionNameLabel_);
}

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
	
	if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
    
        
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;
        
		        
	}
	
	return self;
}


#pragma mark -
#pragma mark private Methods

- (NSString *)getColorName:(NSString *)curColorId  inColorArray:(NSArray *)colorsArr{

    if (curColorId != nil && colorsArr!= nil && [colorsArr count] >0) {
        
        for (int i = 0; i < [colorsArr count]; i++) {
            
            NSDictionary *colorNowDic = [colorsArr objectAtIndex:i];
            NSString *colorId = [colorNowDic objectForKey:kClusterColorId];
            
            if ([colorId isEqualToString: curColorId]) {
                NSString *colorDesc = [colorNowDic objectForKey:kClusterColorName];
                
                if (!IsNilOrNull(colorDesc)) {
                    colorRowCur_ = i;
                    return colorDesc;
                }
                
            }else{
                
                continue;
            }
            
        }
        
        return nil;
        
          
    }else{
        
        return nil;
    }
    


}

- (NSString *)getVersionName:(NSString *)curVersionId  inVersionsArray:(NSArray *)versionsArr{

    if (curVersionId != nil && versionsArr!= nil && [versionsArr count] >0) {
        
        for (int i = 0; i < [versionsArr count]; i++) {
            
            NSDictionary *versionNowDic = [versionsArr objectAtIndex:i];
            NSString *versionId = [versionNowDic objectForKey:kClusterVersionId];
            
            if ([versionId isEqualToString: curVersionId]) {
                NSString *versionName = [versionNowDic objectForKey:kClusterVersionName];
                
                if (!IsNilOrNull(versionName)) {
                    versionRowCur_ = i;
                    return versionName;
                }
                
            }else{
                
                continue;
            }
            
        }
        
        return nil;
        
        
    }else{
        
        return nil;
    }

}


- (DataProductBasic *)getProductMap:(NSString *)colorId versionId:(NSString *)versionId{


    if (colorId == nil&&versionId == nil)
    {
        return nil;
    }
    for (int i = 0; i<[self.items.colorVersionMap count]; i++)
    {
        
        DataProductBasic *mapDTO = [self.items.colorVersionMap objectAtIndex:i];
        if ([colorId isEqualToString: mapDTO.colorCurr]  &&[versionId isEqualToString: mapDTO.versionCurr])
        {
            return mapDTO;
        }
        
        //add by cuizl 由于主站商品数据维护有问题，部分商品商品簇中versionid为空
        if([versionId isEqualToString:@""]||[mapDTO.versionCurr isEqualToString:@""])
        {
            if(self.items.versionItemList.count == 1&&[colorId isEqualToString:mapDTO.colorCurr])
            {
                return mapDTO;
                
            }
        }
        if([colorId isEqualToString:@""]||[mapDTO.colorCurr isEqualToString:@""])
        {
            
            if(self.items.colorItemList.count == 1 && [versionId isEqualToString:mapDTO.versionCurr])
            {
                return mapDTO;
            }
            
        }
        
    }


    return nil;
}



-(void) setItems:(DataProductBasic *)aItem{
	
	if (aItem != items_) {
		
		
		items_ = aItem;
        
        DLog(@"%@", [self.items description]);
        
        isColorButtonTaped = YES;
                
        colorRowCur_ = 0;
        
        versionRowCur_ = 0;
        
        clusterCount_ = 0;
        
        NSString *curColorDesc = [self getColorName:self.items.colorCurr inColorArray:self.items.colorItemList];
        /*
         设置颜色。
         */
        if (!IsNilOrNull(curColorDesc)) {
            clusterCount_ += 1;
            [self.colorButton setTitle:[curColorDesc trim]
                              forState:UIControlStateNormal];
            
        }else{
            
            if ([self.colorButton superview] == self.contentView ) {
                [self.colorButton removeFromSuperview];
                
            }
            if ([self.colorNameLabel superview] == self.contentView) {
                [self.colorNameLabel removeFromSuperview];
            }
            
        }

         /*
         设置商品当前的版本：大小容量等。
         */
        
        NSString *curVersionName = [self getVersionName:self.items.versionCurr
                                        inVersionsArray:self.items.versionItemList];
        if (!IsNilOrNull(curVersionName)&&![curVersionName isEqualToString:@""]) {
            
            clusterCount_ += 1;
            
            [self.versionButton setTitle:[curVersionName trim]
                                forState:UIControlStateNormal];
            
            self.versionNameLabel.text = self.items.versionDesc;
            
        }else{
        
            if (self.versionButton.superview != nil) {
                
                [self.versionButton removeFromSuperview];
                
            }
        
        }
        		
        
		[self setNeedsLayout];
				
	}
}


-(void) layoutSubviews{
    [super layoutSubviews];
    
    self.backgroundColor  = [UIColor clearColor];
    
    CGFloat baseX = 0;
    CGFloat baseY = 15;
    CGFloat buttonWidth = 100;
    CGFloat buttonHeight = 30;
    CGFloat labelWidth  = 45;
    CGFloat labelHeight = 30;
    CGFloat disdance = 10;

    if (clusterCount_ == 1) {
        
        CGRect LabelFrame = CGRectMake(baseX, baseY, labelWidth, labelHeight);

        CGRect buttonFrame = CGRectMake(baseX + labelWidth + 5, baseY, buttonWidth, buttonHeight);
        
        if (self.colorNameLabel.superview == nil) {
            
            self.versionNameLabel.frame = LabelFrame;
            self.versionButton.frame = buttonFrame;
            
        }else{
        
            self.colorNameLabel.frame = LabelFrame;
            self.colorButton.frame = buttonFrame;
        }
        
        
    }else{
    
        
        self.colorNameLabel.frame = CGRectMake(baseX, baseY, labelWidth, labelHeight);
        self.colorButton.frame = CGRectMake(self.colorNameLabel.right+5, baseY, buttonWidth, buttonHeight);
        self.versionNameLabel.frame = CGRectMake(self.colorButton.right + disdance, baseY, labelWidth, labelHeight);
        self.versionButton.frame = CGRectMake(self.versionNameLabel.right+5, baseY, buttonWidth,buttonHeight);
    
    }
    
}


#pragma mark - 
#pragma mark Buttons init and  Actions  Methods

- (void)cancelButtonClicked:(id)sender{
    
    if (isColorButtonTaped == YES) {
        
        [self.colorButton resignFirstResponder];
        
    }else{
    
        [self.versionButton resignFirstResponder];
    }

}

- (void)doneButtonClicked:(id)sender{
        
    int row = [self.picker selectedRowInComponent:0];
    
    DataProductBasic *selectDTO = nil;
    
    if (isColorButtonTaped == YES) {
        
        [self.colorButton resignFirstResponder];
        
    }else{
        
        [self.versionButton resignFirstResponder];
    }
    if (isColorButtonTaped == YES) {
        
        if (row > [self.items.colorItemList count]-1) {
            return;
        }
        
        
        NSDictionary *colorTemp = [self.items.colorItemList objectAtIndex:row];
        NSString *title = [colorTemp objectForKey:kClusterColorName];
        NSString *selectedColorId = [colorTemp objectForKey:kClusterColorId];
        
        if (!IsNilOrNull(selectedColorId)) {
            NSString *version = self.items.versionCurr;
            if (IsNilOrNull(version)) {
                version = @"";
            }
            selectDTO =  [self getProductMap:selectedColorId versionId:version];
        }
        
        
        if (!IsNilOrNull(title)&&!IsNilOrNull(selectDTO)) {
            
            [self.colorButton setTitle:[title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forState:UIControlStateNormal];
            
        }else{
            
            BBAlertView *alert = [[BBAlertView alloc ]
                                  initWithTitle:nil
                                  message:L(@"Cluster_Not_Product_Found ")
                                  delegate:nil
                                  cancelButtonTitle:L(@"Ok")
                                  otherButtonTitles:nil];
            [alert show];
            TT_RELEASE_SAFELY(alert);
            return ;
            
        }
        
        
        
    }else{
        
        if (row > [self.items.versionItemList count]-1) {
            return;
        }
        
        NSDictionary *versionTemp = [self.items.versionItemList objectAtIndex:row];
        
        NSString *selectedVersionId = [versionTemp objectForKey:kClusterVersionId];
        if (!IsNilOrNull(selectedVersionId)) {
            
            NSString *color = self.items.colorCurr;
            if (IsNilOrNull(color)) {
                color = @"";
            }
            selectDTO =  [self getProductMap:color versionId:selectedVersionId];
            
        }

        NSString *title = [versionTemp objectForKey:kClusterVersionName];

        if (!IsNilOrNull(title)&&!IsNilOrNull(selectDTO)) {
            
            [self.versionButton setTitle:[title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]forState:UIControlStateNormal];
            
        }else{
            
            BBAlertView *alert = [[BBAlertView alloc]
                                  initWithTitle:nil
                                  message:L(@"Cluster_Not_Product_Found ")
                                  delegate:nil
                                  cancelButtonTitle:L(@"ok")
                                  otherButtonTitles:nil];
            [alert show];
            TT_RELEASE_SAFELY(alert);
            return ;
        }
                
    }
    
    [self refreshTableView:selectDTO];
}




/*!
 刷新四级页面的TableView
 */
- (void)refreshTableView:(DataProductBasic *)selectDTO{
   //如果只有一条商品簇信息的话就不刷新页面。或者选择的簇信息与当前的商品是一样的时候，不刷新页面。
    if (isColorButtonTaped == YES) {
        if (self.items.colorItemList == nil || [self.items.colorItemList count] < 2) {
            return;
        }
        if (selectDTO.colorCurr == nil || self.items.colorCurr == nil||[selectDTO.colorCurr isEqualToString:self.items.colorCurr] ) {
            return;
        }
    }else{
        
        if (self.items.versionItemList == nil || [self.items.versionItemList count] < 2) {
            return;
        }
        if (selectDTO.versionCurr == nil || self.items.versionCurr == nil || [selectDTO.versionCurr isEqualToString:self.items.versionCurr]) {
            return;
        }
        
    }
    
    if (clusterDelegate_ && [clusterDelegate_ respondsToSelector:@selector(productClusterDidChange:)]) {
        [clusterDelegate_ productClusterDidChange:selectDTO];
    }    
}

-(void)singleClickButton:(id)sender{
    
    if (sender == self.colorButton) {
        
        isColorButtonTaped = YES;
        
            
            [self.picker reloadAllComponents];
        
        [self.picker selectRow:colorRowCur_ inComponent:0 animated:YES];
  
        [self.colorButton becomeFirstResponder];
        

    }else{
    
        
        isColorButtonTaped = NO;
                 
        [self.picker reloadAllComponents];
            
        [self.picker selectRow:versionRowCur_ inComponent:0 animated:YES];

        [self.versionButton becomeFirstResponder];


    }
    
}


#pragma mark - 
#pragma mark PickerView Datasource Delegate Methods 
- (UIPickerView *)picker{

    if (!picker_) {
        
        picker_ = [[UIPickerView alloc] initWithFrame:CGRectZero];
        picker_.delegate = self;
        picker_.dataSource = self;
        picker_.showsSelectionIndicator = YES;
        
    }
    return picker_;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;

}
-  (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{    
    if (isColorButtonTaped == YES) {
        
        NSArray *colorsMapArr = self.items.colorItemList;
        if (! IsNilOrNull(colorsMapArr) ) {
            return [colorsMapArr count];
        }else{
            return 0;
        }
    }else{
        NSArray *versionsMapArr = self.items.versionItemList;
        if (! IsNilOrNull(versionsMapArr) ) {
            return [versionsMapArr count];
        }else{
            return 0;
        }
    }

}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    if (isColorButtonTaped == YES) {
        /*
         显示颜色列表
         */
        if (row > [self.items.colorItemList count]-1) {
            return nil;
        }
        NSDictionary *colorTemp = [self.items.colorItemList objectAtIndex:row];
        NSString *title = [colorTemp objectForKey:kClusterColorName];
        
        if (!IsNilOrNull(title)) {
            return title;
        }else{
        
            return nil;
        }
    }else{
        /*
         显示version列表
         */
        if (row > [self.items.versionItemList count]-1) {
            return nil;
        }
        NSDictionary *versionTemp = [self.items.versionItemList objectAtIndex:row];
        NSString *title = [[versionTemp objectForKey:kClusterVersionName]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if (!IsNilOrNull(title)) {
            return title;
        }else{
            return nil;
        }

    
    }

}


#pragma mark - 
#pragma mark Customize UI Mehtods

- (ToolBarButton *)colorButton
{
    if (!colorButton_)
    {
        colorButton_ = [[ToolBarButton alloc] initWithFrame:CGRectZero];
        
        colorButton_.delegate = self;
        
        //      [versionButton_ addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
        
        colorButton_.backgroundColor = [UIColor clearColor];
        
        
        [colorButton_ setBackgroundImage:[UIImage imageNamed:@"cluster.png"] forState:UIControlStateNormal];
        
        [colorButton_ setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
        
        colorButton_.titleLabel.textAlignment = UITextAlignmentCenter;
        
        colorButton_.titleLabel.font = [UIFont fontWithName:@"Heiti k" size:16.0];
        
        [colorButton_ setTitleColor:RGBCOLOR(82, 92, 137) forState:UIControlStateNormal];
        
        colorButton_.inputView = self.picker;
        
        [self.contentView addSubview:colorButton_];
        
    }
    return colorButton_;    
}

- (ToolBarButton *)versionButton
{
    if (!versionButton_)
    {
        versionButton_ = [[ToolBarButton alloc]initWithFrame:CGRectZero]; 
        
        //      [versionButton_ addTarget:self action:@selector(changeVersion:) forControlEvents:UIControlEventTouchUpInside];
        
        versionButton_.delegate = self;
        
        versionButton_.backgroundColor = [UIColor clearColor];
        
        [versionButton_ setBackgroundImage:[UIImage imageNamed:@"cluster.png"] forState:UIControlStateNormal];
        
        [versionButton_ setContentEdgeInsets:UIEdgeInsetsMake(0,0,0,20)];
        
        [versionButton_ setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];    
        
        versionButton_.titleLabel.font = [UIFont fontWithName:@"Heiti k" size:16.0];
        
        [versionButton_ setTitleColor:RGBCOLOR(82, 92, 137) forState:UIControlStateNormal];
        
        versionButton_.inputView = self.picker;
        
        [self.contentView addSubview:versionButton_];
        
    }
    
    return versionButton_;    
}


- (UILabel *)colorNameLabel{
    
    if (!colorNameLabel_) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:16];
        
        colorNameLabel_ = [[UILabel alloc] initWithFrame:CGRectZero];
        
        colorNameLabel_.backgroundColor = [UIColor clearColor];
        
        colorNameLabel_.font = font;
        
        colorNameLabel_.autoresizingMask = UIViewAutoresizingNone;
        
        colorNameLabel_.textAlignment = UITextAlignmentRight;
        
        colorNameLabel_.text = L(@"Cluster_ColorDesc");
        
        colorNameLabel_.textColor = [UIColor darkGrayColor];
        
        colorNameLabel_.layer.shadowColor = [UIColor whiteColor].CGColor;
        
        colorNameLabel_.layer.shadowOffset = CGSizeMake(0.6, 0.6) ;
        
        colorNameLabel_.layer.shadowOpacity = 0;
                
        [self.contentView addSubview:colorNameLabel_];
    }
    
    return colorNameLabel_;
    
}

- (UILabel *)versionNameLabel{
    
    if (!versionNameLabel_) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:16];
        
        versionNameLabel_ = [[UILabel alloc] initWithFrame:CGRectZero];
        
        versionNameLabel_.backgroundColor = [UIColor clearColor];
        
        versionNameLabel_.font = font;
        
        versionNameLabel_.autoresizingMask = UIViewAutoresizingNone;
        
        versionNameLabel_.textAlignment = UITextAlignmentRight;
        
        versionNameLabel_.text = @"";
        
        versionNameLabel_.textColor = [UIColor darkGrayColor];
        
        versionNameLabel_.layer.shadowColor = [UIColor whiteColor].CGColor;
        
        versionNameLabel_.layer.shadowOffset = CGSizeMake(0.6, 0.6) ;
        
        versionNameLabel_.layer.shadowOpacity = 0;
        

        
        [self.contentView addSubview:versionNameLabel_];
    }
    
    return versionNameLabel_;
    
}

+ (CGFloat)height
{
    return 50;
}

@end
