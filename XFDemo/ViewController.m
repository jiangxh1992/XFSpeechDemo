//
//  ViewController.m
//  XFDemo
//
//  Created by Xinhou Jiang on 4/3/17.
//  Copyright © 2017年 Xinhou Jiang. All rights reserved.
//

#import "ViewController.h"
#import <iflyMSC/iflyMSC.h> // 引入讯飞语音库

@interface ViewController ()<IFlySpeechSynthesizerDelegate> { // 语音合成协代理议
    
}
@property (nonatomic, strong)IFlySpeechSynthesizer *iFlySpeechSynthesizer; // 定义语音合成对象

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 开始合成说话
    [self.iFlySpeechSynthesizer startSpeaking:@"Hello, this is xiaoyan!"];
}

#pragma -mark 语音合成
/**
 * 懒加载getter方法
 */
- (IFlySpeechSynthesizer *)iFlySpeechSynthesizer {
    if(!_iFlySpeechSynthesizer) {
    // 初始化语音合成
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    _iFlySpeechSynthesizer.delegate = self;
    // 语速0-100
    [_iFlySpeechSynthesizer setParameter:@"50" forKey:[IFlySpeechConstant SPEED]];
    // 音量0-100
    [_iFlySpeechSynthesizer setParameter:@"50" forKey:[IFlySpeechConstant VOLUME]];
    // 发音人(小燕)
    [_iFlySpeechSynthesizer setParameter:@"xiaoyan" forKey:[IFlySpeechConstant VOICE_NAME]];
    // 音频采样率8000、16000
    [_iFlySpeechSynthesizer setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
    // 保存音频路径(默认在Document目录下)
    [_iFlySpeechSynthesizer setParameter:@"tts.pcm" forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
    }
    return _iFlySpeechSynthesizer;
}

/**
 * 合成结束
 */
- (void)onCompleted:(IFlySpeechError *)error {
    NSLog(@"合成结束！");
}

/**
 * 合成开始
 */
- (void)onSpeakBegin {
    NSLog(@"合成开始！");
}

/**
 * 合成缓冲进度
 */
- (void)onBufferProgress:(int)progress message:(NSString *)msg {
    NSLog(@"合唱缓冲进度...");
}

/**
 * 合成播放进度
 */
- (void)onSpeakProgress:(int)progress beginPos:(int)beginPos endPos:(int)endPos {
    NSLog(@"合成播放进度...");
}


@end
