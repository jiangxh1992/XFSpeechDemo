//
//  ViewController.m
//  XFDemo
//
//  Created by Xinhou Jiang on 4/3/17.
//  Copyright © 2017年 Xinhou Jiang. All rights reserved.
//

#import "ViewController.h"
#import "XFSingleton.h"
@interface ViewController ()
@property (nonatomic, strong) IBOutlet UITextField *text;
@property (nonatomic, strong) IBOutlet UIButton *btnSynthesize;
@property (nonatomic, strong) IBOutlet UIButton *btnEvaluate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [XFSingleton xf_AudioInit];
}

- (IBAction)syn:(id)sender {
    [XFSingleton xf_AudioSynthesizeOfText:_text.text];
}
- (IBAction)eva:(id)sender {
    [XFSingleton xf_AudioEvaluationOfText:_text.text callback:^(CGFloat score) {
        _text.text = [NSString stringWithFormat:@"%f", score];
    }];
}

@end
