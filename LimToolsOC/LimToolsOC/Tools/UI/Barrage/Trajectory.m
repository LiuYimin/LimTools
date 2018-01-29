//
//  Trajectory.m
//  LimToolsOC
//
//  Created by Liu on 29/01/2018.
//  Copyright © 2018 Liu. All rights reserved.
//

#import "Trajectory.h"

@interface Trajectory()
@property (nonatomic, assign) TrajectoryState state;
@property (nonatomic, strong) BarrageEntity *entity;
@end
@implementation Trajectory
- (instancetype)init {
    self = [super init];
    if (self) {
        [self _initData];
    }
    return self;
}

- (void)_initData
{
    
}

- (void)addEntity:(BarrageEntity *)entity;
{
    _entity = entity;
    _entity.centerY = _centY;
    if (_state!=TrajectoryState_Enter) {
        [self showEntity];
    }
}

- (void)showEntity {
    if (_entity) {
        self.state = TrajectoryState_Enter;
        [_entity startDriftOver:^(BarrageEntityState entityState) {
            switch (entityState) {
                case BarrageEntityState_Wait:
                    //
                    break;
                case BarrageEntityState_Enter:
                {
                    self.state = TrajectoryState_AllIn;
                }
                    break;
                case BarrageEntityState_Out:
                {
                }
                    break;
            }
            if (self.endOverCallback) self.endOverCallback(entityState);
        }];
    }
}
@end
