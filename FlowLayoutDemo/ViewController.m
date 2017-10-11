//
//  ViewController.m
//  FlowLayoutDemo
//
//  Created by 栗子 on 16/5/22.
//  Copyright © 2016年 liuwen. All rights reserved.
//

#import "ViewController.h"
#import "LineFlowLayout.h"
#import "ImageCell.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *imageNames;

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation ViewController



#pragma mark - viewController

static NSString *const identifier = @"imageCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 400) collectionViewLayout:[[LineFlowLayout alloc] init]];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    
}

#pragma mark - collectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.imageName = self.imageNames[indexPath.item];
    return cell;
}


#pragma mark - setter/getter
- (NSMutableArray *)imageNames {
    if (!_imageNames) {
        _imageNames = [NSMutableArray array];
        for (int i = 1; i <= 20; i++) {
            [_imageNames addObject:[NSString stringWithFormat:@"%d", i]];
        }
    }
    return _imageNames;
}


@end
