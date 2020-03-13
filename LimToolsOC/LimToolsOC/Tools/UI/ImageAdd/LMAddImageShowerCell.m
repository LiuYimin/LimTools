//
//  LMAddImageShowerCell.m
//  ArtWorkCloud
//
//  Created by Liu on 22/08/2017.
//  Copyright © 2017 rvision. All rights reserved.
//

#import "LMAddImageShowerCell.h"
#import "UIImageView+WebCache.h"

@interface LMAddImageShowerCell ()
@property (weak, nonatomic) IBOutlet UIImageView *contentImv;
@property (nonatomic, strong) UIImage *img;
@property (nonatomic, copy)   NSString *imgUrl;
@end

@implementation LMAddImageShowerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImg:(UIImage *)img {
    _img = img;
    _contentImv.image = _img;
    _contentImv.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setImgUrl:(NSString *)imgUrl {
    _imgUrl = imgUrl;
    [_contentImv sd_setImageWithURL:[NSURL URLWithString:_imgUrl]];
    _contentImv.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setLmImg:(LMImage *)lmImg {
    _lmImg = lmImg;
    if (_lmImg.originalImage) {
        self.img = _lmImg.originalImage;
    }else if (_lmImg.netUrl){
        self.imgUrl = _lmImg.netUrl;
    }else {
//        _lmImg.netUrl = [[ASNSDK defaultInstance] getOpenURL:_lmImg.serverFilePath type:@"jpg" size:OpenImgSize_Small];
        self.imgUrl = _lmImg.netUrl;
    }
}

@end
