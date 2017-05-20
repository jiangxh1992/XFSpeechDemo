//
//  XFSingleton.h
//  XFDemo
//
//  Created by Xinhou Jiang on 28/3/17.
//  Copyright © 2017年 Xinhou Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iflyMSC/iflyMSC.h> // 引入讯飞语音库
typedef void (^XFAudioSynCallback)(NSInteger res);
typedef void (^XFAudioEvaCallback)(CGFloat score);
@interface XFSingleton : NSObject

@property(nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;    // 定义语音合成对象
@property(nonatomic, strong) IFlySpeechEvaluator *iFlySpeechEvaluator;        // 定义语音测评对象

@property(nonatomic, copy) XFAudioEvaCallback xf_evacallback;
@property(nonatomic, copy) XFAudioSynCallback xf_syncallback;

+ (instancetype)Ins;

+ (void)xf_AudioInitWithAppID: (NSString *)appid;
+ (void)xf_AudioSynthesizeOfText: (NSString *)text fromPeople:(NSString *)people;
+ (void)xf_AudioSynthesizeOfText: (NSString *)text;
+ (void)xf_AudioEvaluationOfText: (NSString *)text callback:(void(^)(CGFloat score))callback;

@end
