//
//  BarrageManager.m
//  LimToolsOC
//
//  Created by Liu on 29/01/2018.
//  Copyright © 2018 Liu. All rights reserved.
//

#import "BarrageManager.h"
#import "BarrageEntity.h"

@interface BarrageManager()
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, strong) NSMutableArray <NSString *> *defaultBarrages;
@property (nonatomic, strong) NSMutableArray <BarrageEntity *> *entitys;
@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, assign) BOOL   bNeedShow;//已经开启了弹幕,如果新增了弹幕,需要展示
@property (nonatomic, assign) BOOL   bShowing;//正在显示弹幕
@end
@implementation BarrageManager
#pragma mark - Public
/**初始化控制类*/
+ (instancetype)createBarrageManager;
{
    BarrageManager *manager = [[BarrageManager alloc] init];
    return manager;
}
/**初始化容器*/
- (void)configContainerView:(UIView *)containerView;
{
    self.containerView = containerView;
}
/**初始化弹幕内容*/
- (void)configBarrages:(NSArray <NSString *> *)defaultBarrages;
{
    _defaultBarrages = [NSMutableArray arrayWithArray:defaultBarrages];
    _entitys = [NSMutableArray array];
    for (NSString *text in _defaultBarrages) {
        BarrageEntity *entity = [[BarrageEntity alloc] init];
        entity.fatherLayer = self.containerView.layer;
        entity.contentString = text;
        [_entitys addObject:entity];
    }
}
/**动态添加弹幕内容*/
- (void)addBarrage:(NSString *)newBarrage;
{
    if (!_defaultBarrages) {
        _defaultBarrages = [NSMutableArray array];
    }
    if (!_entitys) {
        _entitys = [NSMutableArray array];
    }
    [_defaultBarrages addObject:newBarrage];
    
    BarrageEntity *entity = [[BarrageEntity alloc] init];
    entity.fatherLayer = self.containerView.layer;
    entity.contentString = newBarrage;
    [_entitys addObject:entity];
    if (_bNeedShow && !_bShowing) {
        [self startBarrage];
    }
}
/**开启弹幕*/
- (void)startBarrage;
{
    _bNeedShow = YES;
    _bShowing = YES;
    [self startBarragesShow];
}

#pragma mark - Private
#pragma mark -- Lifecycle
- (instancetype)init {
    self = [super init];
    if (self) {
        [self _initData];
    }
    return self;
}

#pragma mark -- Initialization
- (void)_initData
{
    _defaultBarrages = [NSMutableArray array];
    _entitys = [NSMutableArray array];
}

#pragma mark -- Tool


#pragma mark -- Animation
- (void)startBarragesShow
{
    for (int i = 0; i<3; i++) {
        CGFloat centY = 180 + i*30;
        [self startAnimationWithCentY:centY];
    }
}

- (void)startAnimationWithCentY:(CGFloat)centY
{
    if (_entitys.count > 0) {
        [_lock lock];
        BarrageEntity *entity = _entitys.firstObject;
        [_entitys removeObject:entity];
        [_lock unlock];
        
        entity.centerY = centY;
        entity.fatherLayer = self.containerView.layer;
        [entity startDriftOver:^(BarrageEntityState state) {
            switch (state) {
                case BarrageEntityState_Wait:
                    //
                    break;
                case BarrageEntityState_Enter:
                {
                    [self startAnimationWithCentY:centY];
                }
                    break;
                case BarrageEntityState_Out:
                {
                    if (_entitys.count==0) {
                        _bShowing = NO;
                    }
                }
                    break;
            }
        }];
    }
}


@end
