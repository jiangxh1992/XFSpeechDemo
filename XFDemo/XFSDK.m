//
//  XFSDK.m
//  XFAudioSDK
//
//  Created by Xinhou Jiang on 28/3/17.
//  Copyright © 2017年 Xinhou Jiang. All rights reserved.
//

#import "XFSDK.h"

@implementation XFSDK

+ (void)xf_AudioInitWithAppID:(NSString *)appid {
    [XFSingleton xf_AudioInitWithAppID:appid];
}
+ (void)xf_AudioSynthesizeOfText:(NSString *)text {
    [XFSingleton xf_AudioSynthesizeOfText:text];
}
+ (void)xf_AudioSynthesizeOfText: (NSString *)text fromPeople:(NSString *)people{
    [XFSingleton xf_AudioSynthesizeOfText:text fromPeople:people];
}
+ (void)xf_AudioEvaluationOfText:(NSString *)text callback:(void (^)(CGFloat))callback {
    [XFSingleton xf_AudioEvaluationOfText:text callback:callback];
}
+ (void)xf_AudioRecognizerResult:(void (^)(NSString *))callback {
    [XFSingleton xf_AudioRecognizerResult:callback];
}
@end
