//
//  AddressItemCell.m
//  SuningEBuy
//
//  Created by xy ma on 11-10-20.
//  Copyright (c) 2011年 sn. All rights reserved.
//  主要参考OrderListItemCell,

#import "AddressItemCell.h"
#import "AddressInfoDAO.h"

#define  leftPadding    20
#define  ADDRESS_LIST_CELL_HEIGHT  100

#define Top    12

#define Mid    5
#define Bottom 12

@implementation AddressItemCell

- (void)setAddressInfoItem:(AddressInfoDTO *)aAddressInfoItem edit:(BOOL)isEdit
{
    if (IsNilOrNull(aAddressInfoItem))
        return;
    _addressInfoItem = aAddressInfoItem;
    
    NSString *addressMain = nil;
    NSMutableAttributedString *timeContentAtt = nil;
    if (_addressInfoItem.preferFlag == YES) {
        addressMain = [NSString stringWithFormat:@"%@%@ %@ %@ %@%@",L(@"ADDefaultAddress"),
                       _addressInfoItem.provinceContent?_addressInfoItem.provinceContent:@"",
                       _addressInfoItem.cityContent?_addressInfoItem.cityContent:@"",
                       _addressInfoItem.districtContent?_addressInfoItem.districtContent:@"",
                       _addressInfoItem.townContent?_addressInfoItem.townContent:@"",_addressInfoItem.addressContent];
    }
    else
    {
        addressMain = [NSString stringWithFormat:@"%@ %@ %@ %@%@",
                       _addressInfoItem.provinceContent?_addressInfoItem.provinceContent:@"",
                       _addressInfoItem.cityContent?_addressInfoItem.cityContent:@"",
                       _addressInfoItem.districtContent?_addressInfoItem.districtContent:@"",
                       _addressInfoItem.townContent?_addressInfoItem.townContent:@"",_addressInfoItem.addressContent];
    }
    timeContentAtt = [[NSMutableAttributedString alloc] initWithString:addressMain];
    if (NotNilAndNull(timeContentAtt))
    {
        [timeContentAtt setTextColor:[UIColor grayColor]];
        NSRange range = [addressMain rangeOfString:L(@"ADDefaultAddress")];
        if (range.location != NSNotFound)
        {
            //            [timeContentAtt setTextColor:[UIColor orange_Light_Color] range:[addressMain rangeOfString:@"[默认地址]"]];
            [timeContentAtt setTextColor:[UIColor orange_Light_Color] range:range];
        }
        
        NSRange selectedRange = {0, [timeContentAtt length]};
        [timeContentAtt addAttribute:NSUnderlineStyleAttributeName
                               value:[NSNumber numberWithInt:0]
                               range:selectedRange];
        
        self.addressLab.attributedText = timeContentAtt;
    }
    
    //    self.addressLab.text = [NSString stringWithFormat:@"%@%@",addressMain,_addressInfoItem.addressContent];
    
    CGRect labFrame = self.addressLab.frame;
    
    labFrame.size.height = [AddressItemCell heightOfAddressLab:_addressInfoItem type:self.cellType edit:isEdit] + 3;
    
    self.addressLab.frame = labFrame;
    
    self.nameLab.text = _addressInfoItem.recipient;
    
    self.phoneLab.text = _addressInfoItem.tel;
    
    [self setFrameWithType:self.cellType edit:isEdit];
    
}

-(void)setFrameWithType:(AddressCellType)type edit:(BOOL)isEdit{
    
    self.lineImgView.frame = CGRectMake(273, 15, 1, [AddressItemCell height:self.addressInfoItem type:type edit:isEdit] - 30);
    
    self.editBtn.frame = CGRectMake(272, 0, 48, [AddressItemCell height:self.addressInfoItem type:type edit:isEdit]);
    
    if (type == FromShop) {
        
        CGRect labFrame = self.nameLab.frame;
        labFrame.origin.x = 42;
        self.nameLab.frame = labFrame;
        
        labFrame = self.phoneLab.frame;
        labFrame.origin.x = 160;
        labFrame.size.width = 100;
        self.phoneLab.frame = labFrame;
        
        labFrame = self.addressLab.frame;
        labFrame.origin.x = 42;
        labFrame.size.width = 220;
        self.addressLab.frame = labFrame;

        self.markBtn.frame = CGRectMake(-150, 0, 350, [AddressItemCell height:self.addressInfoItem type:type edit:isEdit]);
        self.markBtn.hidden = NO;
  
//        if (isEdit) {
//            
//            self.markView.image = [UIImage imageNamed:@"cellDetail.png"];
//            
//            self.markView.frame = CGRectMake(290, ([AddressItemCell height:self.addressInfoItem type:type edit:isEdit]-11)/2.0, 6, 11);
//            
//            self.addressLab.textColor = [UIColor dark_Gray_Color];
//            self.nameLab.textColor =[UIColor light_Black_Color];
//            self.phoneLab.textColor =[UIColor light_Black_Color];
//            
//        }
//        else{
        
            if (_isSelect) {
                
//                self.markView.image = [UIImage imageNamed:@"singleCheck_selected.png"];
                self.markBtn.selected = YES;
//                self.addressLab.textColor = [UIColor dark_Gray_Color];
//                self.nameLab.textColor =[UIColor light_Black_Color];
//                self.phoneLab.textColor =[UIColor light_Black_Color];
//                self.addressLab.textColor = [UIColor orange_Light_Color];
//                self.nameLab.textColor =[UIColor orange_Light_Color];
//                self.phoneLab.textColor =[UIColor orange_Light_Color];
            }
            else{
                
//                self.markView.image = [UIImage imageNamed:@"singleCheck_unselect.png"];
                self.markBtn.selected = NO;
                
//                self.addressLab.textColor = [UIColor dark_Gray_Color];
//                self.nameLab.textColor =[UIColor light_Black_Color];
//                self.phoneLab.textColor =[UIColor light_Black_Color];
            }
//        }
        
    }
    else{
        
//        if (isEdit) {
//            
//            CGRect labFrame = self.nameLab.frame;
//            labFrame.size.width = 120;
//            self.nameLab.frame = labFrame;
//            
//            labFrame = self.phoneLab.frame;
//            labFrame.origin.x = leftPadding+120;
//            labFrame.size.width = 120;
//            self.phoneLab.frame = labFrame;
//            
//            labFrame = self.addressLab.frame;
//            labFrame.size.width = 240;
//            self.addressLab.frame = labFrame;
//            
//            self.markView.image = [UIImage imageNamed:@"cellDetail.png"];
//            self.markView.frame = CGRectMake(290, ([AddressItemCell height:self.addressInfoItem type:type edit:isEdit]-11)/2.0, 6, 11);
//            self.markView.hidden = NO;
//        }
//        else{
        
            CGRect labFrame = self.nameLab.frame;
            labFrame.size.width = 140;
            self.nameLab.frame = labFrame;
            
            labFrame = self.phoneLab.frame;
            labFrame.origin.x = leftPadding+140;
            labFrame.size.width = 100;
            self.phoneLab.frame = labFrame;
            
            labFrame = self.addressLab.frame;
            labFrame.size.width = 250;
            self.addressLab.frame = labFrame;
            
            self.markBtn.hidden = YES;
//        }

        
    }
}
- (void)setIsSelect:(BOOL)isSelect
{
    _isSelect = isSelect;
    
//    if (_isSelect) {
//        
//        self.markView.image = [UIImage imageNamed:@"cellMark.png"];
//        
//        self.addressLab.textColor = [UIColor orange_Light_Color];
//        self.nameLab.textColor =[UIColor orange_Light_Color];
//        self.phoneLab.textColor =[UIColor orange_Light_Color];
//    }
//    else{
//        
//        self.markView.image = nil;//[UIImage imageNamed:@"Unselected.png"];
//
//        self.addressLab.textColor = [UIColor dark_Gray_Color];
//        self.nameLab.textColor =[UIColor light_Black_Color];
//        self.phoneLab.textColor =[UIColor light_Black_Color];
//    }
    
}

+ (CGFloat) height:(AddressInfoDTO *)addressInfoItem type:(AddressCellType)cellType edit:(BOOL)edit{
	
    UIFont *font = [UIFont systemFontOfSize:15];
    
    CGSize size = [@"a" sizeWithFont:font];
    
	return Top + Mid + Bottom + size.height + [AddressItemCell heightOfAddressLab:addressInfoItem type:cellType edit:edit];
	
}

+ (float)heightOfAddressLab:(AddressInfoDTO *)addressInfoItem type:(AddressCellType)cellType edit:(BOOL)edit{
    NSString *addressMain;
    if (addressInfoItem.preferFlag == YES) {
        addressMain = [NSString stringWithFormat:@"%@%@ %@ %@ %@",L(@"ADDefaultAddress"),
                                 addressInfoItem.provinceContent?addressInfoItem.provinceContent:@"",
                                 addressInfoItem.cityContent?addressInfoItem.cityContent:@"",
                                 addressInfoItem.districtContent?addressInfoItem.districtContent:@"",
                                 addressInfoItem.townContent?addressInfoItem.townContent:@""];
    }
    else
    {
         addressMain = [NSString stringWithFormat:@"%@ %@ %@ %@",
                                 addressInfoItem.provinceContent?addressInfoItem.provinceContent:@"",
                                 addressInfoItem.cityContent?addressInfoItem.cityContent:@"",
                                 addressInfoItem.districtContent?addressInfoItem.districtContent:@"",
                                 addressInfoItem.townContent?addressInfoItem.townContent:@""];
    }
    
    
    float labWidth = 250;
    
    if ( cellType == FromShop) {
        
        labWidth -= 30;
    }
    if (edit) {
        
        labWidth = 220;
    }
    UIFont *font = [UIFont systemFontOfSize:12];
    
    CGSize size = [[NSString stringWithFormat:@"%@%@",addressMain,addressInfoItem.addressContent] sizeWithFont:font constrainedToSize:CGSizeMake(labWidth, 10000)];
    
    return size.height;

}

- (UIButton *)markBtn{
    
     if (!_markBtn)
    {
        _markBtn = [[UIButton alloc] init];
        
        _markBtn.hidden = NO;
                
        _markBtn.backgroundColor = [UIColor clearColor];
        
        [_markBtn setImage:[UIImage imageNamed:@"rightIcon.png"] forState:UIControlStateSelected];
        
        [_markBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        [_markBtn addTarget:self action:@selector(editAddressAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_markBtn];
    }
    
    return _markBtn;
}

- (UIImageView *)lineImgView
{
    if (!_lineImgView)
    {
        _lineImgView = [[UIImageView alloc] init];
        
        _lineImgView.backgroundColor = [UIColor clearColor];
        
        _lineImgView.image = [UIImage imageNamed:@"segment_line_vertical_gray.png"];
        
        [self.contentView addSubview:_lineImgView];
    }
    return _lineImgView;
}

- (UIButton *)editBtn
{
    if (!_editBtn) {
        _editBtn = [[UIButton alloc] init];
        
        _editBtn.backgroundColor = [UIColor clearColor];
                
        [_editBtn setImage:[UIImage imageNamed:@"btn_edit_orange.png"] forState:UIControlStateNormal];
        
        _editBtn.userInteractionEnabled = NO;
//        [_editBtn addTarget:self action:@selector(editAddressAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_editBtn];
    }
    return _editBtn;
}

- (OHAttributedLabel *)addressLab{
	
	if (!_addressLab) {
		
		UIFont *font = [UIFont systemFontOfSize:15];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_addressLab = [[OHAttributedLabel alloc] initWithFrame:CGRectMake(leftPadding, Top+Mid+size.height, 250, size.height)];
		
		_addressLab.backgroundColor = [UIColor clearColor];
        
        _addressLab.textAlignment = UITextAlignmentLeft;
		
		_addressLab.font = [UIFont systemFontOfSize:12];;
        
//        _addressLab.numberOfLines = 0;
        
        _addressLab.textColor = [UIColor dark_Gray_Color];
		
		[self.contentView addSubview:_addressLab];
	}
	
	return _addressLab;
}

- (UILabel *)nameLab{
	
	if (!_nameLab) {
		
		UIFont *font = [UIFont systemFontOfSize:15];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_nameLab = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, Top, 135, size.height)];
		
		_nameLab.backgroundColor = [UIColor clearColor];
		
        _nameLab.textColor = [UIColor light_Black_Color];
        
		_nameLab.font = font;
		
		[self.contentView addSubview:_nameLab];
	}
	
	return _nameLab;
}

- (UILabel *)phoneLab{
	
	if (!_phoneLab) {
		
		UIFont *font = [UIFont systemFontOfSize:15];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_phoneLab = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding+130, Top, 140, size.height)];
		
		_phoneLab.backgroundColor = [UIColor clearColor];
		
		_phoneLab.font = font;
        
        _phoneLab.textAlignment = UITextAlignmentRight;
        
        _phoneLab.textColor = [UIColor light_Black_Color];
		
		[self.contentView addSubview:_phoneLab];
	}
	
	return _phoneLab;
    
}

#pragma btn Action Method

-(void)editAddressAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(editAddressItemAction:withTag:)])
    {
        [_delegate editAddressItemAction:self.addressInfoItem withTag:self.tag];
    }
}

@end
