//
//  XFSingleton.m
//  XFDemo
//
//  Created by Xinhou Jiang on 28/3/17.
//  Copyright © 2017年 Xinhou Jiang. All rights reserved.
//

#import "XFSingleton.h"


@interface XFSingleton()<IFlySpeechSynthesizerDelegate,IFlySpeechEvaluatorDelegate,IFlySpeechRecognizerDelegate>
@property(nonatomic, copy) NSString *people;
@end
@implementation XFSingleton

+ (instancetype)Ins {
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)xf_AudioInitWithAppID:(NSString *)appid {
    // 初始化讯飞应用
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"587f6174"];
    [IFlySpeechUtility createUtility:initString];
}

+ (void)xf_AudioSynthesizeOfText:(NSString *)text {
    // 1.开始合成说话
    [[XFSingleton Ins].iFlySpeechSynthesizer startSpeaking:text];
}
+ (void)xf_AudioSynthesizeOfText:(NSString *)text fromPeople:(NSString *)people {
    [[XFSingleton Ins] setPeople:people];
    [XFSingleton xf_AudioSynthesizeOfText:text];
}

+ (void)xf_AudioEvaluationOfText:(NSString *)text callback:(void (^)(CGFloat))callback {
    // 2.开始语音测评
    NSData *textData = [text dataUsingEncoding:NSUTF8StringEncoding];
    [[XFSingleton Ins].iFlySpeechEvaluator startListening:textData params:nil];
    
    [XFSingleton Ins].xf_evacallback = callback;
}

+ (void)xf_AudioRecognizerResult:(void (^)(NSString *))callback {
    // 3.开始语音听写
    [[XFSingleton Ins].iFlySpeechRecognizer startListening];
    [XFSingleton Ins].xf_recogcallback = callback;
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
        // 语速【0-100】
        [_iFlySpeechSynthesizer setParameter:@"50" forKey:[IFlySpeechConstant SPEED]];
        // 音量【0-100】
        [_iFlySpeechSynthesizer setParameter:@"50" forKey:[IFlySpeechConstant VOLUME]];
        // 发音人【小燕：xiaoyan；小宇：xiaoyu；凯瑟琳：catherine；亨利：henry；玛丽：vimary；小研：vixy；小琪：vixq；小峰：vixf；小梅：vixl；小莉：vixq；小蓉(四川话)：vixr；小芸：vixyun；小坤：vixk；小强：vixqa；小莹：vixying；小新：vixx；楠楠：vinn；老孙：vils】
        if (!_people) {
            _people = @"xiaoyan";
        }
        [_iFlySpeechSynthesizer setParameter:_people forKey:[IFlySpeechConstant VOICE_NAME]];
        // 音频采样率【8000或16000】
        [_iFlySpeechSynthesizer setParameter:@"8000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
        // 保存音频路径(默认在Document目录下)
        [_iFlySpeechSynthesizer setParameter:@"tts.pcm" forKey:[IFlySpeechConstant TTS_AUDIO_PATH]];
    }
    return _iFlySpeechSynthesizer;
}

/**
 * 设置发音人
 */
- (void)setPeople:(NSString *)people {
    _people = people;
    _iFlySpeechSynthesizer = nil;
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
 * 合成缓冲进度【0-100】
 */
- (void)onBufferProgress:(int)progress message:(NSString *)msg {
    NSLog(@"合成缓冲进度：%d/100",progress);
}

/**
 * 合成播放进度【0-100】
 */
- (void)onSpeakProgress:(int)progress beginPos:(int)beginPos endPos:(int)endPos {
    NSLog(@"合成播放进度：%d/100",progress);
}

#pragma -mark 语音测评
/**
 * 懒加载getter方法
 */
- (IFlySpeechEvaluator *)iFlySpeechEvaluator {
    if (!_iFlySpeechEvaluator) {
        // 初始化语音测评
        _iFlySpeechEvaluator = [IFlySpeechEvaluator sharedInstance];
        _iFlySpeechEvaluator.delegate = self;
        // 设置测评语种【中文：zh_cn，中文台湾：zh_tw，美英：en_us】
        [_iFlySpeechEvaluator setParameter:@"en_us" forKey:[IFlySpeechConstant LANGUAGE]];
        // 设置测评题型【read_syllable(英文评测不支持):单字;read_word:词语;read_sentence:句子;read_chapter(待开放):篇章】
        [_iFlySpeechEvaluator setParameter:@"read_sentence" forKey:[IFlySpeechConstant ISE_CATEGORY]];
        // 设置试题编码类型
        [_iFlySpeechEvaluator setParameter:@"utf-8" forKey:[IFlySpeechConstant TEXT_ENCODING]];
        // 设置前、后端点超时【0-10000(单位ms)】
        [_iFlySpeechEvaluator setParameter:@"10000" forKey:[IFlySpeechConstant VAD_BOS]]; // 默认5000ms
        [_iFlySpeechEvaluator setParameter:@"1000" forKey:[IFlySpeechConstant VAD_EOS]]; // 默认1800ms
        // 设置录音超时，设置成-1则无超时限制(单位：ms，默认30000)
        [_iFlySpeechEvaluator setParameter:@"5000" forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        // 设置结果等级，不同等级对应不同的详细程度【complete：完整 ；plain：简单】
        [_iFlySpeechEvaluator setParameter:@"" forKey:[IFlySpeechConstant ISE_RESULT_LEVEL]];
    }
    return _iFlySpeechEvaluator;
}

/**
 * 音量变化回调
 */
- (void)onVolumeChanged:(int)volume buffer:(NSData *)buffer {
    NSLog(@"音量变化...");
}

/**
 * 取消
 */
- (void)onCancel {
    NSLog(@"正在取消...");
}

#pragma -mark 语音听写

- (IFlySpeechRecognizer *)iFlySpeechRecognizer {
    if (!_iFlySpeechRecognizer) {
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        _iFlySpeechRecognizer.delegate = self;
        // 设置听写模式
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        // 设置录音保存文件名
        [_iFlySpeechRecognizer setParameter:@"asrview.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    }
    return _iFlySpeechRecognizer;
}
/**
 *音量回调函数 volume 0-30
 */
- (void) onVolumeChanged: (int)volume {
    NSLog(@"Volume:%d",volume);
}


#pragma -mark 语音测评和听写回调
/**
 * 开始说话回调
 */
- (void)onBeginOfSpeech {
    NSLog(@"开始说话...");
}

/**
 * 说话结束回调
 */
- (void)onEndOfSpeech {
    NSLog(@"说话结束...");
}

/**
 * 测评结果
 */
- (void)onResults:(NSData *)results isLast:(BOOL)isLast {
    NSLog(@"测评结果:%@",results);
}

/**
 * 出错回调
 */
- (void)onError:(IFlySpeechError *)errorCode {
    NSLog(@"语音测评出错:%@",errorCode);
}

@end
