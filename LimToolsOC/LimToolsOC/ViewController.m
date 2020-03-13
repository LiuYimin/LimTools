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
#import "InitViewController.h"

#import "AC_RotationCtrlBarView.h"

#import "BarrageManager.h"

#import "LTDatePicker.h"

#import "LMAddImageShower.h"
#import "LMAddImagePresentTransition.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>
{
    BarrageManager *manager;
    UISwitch *_switchBtn;
    LMAddImagePresentTransition * _presentAnimator;
    LMAddImagePresentTransition * _dismissAnimator;
}
@property (weak, nonatomic) IBOutlet UIView *tmpVideoV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LMStringHandler *handler = [LMStringHandler new];
    NSString *txt1 = @"0test1国家";
    NSString *txt2 = @"01123j哈哈";
    BOOL ret = [handler compareString:txt1 compare:txt2];
    NSLog(@"%@ %@ %@", txt1, ret?@"大于":@"小于", txt2);
    return;
    
//    _presentAnimator = [[LMAddImagePresentTransition alloc] init];
//    _dismissAnimator = [[LMAddImagePresentTransition alloc] init];
//    _presentAnimator.isPresent = YES;
//
//    self.transitioningDelegate = self;
//
//
//    self.view.backgroundColor = [UIColor whiteColor];
//
//    _switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(100, 200, 90, 40)];
//    [self.view addSubview:_switchBtn];
//    _switchBtn.tintColor = [UIColor orangeColor];
//    [_switchBtn addTarget:self action:@selector(onChanged:) forControlEvents:UIControlEventValueChanged];
    
//    InitViewController *ivc = [[InitViewController alloc] init];
//    [self presentViewController:ivc animated:YES completion:nil];
    
//    for (int i = 0; i < arc4random()%3+1; i++) {
//        NSLog(@"123");
//        NSLog(@"i = %ld", i);
//    }
    
//    NSString *setr = @"AAAA";
//    NSNumber *bbNu = @123;
    
    
//    _tmpVideoV.hidden = YES;
//    VideoView *vpv = [[VideoView alloc] initWithFrame:CGRectMake(20, 80, 240, 120)];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"testVideo" ofType:@"mp4"];
//    vpv.playUrl = [NSURL URLWithString:@"http://wvideo.spriteapp.cn/video/2016/1203/58425ad2a0c1d_wpd.mp4"];//[NSURL fileURLWithPath:path];
//    [self.view addSubview:vpv];
    
    
//    UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
//    butt.frame = CGRectMake(20, 280, 90, 40);
//    [butt addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
//    butt.backgroundColor = [UIColor yellowColor];
//    [self.view addSubview:butt];
//    
//    RotationImageView * rIv = [[RotationImageView alloc] initWithFrame:CGRectMake(10, 80, self.view.bounds.size.width - 20, 150)];
//    [self.view addSubview:rIv];
//    NSArray *imgs = @[@"IMG_2586.JPG", @"IMG_2591.JPG", @"IMG_2602.JPG"];
//    [rIv configImgs:imgs];
//    rIv.tapCallBack = ^(NSUInteger index) {
//        NSLog(@"点击了第 %lu 张", index);
//    };
//    rIv.autoScroll = YES;
//    rIv.cycleScroll = YES;
    
//    UIScrollView *tsrv = [[UIScrollView alloc] initWithFrame:CGRectMake(140, 160, 160, 90)];
//    tsrv.contentSize = CGSizeMake(160 * 3, 90);
//    tsrv.backgroundColor = [UIColor redColor];
//    [self.view addSubview:tsrv];
//    tsrv.pagingEnabled = YES;
//
//    for (int i = 0; i < 3; i++) {
//        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0 + 160*i, 0, 160, 90)];
//        v.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1];
//        [tsrv addSubview:v];
//    }
    
//    BannerView *bannerView = [[BannerView alloc] initWithFrame:CGRectMake(10, 80, self.view.bounds.size.width - 20, 180)];
//    bannerView.autoScroll = YES;
//    bannerView.cycleScroll = YES;
//    [self.view addSubview:bannerView];
//    bannerView.images = @[@"IMG_2586.JPG", @"IMG_2591.JPG"];//, @"IMG_2602.JPG"
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
    
    
    {
//        manager = [BarrageManager createBarrageManager];
//        [manager configContainerView:self.view];
//        [manager configBarrages:@[@"这是第一条弹幕", @"哈哈哈", @"嘿嘿嘿,第三", @"我的沙发呢?", @"你在搞什么?", @"Today", @"888888888", @"66666666", @"King 已经接单了", @"隔壁老王去哪了?", @"Oh~~~~", @"日乐购打赏了一架飞机", @"你们在干什么?", @"这是在干神马?", @"666+1", @"+1", @"已报警", @"Xcode已开启", @"还不去敲代码", @"新需求已到,请签收一下", @"你猜我猜不猜", @"屏幕已碎", @"🙂哈哈哈哈😆"]];
//        [manager configTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor greenColor]}];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [manager startBarrage];
//        });
        
//        CATextLayer *layer = [CATextLayer layer];
//        layer.string = @"ABCKKD";
//        layer.font = (__bridge CFTypeRef _Nullable)([UIFont systemFontOfSize:15]);
//        layer.foregroundColor = [UIColor brownColor].CGColor;
//        layer.backgroundColor = [UIColor purpleColor].CGColor;
//        layer.frame = CGRectMake(100, 200, 90, 50);
//        [self.view.layer addSublayer:layer];
    }
    
    
    {
//        UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300)];
//        [self.view addSubview:picker];
//        picker.datePickerMode = UIDatePickerModeTime;
        
    }
    
//    {
//        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize:18]}];
//        self.title = @"ABCK";
//
//        UINavigationBar *bar = self.navigationController.navigationBar;
//        for (UIView *v in bar.subviews) {
//            NSLog(@"%@", v);
//        }
//        bar.barTintColor = [UIColor colorWithRed:0.5 green:1 blue:0.5 alpha:0.3];
//
//        self.navigationItem.title = @"Home";
//
//        UIView *v = [UIView new];
//        v.frame = CGRectMake(0, 0, 200, 90);
//        [self.view addSubview:v];
//        v.backgroundColor = [UIColor blueColor];
//    }
//
//    {
//        UIButton *btn = [UIButton new];
//        btn.frame = CGRectMake(100, 330, 100, 100);
//        [btn setTitle:@"ABC" forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        btn.backgroundColor = [UIColor brownColor];
//        [self.view addSubview:btn];
//
//        UIControl *ctrl = [UIControl new];
//        ctrl.backgroundColor = [UIColor redColor];
//        ctrl.frame = CGRectMake(100, 100, 200, 150);
//        [self.view addSubview:ctrl];
//        UILabel *ctrlTitle = [UILabel new];
//        ctrlTitle.text = @"DEF";
//        ctrlTitle.frame = ctrl.bounds;
//        ctrlTitle.textColor = [UIColor whiteColor];
//        [ctrl addSubview:ctrlTitle];
//        ctrlTitle.textAlignment = NSTextAlignmentCenter;
//        ctrlTitle.center = CGPointMake(ctrl.bounds.size.width/2.f, ctrl.bounds.size.height/2.f);
//
//        [ctrl addTarget:self action:@selector(onTouchCtrlV:) forControlEvents:UIControlEventTouchUpInside];
//    }
    
//    self.view.backgroundColor = [UIColor lightGrayColor];
//    LMAddImageShower *footer = [[[NSBundle mainBundle] loadNibNamed:@"LMAddImageShower" owner:nil options:nil] lastObject];
//    footer.ownerVC = self;
//    footer.presenter = _presentAnimator;
//    footer.dismisser = _dismissAnimator;
//    CGFloat height = (self.view.bounds.size.width - 24 - 10)/3.f + 25;
//    footer.frame = CGRectMake(0, 300, self.view.bounds.size.width, height);
//    LMImage *img = [LMImage new];
//    img.originalImage = [UIImage imageNamed:@"IMG_2586.JPG"];
//    [footer addImage:img];
//    [self.view addSubview:footer];
}

- (void)onTouchCtrlV:(UIControl *)ctrl
{
    NSLog(@"abc");
}

- (void)onChanged:(UISwitch *)sender
{
//    [sender setOn:NO];
    [sender setOn:NO animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [LTDatePicker showCallBack:^(NSDate *date) {
//        //.
//    }];
//    [manager addBarrage:[NSString stringWithFormat:@"新增弹幕 %p", event]];
//    [manager pauseBarrage];
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




// present动画
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return _presentAnimator;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return _dismissAnimator;
}

@end
