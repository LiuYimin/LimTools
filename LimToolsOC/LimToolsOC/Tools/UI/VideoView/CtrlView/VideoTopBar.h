//
//  VideoTopBar.h
//  ArtWorkCloud
//
//  Created by Liu on 18/08/2017.
//  Copyright © 2017 rvision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoTopBar : UIView
@property (nonatomic, copy) void(^backCall)();
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL showBar;
@end
