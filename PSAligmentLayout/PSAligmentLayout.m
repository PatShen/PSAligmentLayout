//
//  PSAligmentLayout.m
//  PSAligmentLayout
//
//  Created by shenwenxin on 2020/4/23.
//  Copyright © 2020 swx. All rights reserved.
//

#import "PSAligmentLayout.h"
#import "UICollectionViewLayoutAttributes+Aligment.h"

@implementation PSAligmentLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.autoWordWrap = YES;
        self.minimumLineSpacing = 10.0;
        self.minimumInteritemSpacing = 10.0;
    }
    return self;
}

- (CGFloat)evaluatedMinimumInteritemSpacingForSectionAtIndex:(NSInteger)sectionIndex {
    id delegate = self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:sectionIndex];
    }
    else {
        return self.minimumInteritemSpacing;
    }
}

- (CGFloat)evaluatedMinimumLineSpacingForSectionAtIndex:(NSInteger)sectionIndex {
    id delegate = self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        return [delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:sectionIndex];
    }
    else {
        return self.minimumLineSpacing;
    }
}

- (UIEdgeInsets)evaluatedSectionInsetForItemAtIndex:(NSInteger)index {
    id delegate = self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:index];
    }
    else {
        return self.sectionInset;
    }
}

// MARK: 重载
- (void)prepareLayout {
    [super prepareLayout];
    if (![self.collectionView isKindOfClass:[UICollectionView class]]) {
        return;
    }
    if (_autoWordWrap) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    else {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *originalAttributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *updatedAttributes = [NSMutableArray arrayWithArray:originalAttributes];
    for (UICollectionViewLayoutAttributes *attributes in originalAttributes) {
        if (!attributes.representedElementKind) {
            NSUInteger index = [updatedAttributes indexOfObject:attributes];
            updatedAttributes[index] = [self layoutAttributesForItemAtIndexPath:attributes.indexPath];
        }
    }

    return updatedAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes* currentItemAttributes = [[super layoutAttributesForItemAtIndexPath:indexPath] copy];
    
    UIEdgeInsets sectionInset = [self evaluatedSectionInsetForItemAtIndex:indexPath.section];

    BOOL isFirstItemInSection = indexPath.item == 0;
    CGFloat layoutWidth = CGRectGetWidth(self.collectionView.frame) - sectionInset.left - sectionInset.right;
    
    if (isFirstItemInSection) {
        [currentItemAttributes leftAlignFrameWithSectionInset:sectionInset];
        return currentItemAttributes;
    }
    
    NSIndexPath* previousIndexPath = [NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section];
    CGRect previousFrame = [self layoutAttributesForItemAtIndexPath:previousIndexPath].frame;
    CGFloat previousFrameRightPoint = previousFrame.origin.x + previousFrame.size.width;
    
    if (_autoWordWrap) {
        CGRect currentFrame = currentItemAttributes.frame;
        CGRect strecthedCurrentFrame = CGRectMake(sectionInset.left,
                                                  currentFrame.origin.y,
                                                  layoutWidth,
                                                  currentFrame.size.height);
        // if the current frame, once left aligned to the left and stretched to the full collection view
        // width intersects the previous frame then they are on the same line
        BOOL isFirstItemInRow = !CGRectIntersectsRect(previousFrame, strecthedCurrentFrame);

        if (isFirstItemInRow) {
            // make sure the first item on a line is left aligned
            [currentItemAttributes leftAlignFrameWithSectionInset:sectionInset];
            CGRect frame = currentItemAttributes.frame;
            frame.origin.y = CGRectGetMaxY(previousFrame) + [self evaluatedMinimumLineSpacingForSectionAtIndex:indexPath.section];
            currentItemAttributes.frame = frame;
            return currentItemAttributes;
        }

        CGRect frame = currentItemAttributes.frame;
        frame.origin.x = previousFrameRightPoint + [self evaluatedMinimumInteritemSpacingForSectionAtIndex:indexPath.section];
        frame.origin.y = previousFrame.origin.y;
        currentItemAttributes.frame = frame;
        return currentItemAttributes;
    }
    else {
        // no word wrap, layout all the way to the x axis
        CGRect frame = currentItemAttributes.frame;
        frame.origin.x = previousFrameRightPoint + [self evaluatedMinimumInteritemSpacingForSectionAtIndex:indexPath.section];
        currentItemAttributes.frame = frame;
        return currentItemAttributes;
    }
}

@end
