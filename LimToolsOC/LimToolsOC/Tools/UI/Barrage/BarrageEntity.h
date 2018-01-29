//
//  BarrageEntity.h
//  LimToolsOC
//
//  Created by Liu on 29/01/2018.
//  Copyright © 2018 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    BarrageEntityState_Wait = 0,
    BarrageEntityState_Enter,
    BarrageEntityState_Out
}BarrageEntityState;

@interface BarrageEntity : NSObject
@property (nonatomic, strong, nonnull) NSString *contentString;
@property (nonatomic, assign) CGFloat   centerY;
@property (nonatomic, weak) CALayer    * _Nullable fatherLayer;
- (void)startDriftOver:(void(^_Nullable)(BarrageEntityState state))endOverCallback;
@end
