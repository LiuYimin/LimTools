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
    
    QRView * _qrCodeView = [[QRView alloc] initWithQRString:@"fjlskfjslkfjlsd"];
    _qrCodeView.frame = CGRectMake(40, 120, 200, 200);
    [self.view addSubview:_qrCodeView];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
