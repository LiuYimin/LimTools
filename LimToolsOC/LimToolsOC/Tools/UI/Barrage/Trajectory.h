//
//  Trajectory.h
//  LimToolsOC
//
//  Created by Liu on 29/01/2018.
//  Copyright © 2018 Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BarrageEntity.h"

typedef enum
{
    TrajectoryState_Wait = 0,//没有实体在运行
    TrajectoryState_Enter,//有实体在运行,并且最后一个实体还未全部进入
    TrajectoryState_AllIn,//有实体在运行,并且最后一个实体全部进入
}TrajectoryState;

@interface Trajectory : NSObject
@property (nonatomic, assign, readonly) TrajectoryState state;
@property (nonatomic, assign) CGFloat centY;
@property (nonatomic, copy) void (^endOverCallback)(BarrageEntityState state);

- (void)addEntity:(BarrageEntity *)entity;
@end
