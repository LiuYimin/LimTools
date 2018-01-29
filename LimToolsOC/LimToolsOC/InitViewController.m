//
//  InitViewController.m
//  LimToolsOC
//
//  Created by Liu on 26/12/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "InitViewController.h"
#import "BarrageManager.h"

@interface InitViewController ()

@end

@implementation InitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    NSLog(@"我被调用了");
    
//    UIView *tempV = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    tempV.backgroundColor = [UIColor brownColor];
//
//    tempV.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"IMG_2586.JPG"].CGImage);
//
//    [self.view addSubview:tempV];
    
    
//    tempV.layer.cornerRadius = 10;
    
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
