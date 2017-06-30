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
typedef void (^XFAudioRecognizerCallback)(NSString *resText);
@interface XFSingleton : NSObject

@property(nonatomic, strong) IFlySpeechSynthesizer *iFlySpeechSynthesizer;    // 定义语音合成对象
@property(nonatomic, strong) IFlySpeechEvaluator *iFlySpeechEvaluator;        // 定义语音测评对象
@property(nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;      // 定义语音听写对象

@property(nonatomic, copy) XFAudioEvaCallback xf_evacallback;
@property(nonatomic, copy) XFAudioSynCallback xf_syncallback;
@property(nonatomic, copy) XFAudioRecognizerCallback xf_recogcallback;

+ (instancetype)Ins;

+ (void)xf_AudioInitWithAppID: (NSString *)appid;
// 语音合成
+ (void)xf_AudioSynthesizeOfText: (NSString *)text fromPeople:(NSString *)people;
+ (void)xf_AudioSynthesizeOfText: (NSString *)text;
// 语音测评
+ (void)xf_AudioEvaluationOfText: (NSString *)text callback:(void(^)(CGFloat score))callback;
// 语音听写
+ (void)xf_AudioRecognizerResult: (void(^)(NSString *resText))callback;

@end
