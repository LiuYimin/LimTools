//
//  ViewController.m
//  LimToolsOC
//
//  Created by Liu on 07/04/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "ViewController.h"
#import "BannerView.h"
#import "RotationImageView.h"
#import "Tools.h"
#import "VideoView.h"
#import "ACScoreView.h"
#import "YLAlbumVC.h"

#import "AC_RotationCtrlBarView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *tmpVideoV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    _tmpVideoV.hidden = YES;
    VideoView *vpv = [[VideoView alloc] initWithFrame:CGRectMake(20, 80, 240, 120)];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"testVideo" ofType:@"mp4"];
    vpv.playUrl = [NSURL URLWithString:@"http://wvideo.spriteapp.cn/video/2016/1203/58425ad2a0c1d_wpd.mp4"];//[NSURL fileURLWithPath:path];
    [self.view addSubview:vpv];
    
    
    UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
    butt.frame = CGRectMake(20, 280, 90, 40);
    [butt addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    butt.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:butt];
    
//    RotationImageView * rIv = [[RotationImageView alloc] initWithFrame:CGRectMake(10, 80, self.view.bounds.size.width - 20, 150)];
//    [self.view addSubview:rIv];
//    NSArray *imgs = @[@"IMG_2586.JPG", @"IMG_2591.JPG", @"IMG_2602.JPG"];
//    [rIv configImgs:imgs];
//    rIv.tapCallBack = ^(NSUInteger index) {
//        NSLog(@"点击了第 %lu 张", index);
//    };
//    rIv.autoScroll = YES;
//    rIv.cycleScroll = YES;
    
//    BannerView *bannerView = [[BannerView alloc] initWithFrame:CGRectMake(10, 80, self.view.bounds.size.width - 20, 180)];
//    [self.view addSubview:bannerView];
//    bannerView.images = @[@"IMG_2586.JPG", @"IMG_2591.JPG", @"IMG_2602.JPG"];
//    
//    AC_RotationCtrlBarView *acv = [[AC_RotationCtrlBarView alloc] initWithFrame:CGRectMake(10, 270, self.view.bounds.size.width - 20, 20)];
//    [self.view addSubview:acv];
//    acv.num = 4;
//    acv.backgroundColor = [UIColor blackColor];
//    
//    bannerView.tapCallBack = ^(NSUInteger index) {
//        acv.curr = index;
//    };
    
//    QRView * _qrCodeView = [[QRView alloc] initWithQRString:@"fjlskfjslkfjlsd"];
//    _qrCodeView.frame = CGRectMake(40, 120, 200, 200);
//    [self.view addSubview:_qrCodeView];
    
//    for (UIView *v in self.view.subviews) {
//        [v removeFromSuperview];
//    }
//    
//    LMVoiceView *lmv = [[LMVoiceView alloc] initWithFrame:CGRectMake(100, 200, 80, 80)];
//    [self.view addSubview:lmv];
    
//    self.view.backgroundColor = [UIColor lightGrayColor];
//    
//    
//    
//    ScoreView *sv = [ScoreView scoreViewWithFrame:CGRectMake(50, 100, 100, 20)];
//    sv.score = 3;
//    [self.view addSubview:sv];
    
//    UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
//    butt.frame = CGRectMake(100, 100, 80, 40);
//    butt.backgroundColor = [UIColor orangeColor];
//    [butt addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:butt];
//    // Do any additional setup after loading the view, typically from a nib.
}

- (void)nextAction
{
//    ViewController *v = [[ViewController alloc] init];
    ViewController *v = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    [self.navigationController pushViewController:v animated:YES];
}

- (void)testAction
{
    ACScoreView *acv = [[[NSBundle mainBundle] loadNibNamed:@"ACScoreView" owner:nil options:nil] lastObject];
    acv.frame = self.view.bounds;
    [self.view addSubview:acv];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    YLAlbumVC *alvc = [[YLAlbumVC alloc] init];//[[[NSBundle mainBundle] loadNibNamed:@"YLAlbumVC" owner:nil options:nil] lastObject];
//    [self presentViewController:alvc animated:YES completion:nil];
    
    
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
    
//    [YLSexTip showSexTipcallBack:^(BOOL male) {
//        NSLog(@"%@", male?@"男":@"女");
//    }];
    
//    [YLImageSelectTip showImageSelectCallBack:^(NSUInteger index) {
//        
//    }];
    
//    [YLTip showTipOnWindowTitle:@"提示" image:@"" callBack:^(BOOL cer) {
//        
//    }];
}

@end
