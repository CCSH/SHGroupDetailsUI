//
//  GroupDetalisCollectionViewCell.h
//  群详情界面（微信）
//
//  Created by CSH on 16/6/28.
//  Copyright © 2016年 CSH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupDetalisCollectionViewCell : UICollectionViewCell
//头像
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
//用户名
@property (weak, nonatomic) IBOutlet UILabel *headTitle;
//删除图标
@property (weak, nonatomic) IBOutlet UIImageView *deleteImage;


@end
