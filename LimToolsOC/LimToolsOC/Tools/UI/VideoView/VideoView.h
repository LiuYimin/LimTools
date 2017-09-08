//
//  VideoContainer.h
//  LimToolsOC
//
//  Created by Liu on 17/08/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoView : UIView

/**是否支持横屏,默认NO*/
@property (nonatomic, assign) BOOL           isLandscape;

@property (nonatomic, strong) NSURL         *playUrl;
@property (nonatomic, strong) NSString      *titleText;
@property (nonatomic, strong) NSString      *coverUrl;

@end
