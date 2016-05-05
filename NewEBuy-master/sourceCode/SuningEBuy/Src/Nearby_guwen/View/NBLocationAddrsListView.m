//
//  NBLocationAddrsListView.m
//  suningNearby
//
//  Created by suning on 14-8-5.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "NBLocationAddrsListView.h"

#import "BMapKit.h"
#import "NBCCSharedData.h"

@implementation BMKPoiBean
@end


@interface NBLocationAddrsTableCell : UITableViewCell

@property (nonatomic,strong) BMKPoiBean *bean;

@end

@interface NBLocationAddrsTableCell ()
@property (nonatomic,strong) IBOutlet UIButton *checkButton;
@property (nonatomic,strong) IBOutlet UILabel  *titleLabel;
@property (nonatomic,strong) IBOutlet UILabel  *descLabel;

+ (NBLocationAddrsTableCell *)cell;

@end

@implementation NBLocationAddrsTableCell

- (void)setBean:(BMKPoiBean *)bean {
    _bean = bean;
    if (nil != _bean) {
        _titleLabel.text = _bean.poi.name;
        
        _descLabel.text  = [NSString stringWithFormat:@"%.2f%@",_bean.distance,L(@"meter")];
        _checkButton.selected = _bean.isSelected;
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle  = UITableViewCellSelectionStyleNone;
    }
    return self;
}

+ (NBLocationAddrsTableCell *)cell {
    return ([[NSBundle mainBundle] loadNibNamed:@"NBLocationAddrsTableCell" owner:nil options:nil][0]);
}

@end


@interface NBLocationAddrsListView () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView      *tableView0;

@property (nonatomic,strong) UILabel          *noticeLabel;

@end

@implementation NBLocationAddrsListView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.backgroundColor = [UIColor colorWithWhite:.1f alpha:.1f];
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat h = frame.size.height/2;
        
        self.tableView0 = [[UITableView alloc] initWithFrame:CGRectMake(.0f,
                                                                        frame.size.height-h,
                                                                        frame.size.width,
                                                                        h)
                                                       style:UITableViewStylePlain];
        self.tableView0.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView0.backgroundColor = [UIColor colorWithWhite:.45f alpha:.6f];
        _tableView0.delegate   = self;
        _tableView0.dataSource = self;
        [self addSubview:_tableView0];
        
        CGRect f = _tableView0.frame;
        UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(f.origin.x+f.size.width-40.0f,
                                                                      f.origin.y-14.0f,
                                                                      28.0f,
                                                                      28.0f)];
        [closeButton addTarget:self action:@selector(on_closeButton_clicked) forControlEvents:UIControlEventTouchUpInside];
        [closeButton setImage:[UIImage imageNamed:@"nb_close"] forState:UIControlStateNormal];
        [self addSubview:closeButton];
        
        CGSize sz = _tableView0.frame.size;
        self.noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(.0f,.0f,sz.width,sz.height)];
        _noticeLabel.textColor = [UIColor whiteColor];
        _noticeLabel.backgroundColor = [UIColor clearColor];
        _noticeLabel.textAlignment   = NSTextAlignmentCenter;
        _noticeLabel.font            = [UIFont systemFontOfSize:22.0f];
        [_noticeLabel setText:L(@"LocatingNow")];
        [_tableView0 addSubview:_noticeLabel];
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    UITouch *th = touches.anyObject;
    if ([th.view isEqual:self]) {
        self.hidden = YES;
    }
}

- (void)on_closeButton_clicked {
    self.hidden = YES;
}

- (void)setSourceArray:(NSArray *)sourceArray {
    
    _sourceArray = sourceArray;
    
    [self.tableView0 reloadData];
    
    self.noticeLabel.hidden = YES;
}

#pragma mark - 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BMKPoiBean *bean  = _sourceArray[indexPath.row];
    if (!bean.isSelected) {
        for (BMKPoiBean *b in _sourceArray) {
            b.isSelected = NO;
        }
        bean.isSelected = YES;
        [self.tableView0 reloadData];
    }
    
    if (nil != _selectedBlock) {
//        _selectedBlock(@{@"name":bean.poi.name,
//                         @"latitude":[NSString stringWithFormat:@"%f",bean.poi.pt.latitude],
//                         @"longitude":[NSString stringWithFormat:@"%f",bean.poi.pt.longitude]});
        
        _selectedBlock(_sourceArray[indexPath.row]);
    }
    
    self.hidden = YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify = @"cell_identify";
    NBLocationAddrsTableCell *cell = (NBLocationAddrsTableCell *)[tableView dequeueReusableCellWithIdentifier:identify];
    if (nil == cell) {
        cell = [NBLocationAddrsTableCell cell];
    }
    
    BMKPoiBean *bean    = _sourceArray[indexPath.row];
    cell.bean = bean;
    
    return cell;
}

@end
