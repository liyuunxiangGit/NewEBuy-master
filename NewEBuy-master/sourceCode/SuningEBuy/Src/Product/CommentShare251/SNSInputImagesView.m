//
//  SNSInputImagesView.m
//  SuningSummer
//
//  Created by Joe Mini  on 14-7-31.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNSInputImagesView.h"
#import "UIButton+TapScope.h"
#import "UIView+Label.h"

@protocol SNSINputImageDelegate <NSObject>
-(void)cellDelete:(int)tag;
-(void)cellPressed:(int)tag;
@end
@interface SNSInputImage : UIView
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIButton *deleteBtn;
@property(nonatomic,strong)UIButton *clickBtn;
@property(nonatomic,assign)id<SNSINputImageDelegate> delegate;
@property(nonatomic,assign)int innerInternal;
-(void)deleteMode:(BOOL)yesOrNo;
-(void)reSize;
@end

@implementation SNSInputImage
-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
        
        self.clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clickBtn.frame = CGRectMake(0, 0, 20, 20);
        [_clickBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_clickBtn];
        
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteBtn.frame = CGRectMake(frame.size.width - 20, 0, 20, 20);
        self.deleteBtn.hitEdgeInsets = UIEdgeInsetsMake(0, -30, -30, 0);
        [self.deleteBtn setImage:[UIImage imageNamed:@"CommentShare_DeletePhoto"] forState:UIControlStateNormal];
        [self addSubview:self.deleteBtn];
        [self.deleteBtn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
        self.deleteBtn.hidden = YES;
        

    }
    return self;
}

-(void)reSize
{
    self.imageView.frame = CGRectMake(self.innerInternal, self.innerInternal, self.frame.size.width - 2*self.innerInternal, self.frame.size.height - 2*self.innerInternal);
    self.clickBtn.frame = CGRectMake(self.innerInternal, self.deleteBtn.frame.size.height, self.frame.size.width - 2*self.innerInternal-self.deleteBtn.frame.size.width, self.frame.size.height - 2*self.innerInternal - self.deleteBtn.frame.size.height);
    self.deleteBtn.frame = CGRectMake(self.frame.size.width -  self.deleteBtn.frame.size.width, 0 ,  self.deleteBtn.frame.size.width,  self.deleteBtn.frame.size.height);
}

-(void)delete:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellDelete:)]) {
        [self.delegate cellDelete:self.tag];
    }
}

-(void)deleteMode:(BOOL)yesOrNo
{
    self.deleteBtn.hidden = !yesOrNo;
}

-(void)click:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cellPressed:)]) {
        [self.delegate cellPressed:self.tag];
    }
}
@end

@interface SNSInputImagesView ()<SNSINputImageDelegate>
{
    NSMutableArray *_cells;
    
    float leftMargin,rightMargin,topMargin,bottomMargin,internal,innerInternal;
    
    int maxRows ;
    
    int cellVisiableWidth ;
    
    BOOL    _deleteMode;
    
    UIButton    *_addBtn;
    UILabel     *_addHint;
}

@end

@implementation SNSInputImagesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _cells = [[NSMutableArray alloc] init];
        
        leftMargin = 15/2;
        internal = 0;
        innerInternal = 15/2;
        rightMargin = 15/2;
        topMargin = 15/2;
        bottomMargin = 15/2;
        
        cellVisiableWidth = 46;
        
        _max = 10;
        
        maxRows = 5;
        self.autoSize = NO;
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
        [self addGestureRecognizer:longPressGesture];
    }
    return self;
}

-(void)setShowAdd:(BOOL)yesOrNo{
    _showAdd = yesOrNo;
    if (_showAdd && !_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *addBtnImage = [UIImage imageNamed:@"CommentShare_AddPhoto.png"];
        [_addBtn setImage:addBtnImage forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(addBtnSelected:) forControlEvents:UIControlEventTouchUpInside];
        _addBtn.frame = CGRectMake(leftMargin, topMargin, cellVisiableWidth, cellVisiableWidth);
        [self addSubview:_addBtn];
        
        _addHint = [self labelWithMsg:L(@"CommentShare_AddPhoto") color:RGBCOLOR(252, 124, 38) align:NSTextAlignmentLeft fontSize:15];
        _addHint.frame = CGRectMake(_addBtn.right + 10, _addBtn.top + (_addBtn.height - 15)/2, 60, 15);
    }
    _addBtn.hidden = !_showAdd;
    [self resetAddBtnHintTextVisiable];
}

-(void)resetAddBtnHintTextVisiable
{
    _addBtn.hidden = _cells.count == _max ? YES:NO;
    _addHint.hidden = _cells.count == 0? NO:YES;
    _addHint.hidden = _showAdd?_addHint.hidden : NO;
}

-(NSInteger)addImageByPath:(NSString*)imagePath
{
    return [self addImage:[UIImage imageWithContentsOfFile:imagePath]];
}

-(NSInteger)addImage:(UIImage*)image
{
    if (_cells.count >= self.max ) {
        return NSNotFound;
    }
    SNSInputImage *cellImage = [[SNSInputImage alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    cellImage.imageView.image = image;
    cellImage.tag =  _cells.count;
    cellImage.delegate = self;
    cellImage.innerInternal = innerInternal;
    [self addSubview:cellImage];
    [_cells addObject:cellImage];
    [self reOrder];
    return cellImage.tag;
}

-(void)addImages:(NSMutableArray*)images
{
    for (UIImage *image in images) {
        [self addImage:image];
    }
}

-(void)clean
{
    for (SNSInputImage *cell in _cells) {
        [cell removeFromSuperview];
    }    
    [_cells removeAllObjects];
}

-(void)deleteImageAtIndex:(int)index
{
    SNSInputImage *cell = [_cells objectAtIndex:index];
    [cell removeFromSuperview];
    [_cells removeObjectAtIndex:index];
}

-(CGSize)getCellSize
{
    if (self.autoSize) {
        int count = _cells.count >= maxRows? maxRows:_cells.count;
        CGSize allSize = CGSizeMake(self.frame.size.width - leftMargin - rightMargin - internal*(count-1), self.frame.size.height-topMargin - bottomMargin- internal*(count - 1));
        CGSize size = CGSizeMake(allSize.width/count, allSize.height/count);
        return size;
    }else{
        return CGSizeMake(cellVisiableWidth+2*innerInternal, cellVisiableWidth+2*innerInternal);
    }
}

-(void)reOrder
{
    CGSize cellSize = [self getCellSize];
    for (int i = 0; i < _cells.count; i++) {
        SNSInputImage *cell = [_cells objectAtIndex:i];
        cell.tag = i;
        cell.frame = CGRectMake(leftMargin + (i%maxRows)*(cellSize.width+internal), topMargin + (i/maxRows)*(cellSize.height+internal), cellSize.width, cellSize.height);
        [cell reSize];
    }
    self.frame = CGRectMake(self.left, self.top, self.width, [self height]);
    if (_showAdd) {
        [self resetAddBtnHintTextVisiable];
        SNSInputImage *cell = [_cells lastObject];
        if (!cell) {
            _addBtn.frame = CGRectMake(leftMargin*2, topMargin, _addBtn.width, _addBtn.height);
        }else{
            _addBtn.frame = CGRectMake(cell.left + cell.width + innerInternal, cell.top + innerInternal, _addBtn.width, _addBtn.height);
            if (_cells.count % maxRows == 0) {
                _addBtn.frame = CGRectMake(leftMargin*2 + (_cells.count%maxRows)*(cell.width+internal), topMargin + (_cells.count/maxRows)*(cell.height+internal)+innerInternal, _addBtn.width, _addBtn.height);
            }
        }
        _addHint.frame = CGRectMake(_addBtn.left + _addBtn.width + 15, _addBtn.top + (_addBtn.height - _addHint.height)/2, _addHint.width, _addHint.height);
    }
}

-(void)longPressed:(UILongPressGestureRecognizer *) gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self setDeleteMode:!_deleteMode];
    }
}

-(void)setDeleteMode:(BOOL)yesOrNo
{
    _deleteMode = yesOrNo;
    for (int i = 0; i < _cells.count; i++) {
        SNSInputImage *cell = [_cells objectAtIndex:i];
        [cell deleteMode:yesOrNo];
    }
}

-(void)cellDelete:(int)tag
{
    [self deleteImageAtIndex:tag];
    [self reOrder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageDeletedAtIndex:)]) {
        [self.delegate imageDeletedAtIndex:tag];
    }
}

-(void)cellPressed:(int)tag
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(imagePressedAtIndex:)]) {
        [self.delegate imagePressedAtIndex:tag];
    }
}

-(void)addBtnSelected:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(imageAdd)]) {
        [self.delegate imageAdd];
    }
}

-(float)height
{
    if (_cells.count == 0 && _showAdd) {
        return cellVisiableWidth + topMargin + bottomMargin;
    }
    CGSize cellSize = [self getCellSize];
    return (_cells.count/maxRows + 1)*(cellSize.height+internal) + topMargin + bottomMargin;
}

@end
