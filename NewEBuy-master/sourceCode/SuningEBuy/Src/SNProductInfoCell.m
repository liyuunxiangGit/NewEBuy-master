//
//  SNProductInfoCell.m
//  SuningEBuy
//
//  Created by Joe on 14-11-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNProductInfoCell.h"
#import "StarChooseBar.h"

#define kWidth_Default                  (kScreenWidth - (kInterval_WithBound * 2))
#define kInterval_WithBound             15
#define kInterval_WithNear              5
#define kHeight_Default                 15
#define kHeight_HeaderView              60
#define kHeight_Image                   55
#define kHeight_Interval                5
#define kNSArray_Count                  3
#define kWidth_ImageView                ((kNSArray_Count * kHeight_Image) + (kInterval_WithNear * (kNSArray_Count - 1)))

typedef enum {
    OtherCommentView_Follow = 0,
    OtherCommentView_Office
}OtherCommentViewType;


@interface OtherCommentView : UIView

@property(nonatomic,assign)OtherCommentViewType type;
@property(nonatomic,retain)UILabel              *commentOne;
@property(nonatomic,retain)UILabel              *commentTwo;

-(void)setType:(OtherCommentViewType)type;
+(float)heightWithType:(OtherCommentViewType)type textOne:(NSString*)textOne textTwo:(NSString*)textTwo;
-(void)refresh;

@end

@implementation OtherCommentView

//@synthesize type = _type;

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //初始化commentOne，commentTwo
        _commentOne = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _commentOne.font = [UIFont systemFontOfSize:12];
        _commentTwo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _commentTwo.font = [UIFont systemFontOfSize:11];
        [self addSubview:_commentOne];
        [self addSubview:_commentTwo];
    }
    return self;
}

-(void)setType:(OtherCommentViewType)type
{
    //根据Type调整commentOne和commentTwo的大小，颜色
    //调整self backgound color
    _type = type;
    switch (type)
    {
        case OtherCommentView_Follow:
        {
            self.backgroundColor = [UIColor light_Gray_Color];
            _commentOne.textColor = [UIColor dark_Gray_Color];
            _commentTwo.textColor = [UIColor dark_Gray_Color];
            _commentTwo.numberOfLines = 1;
            _commentTwo.height = kHeight_Default;
            _commentOne.lineBreakMode = NSLineBreakByWordWrapping;
            _commentOne.numberOfLines = 0;
            break;
        }
        case OtherCommentView_Office:
        {
            self.backgroundColor = [UIColor clearColor];
            _commentOne.textColor = [UIColor blueColor];
            _commentTwo.textColor = [UIColor blueColor];
            _commentOne.numberOfLines = 1;
            _commentOne.height = kHeight_Default * 2;
            _commentTwo.lineBreakMode = NSLineBreakByWordWrapping;
            _commentTwo.numberOfLines = 0;
            break;
        }
        default:
            break;
    }
}

-(void)refresh
{
    //根据type来调整lable的高度。
    switch (_type)
    {
        case OtherCommentView_Follow:
        {
            _commentOne.height = [_commentOne.text sizeWithFont:[_commentOne font] constrainedToSize:CGSizeMake(_commentOne.width, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
            _commentTwo.top = _commentOne.bottom + kHeight_Interval;
            
            break;
        }
        case OtherCommentView_Office:
        {
            _commentTwo.top = _commentOne.bottom + kHeight_Interval;
            _commentTwo.height = [_commentTwo.text sizeWithFont:[_commentTwo font] constrainedToSize:CGSizeMake(_commentTwo.width, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
            break;
        }
        default:
            break;
    }
    self.height = _commentTwo.bottom;
}

+(float)heightWithType:(OtherCommentViewType)type textOne:(NSString*)textOne textTwo:(NSString*)textTwo
{
    //根据Type，获得commentOne和commentTwo的类型，再获取高度
    if (IsStrEmpty(textOne) && IsStrEmpty(textTwo))
    {
        return 0;
    }
    CGFloat height;
    switch (type)
    {
        case OtherCommentView_Follow:
        {
            height = [textOne sizeWithFont:[UIFont boldSystemFontOfSize:12.0] constrainedToSize:CGSizeMake(kWidth_Default, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
            height += kHeight_Default;
            height += kHeight_Interval;
            break;
        }
        case OtherCommentView_Office:
        {
            height = [textTwo sizeWithFont:[UIFont boldSystemFontOfSize:11.0] constrainedToSize:CGSizeMake(kWidth_Default, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
            height += (kHeight_Default * 2);
            height += kHeight_Interval;
            break;
        }
        default:
            break;
    }
    return height;
}

@end

@interface SNProductInfoCell ()
{
    UILabel                     *_userNameLabel;
    StarChooseBar               *_starChooseBar;
    UIButton                    *_likeBt;
    UILabel                     *_likeCountLable;
    UILabel                     *_detailLabel;
    UILabel                     *_timeTextLable;
    OtherCommentView            *_followComment;
    OtherCommentView            *_officeComment;
    UIView                      *_imageView;
}

@end

@implementation SNProductInfoCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUp];
    }
    return self;
}

-(void)setUp
{
    [self addSubview:self.userNameLabel];
    [self addSubview:self.starChooseBar];
    [self addSubview:self.likeCountLable];
    [self addSubview:self.likeBt];//由于likeBt初始化的时候使用了likeCountLable的坐标，所以likeBt的初始化要放在likeCountLable的后面
    [self addSubview:self.detailLabel];
    [self addSubview:self.timeTextLable];
    _followComment = [[OtherCommentView alloc] initWithFrame:CGRectMake(kInterval_WithBound, 0, kWidth_Default, kHeight_Default)];
    [_followComment setType:OtherCommentView_Follow];
    [self addSubview:_followComment];
    _officeComment = [[OtherCommentView alloc] initWithFrame:CGRectMake(kInterval_WithBound, 0, kWidth_Default, kHeight_Default)];
    [_officeComment setType:OtherCommentView_Office];
    [self addSubview:_officeComment];
    [self addSubview:self.imageView];
}

#pragma mark -
#pragma mark set

-(void)setUserName:(NSString *)userName
{
    _userName = userName;
    _userNameLabel.text = userName;
}

-(void)setStar:(int)star
{
    _star = star;
    [_starChooseBar showStarBar:star];
}

-(void)setLikeCount:(int)likeCount
{
    _likeCount = likeCount;
    _likeCountLable.text = [NSString stringWithFormat:@"(%d)",likeCount];
}

-(void)setDetailText:(NSString *)detailText
{
    _detailText = detailText;
    _detailLabel.text = detailText;
}

-(void)setTimeText:(NSString *)timeText
{
    _timeText = timeText;
    _timeTextLable.text = timeText;
}

-(void)setFollowCommentText:(NSString *)followCommentText
{
    _followComment.commentOne.text = followCommentText;
    if (IsStrEmpty(followCommentText)) {
        _followComment.hidden = YES;
    }
    else
    {
        _followComment.hidden = NO;
    }
}

-(void)setFollowCommentTime:(NSString *)followCommentTime
{
    _followComment.commentTwo.text = followCommentTime;
}

-(void)setOfficeCommentHead:(NSString *)officeCommentHead
{
    _officeComment.commentOne.text = officeCommentHead;
}

-(void)setOfficeCommentText:(NSString *)officeCommentText
{
    _officeComment.commentTwo.text = officeCommentText;
    if (IsStrEmpty(officeCommentText)) {
        _officeComment.hidden = YES;
    }
    else
    {
        _officeComment.hidden = NO;
    }
}

-(void)setImages:(NSMutableArray *)images
{
    
    _images = images;
    if (IsArrEmpty(images)) {
        _imageView.hidden = YES;
    }
    else
    {
        _imageView.hidden = NO;
        NSUInteger number = MIN(kNSArray_Count, _images.count);
        for (int i = 0; i < number; i++)
        {
            EGOImageView *imageInView = [[EGOImageView alloc] initWithFrame:CGRectMake((i * (kHeight_Image + kInterval_WithNear)), 0, kHeight_Image, kHeight_Image)];
            [imageInView setImageURL:[_images objectAtIndex:i]];
            //imageInView.placeholderImage = [UIImage imageNamed:@""];
            [_imageView addSubview:imageInView];
        }
    }
}

#pragma mark -
#pragma mark property
-(UILabel *)userNameLabel
{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kInterval_WithBound, kInterval_WithBound, 105, kHeight_Default)];
        [_userNameLabel setBackgroundColor:[UIColor clearColor]];
        _userNameLabel.textColor = [UIColor dark_Gray_Color];
        _userNameLabel.numberOfLines = 1;
        _userNameLabel.font = [UIFont systemFontOfSize:12];
    }
    return _userNameLabel;
}

-(StarChooseBar *)starChooseBar
{
    if (!_starChooseBar) {
        _starChooseBar = [[StarChooseBar alloc] initWithFrame:CGRectMake(_userNameLabel.right + (kInterval_WithNear * 2), 17.5, 50, 10)];
        [_starChooseBar setStarBarWithSize:10 Interval:0 Number:5 isInteraction:NO];
    }
    return _starChooseBar;
}

-(UIButton *)likeBt
{
    if (!_likeBt) {
        _likeBt = [[UIButton alloc] initWithFrame:CGRectMake(0, kInterval_WithBound, kHeight_Default, kHeight_Default)];
        _likeBt.right = _likeCountLable.left - kInterval_WithNear;
        _likeBt.userInteractionEnabled = YES;
        _likeBt.selected = NO;
        [_likeBt setImage:[UIImage imageNamed:@"checkRegisterNo.png"] forState:UIControlStateNormal];
        [_likeBt setImage:[UIImage imageNamed:@"checkRegisterYes.png"] forState:UIControlStateSelected];
        [_likeBt addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBt;
}

-(void)buttonClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    btn.selected = YES;
}

-(UILabel *)likeCountLable
{
    if (!_likeCountLable) {
        _likeCountLable = [[UILabel alloc] initWithFrame:CGRectMake(0, kInterval_WithBound, 25, kHeight_Default)];
        _likeCountLable.right = kScreenWidth - kInterval_WithBound;
        _likeCountLable.backgroundColor = [UIColor clearColor];
        _likeCountLable.textColor = [UIColor dark_Gray_Color];
        _likeCountLable.highlightedTextColor = [UIColor orange_Light_Color];
        _likeCountLable.numberOfLines = 1;
        _likeCountLable.textAlignment = UITextAlignmentCenter;
        _likeCountLable.font = [UIFont systemFontOfSize:12];
    }
    return _likeCountLable;
}

-(UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(kInterval_WithBound, _userNameLabel.bottom + kHeight_Interval, kWidth_Default, kHeight_Default)];
        _detailLabel.backgroundColor = [UIColor clearColor];
        _detailLabel.textColor = [UIColor blackColor];
        _detailLabel.font = [UIFont systemFontOfSize:12];
        _detailLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}

-(UIView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIView alloc] initWithFrame:CGRectMake(kInterval_WithBound, _detailLabel.bottom + kHeight_Interval, kWidth_ImageView, kHeight_Image)];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.hidden = NO;
    }
    return _imageView;
}
//-(EGOImageView *)imageView1
//{
//    if (!_imageView1) {
//        _imageView1 = [[EGOImageView alloc] initWithFrame:CGRectMake(kInterval_WithBound, _detailLabel.bottom + kHeight_Interval, kHeight_ImageView, kHeight_ImageView)];
//        _imageView1.backgroundColor = [UIColor clearColor];
//    }
//    return _imageView1;
//}
//
//-(EGOImageView *)imageView2
//{
//    if (!_imageView2) {
//        _imageView2 = [[EGOImageView alloc] initWithFrame:CGRectMake(_imageView1.right + kInterval_WithNear, _detailLabel.bottom + kHeight_Interval, kHeight_ImageView, kHeight_ImageView)];
//        _imageView2.backgroundColor = [UIColor clearColor];
//    }
//    return _imageView2;
//}
//
//-(EGOImageView *)imageView3
//{
//    if (!_imageView3) {
//        _imageView3 = [[EGOImageView alloc] initWithFrame:CGRectMake(_imageView2.right + kInterval_WithNear, _detailLabel.bottom + kHeight_Interval, kHeight_ImageView, kHeight_ImageView)];
//        _imageView3.backgroundColor = [UIColor clearColor];
//    }
//    return _imageView3;
//}

-(UILabel *)timeTextLable
{
    if (!_timeTextLable) {
        _timeTextLable = [[UILabel alloc] initWithFrame:CGRectMake(kInterval_WithBound, _imageView.bottom + kHeight_Interval, kWidth_Default, kHeight_Default)];
        _timeTextLable.backgroundColor = [UIColor clearColor];
        _timeTextLable.textColor = [UIColor dark_Gray_Color];
        _timeTextLable.numberOfLines = 1;
        _timeTextLable.font = [UIFont systemFontOfSize:12];
    }
    return _timeTextLable;
}


#pragma mark -
-(void)clean
{
    //将所有子view还原
    self.userName = @"";
    self.star = 0;
    self.likeCount = 0;
    self.detailText = @"";
    self.images = nil;
    self.timeText = @"";
    self.followCommentText = @"";
    self.followCommentTime = @"";
    self.officeCommentHead = @"";
    self.officeCommentText = @"";
}

-(void)refresh
{
    //设置各个子view的frame
    _userNameLabel.width = [_userName sizeWithFont:[_userNameLabel font] constrainedToSize:CGSizeMake(INT_MAX, kHeight_Default) lineBreakMode:NSLineBreakByWordWrapping].width;
    _starChooseBar.left = _userNameLabel.right + (kInterval_WithNear * 2);
    _detailLabel.top = _userNameLabel.bottom + kHeight_Interval;
    _detailLabel.height = [_detailText sizeWithFont:[_detailLabel font] constrainedToSize:CGSizeMake(_detailLabel.width, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
    _imageView.top = _detailLabel.bottom + kHeight_Interval;
    if ([_imageView isHidden])
    {
        _timeTextLable.top = _detailLabel.bottom + kHeight_Interval;
    }
    else
    {
        _timeTextLable.top = _imageView.bottom + kHeight_Interval;
    }
    _followComment.top = _timeTextLable.bottom + kHeight_Interval;
    [_followComment refresh];
    if ([_followComment isHidden])
    {
        _officeComment.top = _timeTextLable.bottom + kHeight_Interval;
        [_officeComment refresh];
    }
    else
    {
        _officeComment.top = _followComment.bottom + kHeight_Interval;
        [_officeComment refresh];
    }
    
}


+(float)heightWithDeailText:(NSString*)text hasImages:(BOOL)hasImage hasFollowComment:(NSString*)followComment andTime:(NSString*)time hasOfficeComment:(NSString*)officeComment andHead:(NSString*)head
{
    CGFloat heightOfDetailText = [text sizeWithFont:[UIFont boldSystemFontOfSize:12.0] constrainedToSize:CGSizeMake(kWidth_Default, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
    CGFloat heightOfImage = 0;
    if (hasImage)
    {
        heightOfImage = kHeight_Image + kHeight_Interval;
    }
    CGFloat height1 = [OtherCommentView heightWithType:OtherCommentView_Follow textOne:followComment textTwo:time];
    CGFloat height2 = [OtherCommentView heightWithType:OtherCommentView_Office textOne:head textTwo:officeComment];
    return (heightOfDetailText + heightOfImage + height1 + height2 + (kInterval_WithBound * 2) + (kHeight_Default * 2) + (kHeight_Interval * 2));
}

@end
