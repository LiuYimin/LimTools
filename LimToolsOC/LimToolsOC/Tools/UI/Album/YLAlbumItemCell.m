//
//  YLAlbumItemCell.m
//  LimToolsOC
//
//  Created by Liu on 21/08/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "YLAlbumItemCell.h"

@interface YLAlbumItemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *contentImv;

@end

@implementation YLAlbumItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)getImgWithAssets:(PHAsset *)asset isOriginal:(BOOL)isOriginal
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.networkAccessAllowed = YES;
    
    // 是否要原图
    CGSize size = isOriginal ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
    
    // 从asset中获得图片
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        _contentImv.image = result;
    }];
}

- (void)setAsset:(PHAsset *)asset {
    _asset = asset;
    [self getImgWithAssets:_asset isOriginal:YES];
}

@end
