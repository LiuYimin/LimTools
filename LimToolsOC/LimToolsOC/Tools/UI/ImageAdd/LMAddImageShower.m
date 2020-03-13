//
//  LMAddImageShower.m
//  ArtWorkCloud
//
//  Created by Liu on 22/08/2017.
//  Copyright © 2017 rvision. All rights reserved.
//

#import "LMAddImageShower.h"
#import "LMAddImageShowerCell.h"
#import "LMActivityAnnexVC.h"

#define __LMAddSingleRowImageNum 3
#define __LMAddSingleMaxImageNum 9

@interface LMAddImageShower ()<UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) LMImage  *addImg;

@property (nonatomic, strong) NSMutableArray *picArrays;
@property (weak, nonatomic) IBOutlet UICollectionView *picturesCollv;

@end

@implementation LMAddImageShower
- (void)addImage:(LMImage *)image
{
    CGFloat ch = [self calculateItemSize].height + 5;
    if ([_picArrays containsObject:_addImg]) {
        [_picArrays insertObject:image atIndex:[_picArrays indexOfObject:_addImg]];
    }else {
        [_picArrays addObject:image];
    }
    if (_picArrays.count > __LMAddSingleRowImageNum*2) {
        if (self.updateHeight) self.updateHeight(20+ch+ch+ch);
    }else if (_picArrays.count > __LMAddSingleRowImageNum) {
        if (self.updateHeight) self.updateHeight(20+ch+ch);
    }else {
        if (self.updateHeight) self.updateHeight(20+ch);
    }
    
    if (_picArrays.count > __LMAddSingleMaxImageNum) {
        [_picArrays removeLastObject];
    }
    
    [_picturesCollv reloadData];
    [self callBackCurrentImages];
}

- (void)removeImage:(LMImage *)image
{
    [_picArrays removeObject:image];
    [_picturesCollv reloadData];
    [self callBackCurrentImages];
    
    if (![_picArrays containsObject:_addImg]) {
        [_picArrays addObject:_addImg];
        CGFloat ch = [self calculateItemSize].height + 5;
        if (_picArrays.count > __LMAddSingleRowImageNum*2) {
            if (self.updateHeight) self.updateHeight(84+ch+ch+ch);
        }else if (_picArrays.count > __LMAddSingleRowImageNum) {
            if (self.updateHeight) self.updateHeight(84+ch+ch);
        }else {
            if (self.updateHeight) self.updateHeight(84+ch);
        }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self _initData];
    [self _initUI];
}

- (void)_initData
{
    _picArrays = [NSMutableArray array];
    _addImg = [LMImage new];
    _addImg.originalImage = [UIImage imageNamed:@"icon_course_add"];
    [_picArrays addObject:_addImg];
}

- (void)_initUI
{
    [_picturesCollv registerNib:[UINib nibWithNibName:@"LMAddImageShowerCell" bundle:[NSBundle mainBundle]]  forCellWithReuseIdentifier:@"LMAddImageShowerCell"];
    [_picturesCollv reloadData];
}

- (CGSize)calculateItemSize
{
    CGFloat width = (__kWidth - 12 * 2 - 5*(__LMAddSingleRowImageNum-1))/__LMAddSingleRowImageNum;
    return CGSizeMake(width, width);
}

- (void)callBackCurrentImages
{
    NSArray *arr = [NSArray array];
    if ([_picArrays containsObject:_addImg]) {
        arr = [_picArrays subarrayWithRange:NSMakeRange(0, _picArrays.count-1)];
    }else {
        arr = _picArrays;
    }
    if (self.currentImages) self.currentImages(arr);
}

- (void)setHiddenAddImage:(BOOL)hiddenAddImage {
    _hiddenAddImage = hiddenAddImage;
    if (_hiddenAddImage) {
        [_picArrays removeObject:_addImg];
        [_picturesCollv reloadData];
    }else {
        if (![_picArrays containsObject:_addImg]) {
            [_picArrays addObject:_addImg];
            [_picturesCollv reloadData];
        }
    }
}

#pragma mark -- UICollectionViewDataSource,UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _picArrays.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LMAddImageShowerCell * cell =  [_picturesCollv dequeueReusableCellWithReuseIdentifier:@"LMAddImageShowerCell" forIndexPath:indexPath];
    if (_picArrays.count > indexPath.item) {
        cell.lmImg = _picArrays[indexPath.item];
        if (cell.lmImg == _addImg) {
            
        }
    }
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self calculateItemSize];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _picArrays.count-1 && [_picArrays containsObject:_addImg]) {//最后一个,点击了添加图片
        if (self.ownerVC) {
            [self chooseImage];
        }
        if (self.addImageCallBack) self.addImageCallBack();
    }else {
        NSArray *arr = [NSArray array];
        if ([_picArrays containsObject:_addImg]) {
            arr = [_picArrays subarrayWithRange:NSMakeRange(0, _picArrays.count-1)];
        }else {
            arr = _picArrays;
        }
        
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        _presenter.originFrame = [cell convertRect:cell.frame toView:__kWindow];
        _dismisser.originFrame = [cell convertRect:cell.frame toView:__kWindow];
        if (self.clickImageCallBack) self.clickImageCallBack(arr, indexPath.row);
        [self gotoDetailPic:arr index:indexPath.row];
    }
}

#pragma mark -- Goto Big Pic
- (void)gotoDetailPic:(NSArray *)arr index:(NSInteger)index
{
    LMActivityAnnexVC *vc = [[LMActivityAnnexVC alloc] init];
    vc.singleTapClose = YES;
    vc.index = index;
    vc.imgArray = arr;
    vc.transitioningDelegate = self.ownerVC;
    vc.deleteImageCallBack = ^(LMImage *img) {
        
    };
    [self.ownerVC presentViewController:vc animated:YES completion:nil];
}

/*
 - (void)presentClick{
 SecondViewController * secondVC = [[SecondViewController alloc] init];
 secondVC.transitioningDelegate = self; // 必须second同样设置delegate才有动画
 [self presentViewController:secondVC animated:YES completion:^{
 }];
 }

 */

#pragma mark -- ChooseImage
- (void)chooseImage {
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"添加图片" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    
    //判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self alertClicked:UIImagePickerControllerSourceTypeCamera];
        }];
        
//        [cameraAction setValue:RGBS(47) forKey:@"_titleTextColor"];
        [alertController addAction:cameraAction];
    }
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [cancelAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self alertClicked:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    
//    {//配置样式
//        NSMutableAttributedString *titleText = [[NSMutableAttributedString alloc] initWithString:@"添加附件"];
//        [titleText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, [[titleText string] length])];
//        [titleText addAttribute:NSForegroundColorAttributeName value:RGBS(129) range:NSMakeRange(0, [[titleText string] length])];
//        [alertController setValue:titleText forKey:@"attributedTitle"];
//
//        [albumAction setValue:RGBS(47) forKey:@"_titleTextColor"];
//
//        [cancelAction setValue:RGB(252, 11, 0) forKey:@"_titleTextColor"];
//    }
    
    
    [alertController addAction:cancelAction];
    [alertController addAction:albumAction];
    
    [self.ownerVC presentViewController:alertController animated:YES completion:nil];
}

- (void)alertClicked:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    imagePickerController.sourceType = sourceType;
    [self.ownerVC presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark -- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    LMImage *img = [LMImage new];
    img.originalImage = image;
    [self addImage:img];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
