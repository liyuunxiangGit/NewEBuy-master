//
//  NewOrderSnxpressStatus.m
//  SuningEBuy
//
//  Created by xmy on 2/11/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewOrderSnxpressStatus.h"

#define  kSnxpressOriginX 10

@implementation NewOrderSnxpressStatus

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

-(void)refreshCell:(NewSnxpressDTO *)dto cellType:(HeadCellType)cellType{
    
    if (IsNilOrNull(dto)) {
        return;
    }
//    [self setCoolBgViewWithCellPosition:CellPositionCenter hasLine:NO];

//    [self setCoolBgViewWithCellPosition:CellPositionTop hasLine:NO];

//    UIImageView *back = [[UIImageView alloc] initWithImage:[UIImage streImageNamed:@"yellow_top@2x.png"]];
//    
//    back.frame = self.backgroundView.frame;
//    
//    self.backgroundView = back;
    
    
    if (cellType == CellType1) {
    
        self.desLbl.frame = CGRectMake(kSnxpressOriginX, 0, 200, 30);
        
        
        self.statusLabel.frame = CGRectMake(kSnxpressOriginX, 30, 100, 40);
        
        self.deliveryLabel.frame = CGRectMake(120, 30, 170, 40);
    
        if(IsStrEmpty(dto.deliveryDate))
        {
            self.deliveryLabel.text = @"";

        }
        else
        {
            self.deliveryLabel.text = [NSString stringWithFormat:@"%@：%@",L(@"MyEBuy_ExpectedArrivalTime2"),dto.deliveryDate?dto.deliveryDate:@""];

        }
        
        self.lineView.frame = CGRectMake(kSnxpressOriginX, _deliveryLabel.bottom-1, 280, 1);

    }else{
        
        self.desLbl.frame = CGRectMake(kSnxpressOriginX, 0, 200, 30);

        
        NSDictionary *dic = [dto.productList objectAtIndex:0];
        NSString *prodName = [dic objectForKey:@"prodName"];
        
        self.packageNameLbl.frame = CGRectMake(kSnxpressOriginX, 30, 280, 40);
                
        self.packageNameLbl.text = [NSString stringWithFormat:@"%@%@：%@",L(@"MyEBuy_Package"),dto.packageNum,prodName?prodName:@""];
        
        self.statusLabel.frame = CGRectMake(kSnxpressOriginX, 70, 100, 40);
        
        self.deliveryLabel.frame = CGRectMake(120, 70, 170, 40);
        
        if(IsStrEmpty(dto.deliveryDate))
        {
            self.deliveryLabel.text = @"";
            
        }
        else
        {
            self.deliveryLabel.text = [NSString stringWithFormat:@"%@：%@",L(@"MyEBuy_ExpectedArrivalTime2"),dto.deliveryDate?dto.deliveryDate:@""];
            
        }
       
        
        self.lineView.frame = CGRectMake(kSnxpressOriginX, _deliveryLabel.bottom-1, 280, 1);
    }
}


#pragma mark -
#pragma mark UIView

-(UILabel *)desLbl{
    
    if (!_desLbl) {
        _desLbl = [[UILabel alloc]init];
        _desLbl.backgroundColor = [UIColor clearColor];
        _desLbl.textColor = [UIColor colorWithRGBHex:0x999081];
        _desLbl.font = [UIFont systemFontOfSize:12];
        _desLbl.text = L(@"MyEBuy_SellersDelivery");
        [self.contentView addSubview:_desLbl];
    }
    return _desLbl;
}


-(UILabel *)packageNameLbl{
    
    if (!_packageNameLbl) {
        _packageNameLbl = [[UILabel alloc]init];
        _packageNameLbl.backgroundColor = [UIColor clearColor];
        _packageNameLbl.font = [UIFont systemFontOfSize:12];
        _packageNameLbl.numberOfLines = 2;
        [self.contentView addSubview:_packageNameLbl];
    }
    return _packageNameLbl;
}

-(UILabel *)statusLabel{
    
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.font = [UIFont systemFontOfSize:12];
        _statusLabel.text = L(@"MyEBuy_DeliveryInformation");
        [self.contentView addSubview:_statusLabel];
    }
    return _statusLabel;
}

-(UILabel *)deliveryLabel{
    
    if (!_deliveryLabel) {
        _deliveryLabel = [[UILabel alloc]init];
        _deliveryLabel.backgroundColor = [UIColor clearColor];
        _deliveryLabel.font = [UIFont systemFontOfSize:12];
        _deliveryLabel.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:_deliveryLabel];
    }
    return _deliveryLabel;
}

-(UIImageView *)lineView{
    
    if (!_lineView) {
        _lineView = [[UIImageView alloc] init];
        _lineView.backgroundColor = [UIColor clearColor];
        _lineView.image = [UIImage streImageNamed:@"new_order_line.png"];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

@end
