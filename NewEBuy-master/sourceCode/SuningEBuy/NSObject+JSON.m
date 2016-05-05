//
//  NSObject+JSON.m
//  SuningEBuy
//
//  Created by liukun on 14-5-5.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NSObject+JSON.h"
#import <SBJsonWriter.h>
#import <SBJsonParser.h>

@implementation NSObject (JSON)

- (NSString *)JSONRepresentation {
    
    if ( [NSJSONSerialization isValidJSONObject:self] )
    {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                        options:0
                                          error:&error];
        if (error)
        {
            SNLogError(@"-JSONRepresentation failed. Error is : %@", error);
            return nil;
        }
        else
        {
            return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
    }
    else
    {
        SNLogError(@"-JSONRepresentation failed. Invalid json object : %@", self);
        return nil;
    }
}

@end

#pragma mark ----------------------------- json parser

@implementation NSString (JSON)

- (id)JSONValue2
{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    if (0) {
        NSError *error = nil;
        id obj = [NSJSONSerialization JSONObjectWithData:jsonData
                                                 options:0
                                                   error:&error];
        if (error)
        {
            SNLogError(@"-JSONValue failed. Error is: %@", error);
            
            //当解析失败去掉可能的非法字符, 为适配部分接口问题，ebuy特有逻辑，勿删
            if ([self length])
            {
                NSString *string = [self stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@"    "];
                string = [string stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
                string = [string stringByReplacingOccurrencesOfString:@"" withString:@"_"];
                jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
                
                obj = [NSJSONSerialization JSONObjectWithData:jsonData
                                                      options:0
                                                        error:&error];
            }
        }
        
        return obj;
    } else {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        id repr = [parser objectWithString:self];
        if (!repr)
        {
            SNLogError(@"-JSONValue failed. Error is: %@", parser.error);
            
            //当解析失败去掉可能的非法字符, 为适配部分接口问题，ebuy特有逻辑，勿删
            if ([self length])
            {
                NSString *string = [self stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                string = [string stringByReplacingOccurrencesOfString:@"\t" withString:@"    "];
                string = [string stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
                string = [string stringByReplacingOccurrencesOfString:@"" withString:@"_"];
                jsonData = [string dataUsingEncoding:NSUTF8StringEncoding];
                
                repr = [parser objectWithString:string];
            }
        }
        
        return repr;
    }
}

@end

@implementation NSData (JSON)

- (id)JSONValue2 {
    
    if (0) {
        
        NSError *error = nil;
        id obj = [NSJSONSerialization JSONObjectWithData:self
                                                 options:0
                                                   error:&error];
        if (error)
        {
            SNLogError(@"-JSONValue failed. Error is: %@", error);
        }
        
        return obj;
        
    } else {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        id repr = [parser objectWithData:self];
        if (!repr)
        {
            SNLogError(@"-JSONValue failed. Error is: %@", parser.error);
        }
        
        return repr;
    }
}

@end