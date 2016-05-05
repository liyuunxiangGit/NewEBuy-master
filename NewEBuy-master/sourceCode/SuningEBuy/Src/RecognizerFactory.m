//
//  RecognizerFactory.m
//  MSCDemo
//
//  Created by iflytek on 13-6-9.
//  Copyright (c) 2013年 iflytek. All rights reserved.
//

#import "RecognizerFactory.h"

#import "iflyMSC/IFlySpeechRecognizer.h"
#import "iflyMSC/IFlySpeechConstant.h"

@implementation RecognizerFactory

/**
 创建识别对象
 domain:识别的服务类型
        iat,search,video,poi,music,asr;iat,普通文本听写; search,热词搜索;video,视频音乐搜索;asr: 关键词识别
*/
+(id) CreateRecognizer:(id)delegate Domain:(NSString*) domain
{
    IFlySpeechRecognizer * iflySpeechRecognizer = nil;
    
    // 创建识别对象
    iflySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    
    //请不要删除这句,createRecognizer是单例方法，需要重新设置代理
    iflySpeechRecognizer.delegate = delegate;
    
    [iflySpeechRecognizer setParameter:domain forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    
    //设置采样率
//    [iflySpeechRecognizer setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
    
    //设置录音保存文件
//    [iflySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    
    //设置返回结果的数据格式，可设置为json，xml，plain，默认为json。
    [iflySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
    
    return iflySpeechRecognizer;
}
@end
