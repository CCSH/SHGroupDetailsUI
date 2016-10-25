//
//  GroupDetalisCollectionViewCell.m
//  群详情界面（微信）
//
//  Created by CSH on 16/6/28.
//  Copyright © 2016年 CSH. All rights reserved.
//

#import "GroupDetalisCollectionViewCell.h"

@implementation GroupDetalisCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImage.layer.cornerRadius = 10;
    self.headImage.layer.borderColor = [UIColor clearColor].CGColor;
    self.headImage.layer.borderWidth = 1;
}

@end
