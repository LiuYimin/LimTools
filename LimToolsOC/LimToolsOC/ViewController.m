//
//  ViewController.m
//  LimToolsOC
//
//  Created by Liu on 07/04/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "ViewController.h"
#import "Tools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    QRView * _qrCodeView = [[QRView alloc] initWithQRString:@"fjlskfjslkfjlsd"];
//    _qrCodeView.frame = CGRectMake(40, 120, 200, 200);
//    [self.view addSubview:_qrCodeView];
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    
    ScoreView *sv = [ScoreView scoreViewWithFrame:CGRectMake(50, 100, 100, 20)];
    sv.score = 3;
    [self.view addSubview:sv];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//     [YLTip showTipOnWindowTitle:@"您现在上班吗?" image:@"" callBack:^(BOOL cer) {
//         if (cer) {
//             NSLog(@"YES");
//         }
//     }];
    
//    [YLSelectView showTipOnView:self.view contents:nil callBack:^(NSInteger index) {
//        NSLog(@"点击了第%ld行", index);
//    }];
    
//    [YLSelectTimeView showTimeViewCallBack:^(BOOL cer, NSInteger time) {
//        NSLog(@"%@, time = %ld", cer?@"OK":@"Cancel", time);
//    }];
    
//    [YLPasswordTip showTipOnWindowTitle:@"解放路开始就发了可是的积分流口水的解放路开始搭建法律手段加福禄寿" callBack:^(BOOL cer, NSString *psd) {
//        NSLog(@"%@", psd);
//    }];
    
    [YLSexTip showSexTipcallBack:^(BOOL male) {
        NSLog(@"%@", male?@"男":@"女");
    }];
}

@end
