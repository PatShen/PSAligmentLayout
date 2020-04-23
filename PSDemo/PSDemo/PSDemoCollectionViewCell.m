//
//  PSDemoCollectionViewCell.m
//  PSDemo
//
//  Created by shenwenxin on 2020/4/23.
//  Copyright © 2020 swx. All rights reserved.
//

#import "PSDemoCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface PSDemoCollectionViewCell ()

@property (nonatomic, strong) UILabel* lblName;

@end

@implementation PSDemoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView setBackgroundColor:UIColor.lightGrayColor];
        [self installConstraints];
    }
    return self;
}

- (void)installConstraints {
    UIView* superview = self.contentView;
    [superview addSubview:self.lblName];
    UIEdgeInsets margin = UIEdgeInsetsMake(4, 8, 4, 8);
    [_lblName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superview).insets(margin).priorityHigh();
    }];
}

- (UILabel *)lblName {
    if (_lblName == nil) {
        UILabel* lbl = [[UILabel alloc] init];
        [lbl setFont:[UIFont systemFontOfSize:14.0]];
        [lbl setTextColor:UIColor.whiteColor];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        _lblName = lbl;
    }
    return _lblName;
}

- (void)loadData:(id)data {
    NSString* text = data;
    [_lblName setText:text];
}

@end
