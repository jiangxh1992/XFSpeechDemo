//
//  XF.cpp
//  XFAudioSDK
//
//  Created by Xinhou Jiang on 8/4/17.
//  Copyright © 2017年 Xinhou Jiang. All rights reserved.
//

#import "XFSDK.h"

extern "C" void Speak(const char *people, const char *content) {
    [XFSDK xf_AudioSynthesizeOfText:[NSString stringWithUTF8String:content] fromPeople:[NSString stringWithUTF8String:people]];
}

extern "C" void State(const char *content) {
    [XFSDK xf_AudioSynthesizeOfText:[NSString stringWithUTF8String:content]];
}
