//
//  YLSelectCell.m
//  LimToolsOC
//
//  Created by Liu on 21/06/2017.
//  Copyright © 2017 Liu. All rights reserved.
//

#import "YLSelectCell.h"

@interface YLSelectCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *flagImv;
@property (weak, nonatomic) IBOutlet UIView *line;

@end

@implementation YLSelectCell

- (void)setContentDict:(NSDictionary *)contentDict {
    _contentDict = contentDict;
    _titleLab.text = _contentDict[@"title"];
}

- (void)setIsLast:(BOOL)isLast {
    _isLast = isLast;
    _line.hidden = _isLast;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
