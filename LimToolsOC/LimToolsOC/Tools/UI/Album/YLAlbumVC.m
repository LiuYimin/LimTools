//
//  YLAlbumVC.m
//  LimToolsOC
//
//  Created by Liu on 21/08/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "YLAlbumVC.h"
#import "YLAlbumItemCell.h"
#import <Photos/Photos.h>

#define __kScreenWidth            [UIScreen mainScreen].bounds.size.width
#define __kScreenHeight           [UIScreen mainScreen].bounds.size.height

@interface YLAlbumVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *contentCollv;

@property (nonatomic, strong) NSMutableArray *allPicAsserts;

@end

@implementation YLAlbumVC

#pragma mark -- Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initData];
    [self _initUI];
    [self getThumbnailImages];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Custom
- (void)_initData
{
    _allPicAsserts = [NSMutableArray array];
    _rowNum = 4;
}

- (void)_initUI
{
    [_contentCollv registerNib:[UINib nibWithNibName:@"YLAlbumItemCell" bundle:[NSBundle mainBundle]]  forCellWithReuseIdentifier:@"YLAlbumItemCell"];
    _contentCollv.contentInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
}

- (CGSize)calculateItemSize
{
    CGFloat width = (__kScreenWidth - 5*2 - 3*(self.rowNum-1))/self.rowNum;
    return CGSizeMake(width, width);
}

#pragma mark -- 获取系统图片
- (void)getOriginalImages
{
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿
    for (PHAssetCollection *assetCollection in assetCollections) {
        [self enumerateAssetsInAssetCollection:assetCollection original:YES];
    }
    
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    // 遍历相机胶卷,获取大图
    [self enumerateAssetsInAssetCollection:cameraRoll original:YES];
}

- (void)getThumbnailImages
{
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿
    for (PHAssetCollection *assetCollection in assetCollections) {
        [self enumerateAssetsInAssetCollection:assetCollection original:NO];
    }
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    [self enumerateAssetsInAssetCollection:cameraRoll original:NO];
}

/**
 *  遍历相簿中的所有图片
 *  @param assetCollection 相簿
 *  @param original        是否要原图
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original
{
    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    
    for (PHAsset *asset in assets) {
        [_allPicAsserts addObject:asset];
    }
    
    [_contentCollv reloadData];
}

- (void)getImgWithAssets:(PHAsset *)asset isOriginal:(BOOL)isOriginal callBack:(void(^)(UIImage *img))callback
{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];

    // 是否要原图
    CGSize size = isOriginal ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
    
    // 从asset中获得图片
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        NSLog(@"%@", result);
        if (callback) callback(result);
    }];
}

#pragma mark -- Action
- (IBAction)onDismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -- UICollectionViewDataSource,UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _allPicAsserts.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YLAlbumItemCell * cell =  [_contentCollv dequeueReusableCellWithReuseIdentifier:@"YLAlbumItemCell" forIndexPath:indexPath];
    if (indexPath.item < _allPicAsserts.count) {
        cell.asset = _allPicAsserts[indexPath.item];
    }
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self calculateItemSize];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item < _allPicAsserts.count && self.delegate && [self.delegate performSelector:@selector(yl_albumChooseImage:) withObject:nil]) {
        [self getImgWithAssets:_allPicAsserts[indexPath.item] isOriginal:YES callBack:^(UIImage *img) {
            [self.delegate yl_albumChooseImage:img];
            [self onDismiss:nil];
        }];
    }
}


@end
