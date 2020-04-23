//
//  UICollectionViewLayoutAttributes+Aligment.m
//  PSAlignmentLayout
//
//  Created by shenwenxin on 2020/4/23.
//  Copyright © 2020 swx. All rights reserved.
//

#import "UICollectionViewLayoutAttributes+Aligment.h"

@implementation UICollectionViewLayoutAttributes (Aligment)

- (void)leftAlignFrameWithSectionInset:(UIEdgeInsets)sectionInset {
    CGRect frame = self.frame;
    frame.origin.x = sectionInset.left;
    self.frame = frame;
}

@end
