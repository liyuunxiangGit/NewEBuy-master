//
//  ISRDataHander.m
//  MSC
//
//  Created by ypzhao on 12-11-19.
//  Copyright (c) 2012年 iflytek. All rights reserved.
//

#import "ISRDataHelper.h"
#import "SBJson4.h"

static ISRDataHelper *ISRdataHander = nil;
@implementation ISRDataHelper

+ (id) shareInstance
{
    if (!ISRdataHander) {
        ISRdataHander = [[ISRDataHelper alloc] init];
    }
    return ISRdataHander;
}

// 解析命令词返回的结果
- (NSString*) getResultFormAsr:(NSString*)params
{
    NSMutableString * resultString = [[NSMutableString alloc]init];
    NSString *inputString = nil;
    
	NSArray *array = [params componentsSeparatedByString:@"\n"];

	for (int  index = 0; index < array.count; index++)
	{
        NSRange range;
		NSString *line = [array objectAtIndex:index];
		
		NSRange idRange = [line rangeOfString:@"id="];
        NSRange nameRange = [line rangeOfString:@"name="];
		NSRange confidenceRange = [line rangeOfString:@"confidence="];
		NSRange grammarRange = [line rangeOfString:@" grammar="];
        
        NSRange inputRange = [line rangeOfString:@"input="];
        
		if (confidenceRange.length == 0 || grammarRange.length == 0 || inputRange.length == 0 )
		{
			continue;
		}
        
        //check nomatch
        if (idRange.length!=0) {
            NSUInteger idPosX = idRange.location + idRange.length;
            NSUInteger idLength = nameRange.location - idPosX;
            range = NSMakeRange(idPosX,idLength);
            NSString *idValue = [[line substringWithRange:range]
                                 stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet] ];
            if ([idValue isEqualToString:@"nomatch"]) {
                return @"";
            }
        }
		
        //Get Confidence Value
        NSUInteger confidencePosX = confidenceRange.location + confidenceRange.length;
        NSUInteger confidenceLength = grammarRange.location - confidencePosX;
        range = NSMakeRange(confidencePosX,confidenceLength);
        
        
        NSString *score = [line substringWithRange:range];
        
        NSUInteger inputStringPosX = inputRange.location + inputRange.length;
        NSUInteger inputStringLength = line.length - inputStringPosX;
        
        range = NSMakeRange(inputStringPosX , inputStringLength);
        inputString = [line substringWithRange:range];

        [resultString appendFormat:@"%@ %@%@\n",inputString, L(@"Search_Confidence"),score];
	}
	
    return resultString;

}

/**
 解析听写json格式的数据
 params例如：
 {"sn":1,"ls":true,"bg":0,"ed":0,"ws":[{"bg":0,"cw":[{"w":"白日","sc":0}]},{"bg":0,"cw":[{"w":"依山","sc":0}]},{"bg":0,"cw":[{"w":"尽","sc":0}]},{"bg":0,"cw":[{"w":"黄河入海流","sc":0}]},{"bg":0,"cw":[{"w":"。","sc":0}]}]}
 */
-(NSString *) getResultFromJson:(NSString*)params
{
    if (params == NULL) {
        return nil;
    }
    NSMutableString *tempStr = [[NSMutableString alloc] init];

    //返回的格式必须为utf8的,否则发生未知错误
    NSString *jsonString = params;
    
    id block = ^(id obj, BOOL *ignored) {
        NSDictionary *dic = obj;
        
        NSArray *wordArray = [dic objectForKey:@"ws"];
        
        for (int i = 0; i < [wordArray count]; i++) {
            NSDictionary *wsDic = [wordArray objectAtIndex: i];
            NSArray *cwArray = [wsDic objectForKey:@"cw"];
            
            for (int j = 0; j < [cwArray count]; j++) {
                NSDictionary *wDic = [cwArray objectAtIndex:j];
                NSString *str = [wDic objectForKey:@"w"];
                [tempStr appendString: str];
            }
        }

    };
    
    id eh = ^(NSError *err) {
        NSLog(@"json parser error");
        //        self.output.string = err.description;
    };
    id parser = [SBJson4Parser parserWithBlock:block allowMultiRoot:NO unwrapRootArray:NO errorHandler:eh];
    [parser parse:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
   
    return tempStr;
}

/**
 解析语法识别返回的结果
 */
-(NSString *) getResultFromABNFJson:(NSString*)params
{
    if (params == NULL) {
        return nil;
    }
    NSMutableString *tempStr = [[NSMutableString alloc] init];
    
    //返回的格式必须为utf8的,否则发生未知错误
    NSString *jsonString = params;
    
    id block = ^(id obj, BOOL *ignored) {
        NSDictionary *dic = obj;
        
        NSArray *wordArray = [dic objectForKey:@"ws"];
        
        for (int i = 0; i < [wordArray count]; i++) {
            NSDictionary *wsDic = [wordArray objectAtIndex: i];
            NSArray *cwArray = [wsDic objectForKey:@"cw"];
            
            for (int j = 0; j < [cwArray count]; j++) {
                NSDictionary *wDic = [cwArray objectAtIndex:j];
                NSString *str = [wDic objectForKey:@"w"];
                NSString *score = [wDic objectForKey:@"sc"];
                [tempStr appendString: str];
                [tempStr appendFormat:@" %@:%@",L(@"Search_Confidence"),score];
                [tempStr appendString: @"\n"];
            }
        }
        
    };
    
    id eh = ^(NSError *err) {
        NSLog(@"json parser error");
        //        self.output.string = err.description;
    };
    
    id parser = [SBJson4Parser parserWithBlock:block allowMultiRoot:NO unwrapRootArray:NO errorHandler:eh];
    [parser parse:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    return tempStr;
}
@end
