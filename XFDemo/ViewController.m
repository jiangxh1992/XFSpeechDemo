//
//  ViewController.m
//  XFDemo
//
//  Created by Xinhou Jiang on 4/3/17.
//  Copyright © 2017年 Xinhou Jiang. All rights reserved.
//

#import "ViewController.h"
#import "XFSDK.h"
@interface ViewController ()
@property (nonatomic, strong) IBOutlet UITextField *text;
@property (nonatomic, strong) IBOutlet UIButton *btnSynthesize;
@property (nonatomic, strong) IBOutlet UIButton *btnEvaluate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [XFSDK xf_AudioInitWithAppID:@""];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_text resignFirstResponder];
}

- (IBAction)syn:(id)sender {
    [XFSDK xf_AudioSynthesizeOfText:_text.text fromPeople:@"xiaoyu"];
}
- (IBAction)eva:(id)sender {
    [XFSDK xf_AudioRecognizerResult:^(NSString *resText) {
        _text.text = resText;
    }];
}

@end
