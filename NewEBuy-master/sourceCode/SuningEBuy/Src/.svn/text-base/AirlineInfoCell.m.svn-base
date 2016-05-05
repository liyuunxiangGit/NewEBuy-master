//
//  AirlineInfoCell.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-5-17.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "AirlineInfoCell.h"

#import "FXLabel.h"

@interface AirlineInfoCell()

@property (nonatomic, strong) FXLabel *airlineTypeLabel;
@property (nonatomic, strong) UIButton *ruleInfoButton;
@property (nonatomic, strong) EGOImageView *airlineComLogo;
@property (nonatomic, strong) FXLabel *airlineComNameLabel;
@property (nonatomic, strong) FXLabel *startTimeLabel;
@property (nonatomic, strong) FXLabel *startAirportLabel;
@property (nonatomic, strong) FXLabel *arriveTimeLabel;
@property (nonatomic, strong) FXLabel *arriveAirportLabel;

@property (nonatomic, strong) FXLabel *startAirportContentLabel;
@property (nonatomic, strong) FXLabel *arriveAirportContentLabel;


@property (nonatomic, strong) UIImageView *separatorLine;

@end

/*********************************************************************/

@implementation AirlineInfoCell

@synthesize airlineTypeLabel = _airlineTypeLabel;
@synthesize ruleInfoButton = _ruleInfoButton;
@synthesize airlineComLogo = _airlineComLogo;
@synthesize airlineComNameLabel = _airlineComNameLabel;
@synthesize startTimeLabel = _startTimeLabel;
@synthesize startAirportLabel = _startAirportLabel;
@synthesize arriveTimeLabel = _arriveTimeLabel;
@synthesize arriveAirportLabel = _arriveAirportLabel;
@synthesize startAirportContentLabel = _startAirportContentLabel;
@synthesize arriveAirportContentLabel = _arriveAirportContentLabel;
@synthesize separatorLine = _separatorLine;

@synthesize orderDetailDTO = _orderDetailDTO;
@synthesize typeInfo = _typeInfo;
@synthesize delegate = _delegate;

- (void)dealloc {
    TT_RELEASE_SAFELY(_airlineTypeLabel);
    TT_RELEASE_SAFELY(_ruleInfoButton);
    TT_RELEASE_SAFELY(_airlineComLogo);
    TT_RELEASE_SAFELY(_airlineComNameLabel);
    TT_RELEASE_SAFELY(_startTimeLabel);
    TT_RELEASE_SAFELY(_startAirportLabel);
    TT_RELEASE_SAFELY(_arriveTimeLabel);
    TT_RELEASE_SAFELY(_arriveAirportLabel);
    TT_RELEASE_SAFELY(_startAirportContentLabel);
    TT_RELEASE_SAFELY(_arriveAirportContentLabel);
    TT_RELEASE_SAFELY(_separatorLine);
    
    TT_RELEASE_SAFELY(_orderDetailDTO);
    TT_RELEASE_SAFELY(_typeInfo);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+ (CGFloat)height
{
    return 98.0f;
}

#pragma mark -
#pragma mark set item

- (void)setItem:(PFOrderDetailDTO *)dto dataType:(NSDictionary *)type
{
    if (dto == nil) {
        return;
    }
    self.orderDetailDTO = dto;
    self.typeInfo = type;
    NSInteger _dataType = [[type objectForKey:@"type"] integerValue];
    
    if (_dataType == PFDetailDataTypeAirline) {
        NSInteger index = [[type objectForKey:@"index"] integerValue];
        AirlineInfoDTO *dto = [self.orderDetailDTO.airLineInfoArray objectAtIndex:index];
        self.airlineTypeLabel.text = [NSString stringWithFormat:@"%@：%@", dto.airlineType, [dto.startTime substringToIndex:10]];
        NSString *imageUrl = [NSString stringWithFormat:@"http://image.suning.cn/images/advertise/hjc123/hkgs516/%@.png", dto.airlineCode];
        self.airlineComLogo.imageURL = [NSURL URLWithString:imageUrl];
        self.airlineComNameLabel.text = [NSString stringWithFormat:@"%@%@", dto.airlineComName, dto.flightNo];
        self.startAirportLabel.text = L(@"BTFly1");
        self.startAirportContentLabel.text = dto.startAirport;
        self.startTimeLabel.text = [NSString stringWithFormat:@"%@", [dto.startTime substringWithRange:NSMakeRange(11, 5)]];
        self.arriveAirportLabel.text = L(@"BTLand1");
        self.arriveAirportContentLabel.text = dto.arriveAirport;
        self.arriveTimeLabel.text = [NSString stringWithFormat:@"%@", [dto.arriveTime substringWithRange:NSMakeRange(11, 5)]];
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.airlineTypeLabel.frame = CGRectMake(20, 5, 200, 25);
    self.ruleInfoButton.frame = CGRectMake(200, 10, 90, 30);
    self.airlineComLogo.frame = CGRectMake(20, self.airlineTypeLabel.bottom, 22, 22);
    self.airlineComNameLabel.frame = CGRectMake(self.airlineComLogo.right+5, self.airlineTypeLabel.bottom, 200, 20);
    self.startAirportLabel.frame = CGRectMake(20, self.airlineComNameLabel.bottom, 50, 20);
    self.startTimeLabel.frame = CGRectMake(self.startAirportLabel.right-5, self.airlineComNameLabel.bottom, 50, 20);
    self.startAirportContentLabel.frame = CGRectMake(self.startTimeLabel.right-5, self.startTimeLabel.top, 150, 20);
    self.arriveAirportLabel.frame = CGRectMake(20, self.startAirportLabel.bottom, 50, 20);
    self.arriveTimeLabel.frame = CGRectMake(self.arriveAirportLabel.right-5, self.startAirportLabel.bottom, 50, 20);
    self.arriveAirportContentLabel.frame = CGRectMake(self.arriveTimeLabel.right-5, self.arriveTimeLabel.top, 150, 20);
    //self.separatorLine.frame = CGRectMake(10, self.arriveTimeLabel.bottom+7, 300, 2);
}

- (void)showRuleInfo
{
    if (_delegate && [_delegate respondsToSelector:@selector(showRuleInfo:)]) {
        NSInteger index = [[self.typeInfo objectForKey:@"index"] integerValue];
        AirlineInfoDTO *dto = [self.orderDetailDTO.airLineInfoArray objectAtIndex:index];
        [_delegate showRuleInfo:dto];
    }
}

#pragma mark -
#pragma mark view getters

- (FXLabel *)airlineTypeLabel
{
    if (!_airlineTypeLabel) {
        _airlineTypeLabel = [[FXLabel alloc] init];
        _airlineTypeLabel.backgroundColor = [UIColor clearColor];
        _airlineTypeLabel.textColor = [UIColor redColor];
        _airlineTypeLabel.frame = CGRectMake(20, 5, 200, 25);
        _airlineTypeLabel.font = [UIFont boldSystemFontOfSize:17.0];
        _airlineTypeLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
        _airlineTypeLabel.shadowOffset = CGSizeMake(0.35, 0.5);
        _airlineTypeLabel.shadowBlur = 1.0f;
        _airlineTypeLabel.innerShadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
        _airlineTypeLabel.innerShadowOffset = CGSizeMake(0.35, 0.5);
        [self.contentView addSubview:_airlineTypeLabel];
    }
    return _airlineTypeLabel;
}

- (UIButton *)ruleInfoButton
{
    if (!_ruleInfoButton) {
        _ruleInfoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _ruleInfoButton.layer.cornerRadius = 6.0;
        _ruleInfoButton.backgroundColor = RGBCOLOR(30, 196, 236);
        [_ruleInfoButton setTitle:L(@"BTEndorseRule") forState:UIControlStateNormal];
        _ruleInfoButton.titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        [_ruleInfoButton addTarget:self action:@selector(showRuleInfo) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_ruleInfoButton];
    }
    return _ruleInfoButton;
}

- (EGOImageView *)airlineComLogo
{
    if (!_airlineComLogo) {
        _airlineComLogo = [[EGOImageView alloc] init];
        [self.contentView addSubview:_airlineComLogo];
    }
    return _airlineComLogo;
}

- (FXLabel *)airlineComNameLabel
{
    if (!_airlineComNameLabel) {
        _airlineComNameLabel = [[FXLabel alloc] init];
        _airlineComNameLabel.backgroundColor = [UIColor clearColor];
        _airlineComNameLabel.textColor = [UIColor skyBlueColor];
        _airlineComNameLabel.frame = CGRectMake(20, 5, 200, 25);
        _airlineComNameLabel.font = [UIFont systemFontOfSize:15.0];
        _airlineComNameLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
        _airlineComNameLabel.shadowOffset = CGSizeMake(0.35, 0.5);
        _airlineComNameLabel.shadowBlur = 1.0f;
        _airlineComNameLabel.innerShadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
        _airlineComNameLabel.innerShadowOffset = CGSizeMake(0.35, 0.5);
        [self.contentView addSubview:_airlineComNameLabel];
    }
    return _airlineComNameLabel;
}

- (FXLabel *)startTimeLabel
{
    if (!_startTimeLabel) {
        _startTimeLabel = [[FXLabel alloc] init];
        _startTimeLabel.backgroundColor = [UIColor clearColor];
        _startTimeLabel.textColor = [UIColor redColor];
        _startTimeLabel.frame = CGRectMake(20, 5, 200, 25);
        _startTimeLabel.font = [UIFont systemFontOfSize:16.0];
        _startTimeLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
        _startTimeLabel.shadowOffset = CGSizeMake(0.35, 0.5);
        _startTimeLabel.shadowBlur = 1.0f;
        _startTimeLabel.innerShadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
        _startTimeLabel.innerShadowOffset = CGSizeMake(0.35, 0.5);
        [self.contentView addSubview:_startTimeLabel];
    }
    return _startTimeLabel;
}

- (FXLabel *)startAirportLabel
{
    if (!_startAirportLabel) {
        _startAirportLabel = [[FXLabel alloc] init];
        _startAirportLabel.backgroundColor = [UIColor clearColor];
        _startAirportLabel.textColor = [UIColor darkGrayColor];
        _startAirportLabel.frame = CGRectMake(20, 5, 200, 25);
        _startAirportLabel.font = [UIFont systemFontOfSize:15.0];
        _startAirportLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
        _startAirportLabel.shadowOffset = CGSizeMake(0.35, 0.5);
        _startAirportLabel.shadowBlur = 1.0f;
        _startAirportLabel.innerShadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
        _startAirportLabel.innerShadowOffset = CGSizeMake(0.35, 0.5);
        [self.contentView addSubview:_startAirportLabel];
    }
    return _startAirportLabel;
}

- (FXLabel *)arriveTimeLabel
{
    if (!_arriveTimeLabel) {
        _arriveTimeLabel = [[FXLabel alloc] init];
        _arriveTimeLabel.backgroundColor = [UIColor clearColor];
        _arriveTimeLabel.textColor = [UIColor redColor];
        _arriveTimeLabel.frame = CGRectMake(20, 5, 200, 25);
        _arriveTimeLabel.font = [UIFont systemFontOfSize:16.0];
        _arriveTimeLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
        _arriveTimeLabel.shadowOffset = CGSizeMake(0.35, 0.5);
        _arriveTimeLabel.shadowBlur = 1.0f;
        _arriveTimeLabel.innerShadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
        _arriveTimeLabel.innerShadowOffset = CGSizeMake(0.35, 0.5);
        [self.contentView addSubview:_arriveTimeLabel];
    }
    return _arriveTimeLabel;
}

- (FXLabel *)arriveAirportLabel
{
    if (!_arriveAirportLabel) {
        _arriveAirportLabel = [[FXLabel alloc] init];
        _arriveAirportLabel.backgroundColor = [UIColor clearColor];
        _arriveAirportLabel.textColor = [UIColor darkGrayColor];
        _arriveAirportLabel.frame = CGRectMake(20, 5, 200, 25);
        _arriveAirportLabel.font = [UIFont systemFontOfSize:15.0];
        _arriveAirportLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
        _arriveAirportLabel.shadowOffset = CGSizeMake(0.35, 0.5);
        _arriveAirportLabel.shadowBlur = 1.0f;
        _arriveAirportLabel.innerShadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
        _arriveAirportLabel.innerShadowOffset = CGSizeMake(0.35, 0.5);
        [self.contentView addSubview:_arriveAirportLabel];
    }
    return _arriveAirportLabel;
}

- (FXLabel *)startAirportContentLabel
{
    if (!_startAirportContentLabel) {
        _startAirportContentLabel = [[FXLabel alloc] init];
        _startAirportContentLabel.backgroundColor = [UIColor clearColor];
        _startAirportContentLabel.textColor = [UIColor darkGrayColor];
        _startAirportContentLabel.frame = CGRectMake(20, 5, 200, 25);
        _startAirportContentLabel.font = [UIFont systemFontOfSize:15.0];
        _startAirportContentLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
        _startAirportContentLabel.shadowOffset = CGSizeMake(0.35, 0.5);
        _startAirportContentLabel.shadowBlur = 1.0f;
        _startAirportContentLabel.innerShadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
        _startAirportContentLabel.innerShadowOffset = CGSizeMake(0.35, 0.5);
        [self.contentView addSubview:_startAirportContentLabel];
    }
    return _startAirportContentLabel;
}

- (FXLabel *)arriveAirportContentLabel
{
    if (!_arriveAirportContentLabel) {
        _arriveAirportContentLabel = [[FXLabel alloc] init];
        _arriveAirportContentLabel.backgroundColor = [UIColor clearColor];
        _arriveAirportContentLabel.textColor = [UIColor darkGrayColor];
        _arriveAirportContentLabel.frame = CGRectMake(20, 5, 200, 25);
        _arriveAirportContentLabel.font = [UIFont systemFontOfSize:15.0];
        _arriveAirportContentLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.8f];
        _arriveAirportContentLabel.shadowOffset = CGSizeMake(0.35, 0.5);
        _arriveAirportContentLabel.shadowBlur = 1.0f;
        _arriveAirportContentLabel.innerShadowColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
        _arriveAirportContentLabel.innerShadowOffset = CGSizeMake(0.35, 0.5);
        [self.contentView addSubview:_arriveAirportContentLabel];
    }
    return _arriveAirportContentLabel;
}


- (UIImageView *)separatorLine
{
    if (!_separatorLine)
    {
        _separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 79, 320, 2)];
        
        _separatorLine.image = [UIImage imageNamed:@"cellSeparatorLine.png"];
        
        [self.contentView addSubview:_separatorLine];
    }
    return _separatorLine;
}

@end
