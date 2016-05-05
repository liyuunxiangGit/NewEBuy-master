//
//  PasswdUtil.h
//  SubookDRM
//
//  Created by wangrui on 8/25/12.
//  Copyright (c) 2012 suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

// PBEWITHMD5andDES算法默认盐，长度为8个字节，数据可配置，
// 需要和服务端保持一致
#define kPBEDefaultSalt     @"sn201209"


@interface PasswdUtil : NSObject

/*!
 * @abstract
 * 给指定的密码进行加密，采用的是PBEWITHMD5andDES算法
 *
 * @discussion
 * PBEWITHMD5andDES是一种基于口令的加密算法，口令和盐需要事先和服务端约定，经过多重摘要后生成密钥
 *
 * @param data
 * 待加密的明文密码
 *
 * @param userID
 * 待登录的用户名，这里作为用户口令
 *
 * @result
 * 加密后的密文(十六进制字符串)
 */
+ (NSString *)encryptData:(NSData *)data forUser:(NSString *)userID;

//刘坤添加，可设盐的
+ (NSString *)encryptString:(NSString *)string forKey:(NSString *)key salt:(NSString *)salt;

/*!
 * @abstract
 * 将加密后的密码进行解密，采用的是PBEWITHMD5andDES算法
 *
 * @discussion
 * PBEWITHMD5andDES是一种基于口令的加密算法，口令和盐需要事先和服务端约定，经过多重摘要后生成密钥
 *
 * @param data
 * 经过加密后的密文
 *
 * @param userID
 * 待登录的用户名，这里作为用户口令
 *
 * @result
 * 解密后的密码明文
 */
+ (NSString *)decryptData:(NSData *)data forUser:(NSString *)userID;

//解密string, 可设盐的
+ (NSString *)decryptString:(NSString *)string forKey:(NSString *)key salt:(NSString *)salt;



+ (NSData *)runCryptor:(CCCryptorRef)cryptor withData:(NSData *)data;
+ (NSData *)encryptPBEData:(NSData *)data usingPwd:(NSString *)pwd withSalt:(NSString *)salt;
+ (NSData *)decryptedDataUsingAlgorithm:(CCAlgorithm)algorithm
                                   data:(NSData *)data
                                    key:(id)key		// data or string
                   initializationVector:(id)iv		// data or string
                                options:(CCOptions)options;
+ (NSData *)encryptedUsingAlgorithm:(CCAlgorithm)algorithm
                               data:(NSData *)data
                                key:(id)key
               initializationVector:(id)iv
                            options:(CCOptions)options;
+ (NSData *)decryptPBEData:(NSData *)data usingPwd:(NSString *)pwd withSalt:(NSString *)salt;
+ (NSString *)hexStringForData:(NSData *)data;
+ (NSData *)dataForHexString:(NSString *)hexString;
@end
