//
//  XF.cpp
//  XFAudioSDK
//
//  Created by Xinhou Jiang on 8/4/17.
//  Copyright © 2017年 Xinhou Jiang. All rights reserved.
//

#import "XFSDK.h"

/* 指定人发音 */
extern "C" void Speak(const char *people, const char *content) {
    [XFSDK xf_AudioSynthesizeOfText:[NSString stringWithUTF8String:content] fromPeople:[NSString stringWithUTF8String:people]];
}
/* 默认人发音 */
extern "C" void State(const char *content) {
    [XFSDK xf_AudioSynthesizeOfText:[NSString stringWithUTF8String:content]];
}

typedef void (*cback) (const char *c);
extern "C" void AudioRecognizerResult(cback callback) {
    [XFSDK xf_AudioRecognizerResult:^(NSString *resText) {
        callback([resText UTF8String]);
    }];
}
