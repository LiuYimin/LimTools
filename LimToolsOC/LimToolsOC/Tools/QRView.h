//
//  QRView.h
//  LimToolsOC
//
//  Created by Liu on 07/04/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 根据字符串生成二维码
 */
@interface QRView : UIImageView
- (id)initWithQRString:(NSString *)qrStr;
@end
