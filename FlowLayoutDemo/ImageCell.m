//
//  ImageCell.m
//  FlowLayoutDemo
//
//  Created by 栗子 on 16/5/22.
//  Copyright © 2016年 liuwen. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ImageCell

- (void)awakeFromNib {
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.cornerRadius = 2;
}

#pragma mark - setter/getter
- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    _imageView.image = [UIImage imageNamed:imageName];
}

@end
