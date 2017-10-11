//
//  LineFlowLayout.m
//  FlowLayoutDemo
//
//  Created by 栗子 on 16/5/22.
//  Copyright © 2016年 liuwen. All rights reserved.
//

#import "LineFlowLayout.h"

#define CellW 200   // cell宽度
#define CellH 200   // cell高度
#define SpaceScale 0.3  // cell之间间距 与 cell宽度 比例
#define LineSpace (CellH * SpaceScale)  // cell之间间距
#define CellMaxScale 0.2 // Cell最大缩放比例

@implementation LineFlowLayout

//返回yes允许collectionView重新查询cell布局信息
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    
    return YES;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    self.itemSize = CGSizeMake(CellW, CellH);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = LineSpace;
    
    CGFloat inset = (self.collectionView.bounds.size.width - CellW) * 0.5;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    
//    CGRect visibleRect;
//    visibleRect.origin = self.collectionView.contentOffset;
//    visibleRect.size = self.collectionView.bounds.size;
    
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    for (UICollectionViewLayoutAttributes *attr in arr) {
//        if (!CGRectIntersectsRect(visibleRect, attr.frame)) {
//            continue;
//        }
        CGFloat attrCenterX = attr.center.x;
        CGFloat distance = ABS(attrCenterX - centerX);
        if (distance > CellW * (SpaceScale + 0.5)) {
            continue;
        }
        
        CGFloat scale = 1 + (1 - distance/(CellW * (SpaceScale + 0.5))) * CellMaxScale;
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arr;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    NSArray *arr = [self layoutAttributesForElementsInRect:lastRect];
    
    CGFloat adjustOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in arr) {
        if (ABS(attrs.center.x - centerX) < ABS(adjustOffsetX)) {
            adjustOffsetX = attrs.center.x - centerX;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y) ;
}


@end
