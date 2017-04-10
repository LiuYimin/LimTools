//
//  UIButton+ExpandArea.h
//  LimToolsOC
//
//  Created by Liu on 07/04/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ExpandArea)
/**
 *  扩张边界的大小
 */
@property (nonatomic,assign) CGFloat enlargedEdge;

/**
 *  扩张四个边界的大小
 */
- (void)setEnlargedEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end
