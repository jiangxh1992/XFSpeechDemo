//
//  XFSDK.h
//  XFAudioSDK
//
//  Created by Xinhou Jiang on 28/3/17.
//  Copyright © 2017年 Xinhou Jiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XFSingleton.h"
@interface XFSDK : NSObject
/* 初始化 */
+ (void)xf_AudioInitWithAppID: (NSString *)appid;
/* 语音合成 */
+ (void)xf_AudioSynthesizeOfText: (NSString *)text fromPeople:(NSString *)people;
+ (void)xf_AudioSynthesizeOfText: (NSString *)text;
/* 语音测评 */
+ (void)xf_AudioEvaluationOfText: (NSString *)text callback:(void(^)(CGFloat score))callback;
/* 语音听写 */
+ (void)xf_AudioRecognizerResult: (void(^)(NSString *resText))callback;
@end
