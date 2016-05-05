//
//  OSMessageLabel.m
//  CoreTextDemo
//
//  Created by liukun on 14-8-22.
//  Copyright (c) 2014年 bluebox. All rights reserved.
//

#import "OSMessageLabel.h"
#import <CoreText/CoreText.h>

#define kOSLineSpacing      2.f

@interface OSMessageLabel()
{
    CTFramesetterRef _framesetter;
}

@property (readwrite, nonatomic, strong) NSTextCheckingResult *activeLink;

@end

#pragma mark - implement

@implementation OSMessageLabel

@synthesize attributedText = _attributedText;

- (void)_commitInit
{
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInLabel:)];
    [self addGestureRecognizer:gestureRecognizer];
}

- (void)awakeFromNib
{
    [self _commitInit];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _commitInit];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self _commitInit];
    }
    return self;
}

NSArray *getEmoticonList(void)
{
    static NSArray *list = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        list = [[NSArray alloc] initWithObjects:
                @"angry",
                @"anthomaniac",
                @"appall",
                @"arrogant",
                @"awesome",
                @"awkward",
                @"bored",
                @"collapse",
                @"cool",
                @"cute",
                @"dinner",
                @"dizzy",
                @"doubt",
                @"gifts",
                @"giggle",
                @"grimace",
                @"helpless",
                @"hot",
                @"jiong",
                @"kink",
                @"laughter",
                @"narcissism",
                @"ok",
                @"petrifaction",
                @"proud",
                @"prurience",
                @"refuse",
                @"request",
                @"rewarding",
                @"ridicule",
                @"roar",
                @"shake_hands",
                @"shame",
                @"shy",
                @"sleep",
                @"smile",
                @"smirk",
                @"speechless",
                @"tears",
                @"think",
                @"trance",
                @"vomit",
                @"welcome",
                @"yeah",
                nil];
    });
    return list;
}

static NSRegularExpression *getEmotionRegularExpression()
{
    static NSRegularExpression *regular = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *emoticonList = getEmoticonList();
        NSString *emotionRegex = @"";
        for (NSString *emotionName in emoticonList) {
            emotionRegex = [emotionRegex stringByAppendingFormat:@"%@_png|", emotionName];
        }
        emotionRegex = [emotionRegex stringByReplacingCharactersInRange:NSMakeRange(emotionRegex.length-1, 1) withString:@""];
        regular = [NSRegularExpression regularExpressionWithPattern:emotionRegex options:0 error:NULL];
    });
    return regular;
}

static NSRegularExpression *getHttpUrlRegularExpression()
{
    static NSRegularExpression *regular = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regular = [NSRegularExpression regularExpressionWithPattern:@"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?" options:NSRegularExpressionCaseInsensitive error:NULL];
    });
    return regular;
}

static void RunDelegateDeallocCallback(void* refCon) {
    
}

static CGFloat RunDelegateGetAscentCallback(void* refCon) {
    
    NSString *imageName = (__bridge NSString *)refCon;
    return [UIImage imageNamed:imageName].size.height;
}

static CGFloat RunDelegateGetDescentCallback(void* refCon) {
    
    return 0;
}

static CGFloat RunDelegateGetWidthCallback(void *refCon) {
    
    NSString *imageName = (__bridge NSString *)refCon;
    return [UIImage imageNamed:imageName].size.width;
}

static inline CGFloat TTTFlushFactorForTextAlignment(NSTextAlignment textAlignment) {
    switch (textAlignment) {
        case NSTextAlignmentCenter:
            return 0.5f;
        case NSTextAlignmentRight:
            return 1.0f;
        case NSTextAlignmentLeft:
        default:
            return 0.0f;
    }
}

+ (NSAttributedString *)generateAttributedString:(NSString *)message
{
    //创建attributedstring
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:message];
    
    //设置字体和颜色
    [attributedString addAttribute:(__bridge id)kCTFontAttributeName
                             value:[UIFont systemFontOfSize:15.0f]
                             range:NSMakeRange(0, message.length)];
    
    [attributedString addAttribute:(__bridge id)kCTForegroundColorAttributeName
                             value:[UIColor darkTextColor]
                             range:NSMakeRange(0, message.length)];

    //解析表情
    NSRegularExpression *emotionRegular = getEmotionRegularExpression();
    __block int deleteLength = 0;
    [emotionRegular enumerateMatchesInString:message options:NSMatchingReportCompletion range:NSMakeRange(0, message.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        
        if (result) {
            NSString *matchStr = [message substringWithRange:[result range]];
            NSString *imageName = [NSString stringWithFormat:@"emoticon.bundle/%@", matchStr];
            
            //设置图片回调
            CTRunDelegateCallbacks imageCallbacks;
            imageCallbacks.version = kCTRunDelegateVersion1;
            imageCallbacks.dealloc = RunDelegateDeallocCallback;
            imageCallbacks.getAscent = RunDelegateGetAscentCallback;
            imageCallbacks.getDescent = RunDelegateGetDescentCallback;
            imageCallbacks.getWidth = RunDelegateGetWidthCallback;
            
            NSMutableAttributedString *imageAttributedString = [[NSMutableAttributedString alloc] initWithString:@" "];
            CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallbacks, (__bridge void *)(imageName));
            [imageAttributedString addAttribute:(NSString *)kCTRunDelegateAttributeName
                                          value:(__bridge_transfer id)runDelegate
                                          range:NSMakeRange(0, 1)];
            [imageAttributedString addAttribute:@"imageName"
                                          value:imageName
                                          range:NSMakeRange(0, 1)];
            
            [attributedString replaceCharactersInRange:NSMakeRange(result.range.location-deleteLength, result.range.length)
                                  withAttributedString:imageAttributedString];
            
            deleteLength += (result.range.length - 1);
        }
        
    }];
    
    //匹配url
    message = attributedString.string;
    NSRegularExpression *urlRegular = getHttpUrlRegularExpression();
    [urlRegular enumerateMatchesInString:message options:NSMatchingReportCompletion range:NSMakeRange(0, message.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        
        if (result) {
            NSString *matchStr = [message substringWithRange:[result range]];
            NSURL *matchUrl = [NSURL URLWithString:matchStr];
            if (matchUrl) {
                [attributedString addAttribute:(NSString *)kCTUnderlineStyleAttributeName
                                         value:@(YES)
                                         range:[result range]];
                [attributedString addAttribute:@"OSMLLinkURL"
                                         value:[NSURL URLWithString:matchStr]
                                         range:[result range]];
                if ([NSParagraphStyle class]) {
                    [attributedString addAttribute:NSForegroundColorAttributeName
                                             value:[UIColor blueColor]
                                             range:[result range]];
                } else {
                    [attributedString addAttribute:(__bridge NSString *)kCTForegroundColorAttributeName
                                             value:(__bridge id)[[UIColor blueColor] CGColor]
                                             range:[result range]];
                }
            }
        }
    }];
    
    //设置换行
    if ([NSParagraphStyle class]) {
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paragraphStyle.lineSpacing = kOSLineSpacing;
        [attributedString addAttribute:NSParagraphStyleAttributeName
                                 value:paragraphStyle
                                 range:NSMakeRange(0, [attributedString length])];
        
    } else {
        
        CTParagraphStyleSetting lineBreakMode;
        CTLineBreakMode lineBreak = kCTLineBreakByCharWrapping;
        lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
        lineBreakMode.value = &lineBreak;
        lineBreakMode.valueSize = sizeof(CTLineBreakMode);
        CGFloat lineSpacing = kOSLineSpacing;
        CTParagraphStyleSetting settings[] = {
            lineBreakMode,
            {.spec = kCTParagraphStyleSpecifierLineSpacing, .valueSize = sizeof(CGFloat), .value = (const void *)&lineSpacing},
        };
        
        CTParagraphStyleRef style = CTParagraphStyleCreate(settings, 2);
        
        [attributedString addAttribute:(__bridge id)kCTParagraphStyleAttributeName
                                 value:(__bridge id)style
                                 range:NSMakeRange(0, [attributedString length])];
        CFRelease(style);
    }
    
    return attributedString;
}

- (void)setFramesetter:(CTFramesetterRef)framesetter {
    if (framesetter) {
        CFRetain(framesetter);
    }
    
    if (_framesetter) {
        CFRelease(_framesetter);
    }
    
    _framesetter = framesetter;
}

- (void)drawTextInRect:(CGRect)rect
{
    if (!self.attributedText) {
        
        [super drawTextInRect:rect];
        return;
    }
        
    NSAttributedString *attributedString = self.attributedText;
    CTFramesetterRef ctFramesetter = CTFramesetterCreateWithAttributedString((CFMutableAttributedStringRef)attributedString);
    [self setFramesetter:ctFramesetter];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect bounds = CGRectMake(0.0, 0.0, self.bounds.size.width, self.bounds.size.height);
    CGPathAddRect(path, NULL, bounds);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);//设置字形变换矩阵为CGAffineTransformIdentity，也就是说每一个字形都不做图形变换
    
    CGAffineTransform flipVertical = CGAffineTransformMake(1,0,0,-1,0,self.bounds.size.height);
    CGContextConcatCTM(context, flipVertical);//将当前context的坐标系进行flip
    
    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFramesetter,CFRangeMake(0, 0), path, NULL);
    CTFrameDraw(ctFrame, context);
    
    CFArrayRef lines = CTFrameGetLines(ctFrame);
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), lineOrigins);
    for (int i = 0; i < CFArrayGetCount(lines); i++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat lineLeading;
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
        
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        for (int j = 0; j < CFArrayGetCount(runs); j++) {
            CGFloat runAscent;
            CGFloat runDescent;
            CGPoint lineOrigin = lineOrigins[i];
            CTRunRef run = CFArrayGetValueAtIndex(runs, j);
            NSDictionary* attributes = (NSDictionary*)CTRunGetAttributes(run);
            CGRect runRect;
            runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0,0), &runAscent, &runDescent, NULL);
            
            runRect=CGRectMake(lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL), lineOrigin.y - runDescent, runRect.size.width, runAscent + runDescent);
            
            NSString *imageName = [attributes objectForKey:@"imageName"];
            //图片渲染逻辑
            if (imageName) {
                UIImage *image = [UIImage imageNamed:imageName];
                if (image) {
                    CGRect imageDrawRect;
                    imageDrawRect.size = image.size;
                    imageDrawRect.origin.x = runRect.origin.x + lineOrigin.x;
                    imageDrawRect.origin.y = lineOrigin.y;
                    CGContextDrawImage(context, imageDrawRect, image.CGImage);
                }
            }
        }
    }
    
    CFRelease(ctFrame);
    CFRelease(path);
    CFRelease(ctFramesetter);
}

+ (CGSize)sizeWithAttributedString:(NSAttributedString *)attributedString maxWidth:(CGFloat)maxWidth
{
    if (!attributedString) {
        return CGSizeZero;
    }

    CTFramesetterRef ctFramesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributedString);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect bounds = CGRectMake(0.0, 0.0, maxWidth, 20000.);
    CGPathAddRect(path, NULL, bounds);
    
    CTFrameRef ctFrame = CTFramesetterCreateFrame(ctFramesetter,CFRangeMake(0, 0), path, NULL);
    if (ctFrame == NULL) {
        CFRelease(path);
        return CGSizeZero;
    }

    
    CFArrayRef lines = CTFrameGetLines(ctFrame);
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), lineOrigins);
    CGFloat width = 0, height = 0;
    for (int i = 0; i < CFArrayGetCount(lines); i++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat lineLeading;
        
        CGFloat lineWidth = CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
        width = MAX(width, lineWidth);
        if (i == CFArrayGetCount(lines)-1) {
            CGPoint lineOrigin = lineOrigins[i];
            height = 20000. - lineOrigin.y + 7;
        }
    }
    
    CFRelease(ctFrame);
    CFRelease(path);
    CFRelease(ctFramesetter);
    return CGSizeMake(width, height);
}

#pragma mark - link select

- (NSTextCheckingResult *)linkAtCharacterIndex:(CFIndex)idx {
    
    if (idx == NSNotFound || idx >= self.attributedText.length) {
        return nil;
    }
    NSRange effectiveRange;
    NSURL *linkURL = [self.attributedText attribute:@"OSMLLinkURL"
                                            atIndex:idx
                                     effectiveRange:&effectiveRange];
    if ([linkURL isKindOfClass:[NSURL class]]) {
        return [NSTextCheckingResult linkCheckingResultWithRange:effectiveRange URL:linkURL];
    }
    return nil;
}

- (NSTextCheckingResult *)linkAtPoint:(CGPoint)p {
    CFIndex idx = [self characterIndexAtPoint:p];
    
    return [self linkAtCharacterIndex:idx];
}

- (CFIndex)characterIndexAtPoint:(CGPoint)p {
    if (!CGRectContainsPoint(self.bounds, p)) {
        return NSNotFound;
    }
    
    CGRect textRect = self.bounds;
    if (!CGRectContainsPoint(textRect, p)) {
        return NSNotFound;
    }
    
    // Adjust pen offset for flush depending on text alignment
    CGFloat flushFactor = TTTFlushFactorForTextAlignment(self.textAlignment);
    
    // Offset tap coordinates by textRect origin to make them relative to the origin of frame
    p = CGPointMake(p.x - textRect.origin.x, p.y - textRect.origin.y);
    // Convert tap coordinates (start at top left) to CT coordinates (start at bottom left)
    p = CGPointMake(p.x, textRect.size.height - p.y);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, textRect);
    CTFrameRef frame = CTFramesetterCreateFrame(_framesetter, CFRangeMake(0, (CFIndex)[self.attributedText length]), path, NULL);
    if (frame == NULL) {
        CFRelease(path);
        return NSNotFound;
    }
    
    CFArrayRef lines = CTFrameGetLines(frame);
    NSInteger numberOfLines = self.numberOfLines > 0 ? MIN(self.numberOfLines, CFArrayGetCount(lines)) : CFArrayGetCount(lines);
    if (numberOfLines == 0) {
        CFRelease(frame);
        CFRelease(path);
        return NSNotFound;
    }
    
    CFIndex idx = NSNotFound;
    
    CGPoint lineOrigins[numberOfLines];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, numberOfLines), lineOrigins);
    
    for (CFIndex lineIndex = 0; lineIndex < numberOfLines; lineIndex++) {
        CGPoint lineOrigin = lineOrigins[lineIndex];
        CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);
        CGFloat penOffset = (CGFloat)CTLineGetPenOffsetForFlush(line, flushFactor, textRect.size.width);
        
        // Get bounding information of line
        CGFloat ascent = 0.0f, descent = 0.0f, leading = 0.0f;
        CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        CGFloat yMin = (CGFloat)floor(lineOrigin.y - descent);
        CGFloat yMax = (CGFloat)ceil(lineOrigin.y + ascent);
        
        // Check if we've already passed the line
        if (p.y > yMax) {
            break;
        }
        // Check if the point is within this line vertically
        if (p.y >= yMin) {
            // Check if the point is within this line horizontally
            if (p.x >= penOffset && p.x <= penOffset + width) {
                // Convert CT coordinates to line-relative coordinates
                CGPoint relativePoint = CGPointMake(p.x - penOffset, p.y - lineOrigin.y);
                idx = CTLineGetStringIndexForPosition(line, relativePoint);
                break;
            }
        }
    }
    
    CFRelease(frame);
    CFRelease(path);
    
    return idx;
}

#pragma mark - touches

- (void)tapInLabel:(UITapGestureRecognizer *)gestureRecognizer
{
    self.activeLink = [self linkAtPoint:[gestureRecognizer locationInView:self]];
    
    if (self.activeLink) {
        NSTextCheckingResult *result = self.activeLink;
        self.activeLink = nil;
        
        switch (result.resultType) {
            case NSTextCheckingTypeLink:
                if ([self.delegate respondsToSelector:@selector(messageLabel:didSelectLinkWithUrl:)]) {
                    [self.delegate messageLabel:self didSelectLinkWithUrl:result.URL];
                    return;
                }
                break;
            default:
                break;
        }
    }
}

@end
