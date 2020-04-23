//
//  ViewController.m
//  PSDemo
//
//  Created by shenwenxin on 2020/4/23.
//  Copyright © 2020 swx. All rights reserved.
//

#import "ViewController.h"
#import <PSAligmentLayout/PSAligmentLayout.h>
#import "PSDemoCollectionViewCell.h"
#import <Masonry/Masonry.h>

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView* cllWrap;

@property (nonatomic, strong) UICollectionView* cllNoWrap;

@property (nonatomic, strong) NSArray* dataSourceArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSourceArray = @[@"hcemsenorlw",
                             @"ndndids",
                             @"plnpnmrofs",
                             @"herrbetoe",
                             @"tss",
                             @"hhtnasem",
                             @"tmghaareuotjt",
                             @"ecum",
                             @"gnrgoat",
                             @"rnngavtorns",
                             @"neearaotc"
    ];
    [self.view addSubview:self.cllWrap];
    [_cllWrap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(200);
        make.left.right.equalTo(self.view);
    }];
    [self.view addSubview:self.cllNoWrap];
    [_cllNoWrap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(100);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    [self reloadCollectionView];
}


- (UICollectionView *)cllWrap {
    if (_cllWrap == nil) {
        PSAligmentLayout* layout = [[PSAligmentLayout alloc] init];
        
        UICollectionView* cll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [cll setBackgroundColor:UIColor.yellowColor];
        [cll setDataSource:self];
        [cll setDelegate:self];
        [cll registerClass:[PSDemoCollectionViewCell class]
forCellWithReuseIdentifier:[[PSDemoCollectionViewCell class] description]];
        _cllWrap = cll;
    }
    return _cllWrap;
}

- (UICollectionView *)cllNoWrap {
    if (_cllNoWrap == nil) {
        PSAligmentLayout* layout = [[PSAligmentLayout alloc] init];
        [layout setAutoWordWrap:NO];
        [layout setMinimumInteritemSpacing:20];
        
        UICollectionView* cll = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [cll setBackgroundColor:UIColor.redColor];
        [cll setDataSource:self];
        [cll setDelegate:self];
        [cll registerClass:[PSDemoCollectionViewCell class]
forCellWithReuseIdentifier:[[PSDemoCollectionViewCell class] description]];
        _cllNoWrap = cll;
    }
    return _cllNoWrap;
}

- (void)reloadCollectionView {
    [_cllWrap reloadData];
    [_cllWrap layoutIfNeeded];
    UICollectionViewLayout* layout = _cllWrap.collectionViewLayout;
    CGSize size = layout.collectionViewContentSize;
    [_cllWrap mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height);
    }];
    
    [_cllNoWrap reloadData];
    [_cllNoWrap layoutIfNeeded];
    layout = _cllNoWrap.collectionViewLayout;
    CGSize noWrapSize = layout.collectionViewContentSize;
    [_cllNoWrap mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(noWrapSize.height);
    }];
}

// MARK: UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString* identifier = [[PSDemoCollectionViewCell class] description];
    PSDemoCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    id data = _dataSourceArray[indexPath.row];
    [cell loadData:data];
    return cell;
}

// MARK: UICollectionViewDelegate

// MARK: UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeZero;
    
    PSDemoCollectionViewCell* cell = [[PSDemoCollectionViewCell alloc] init];
    id data = _dataSourceArray[indexPath.row];
    [cell loadData:data];
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGFloat height = 30.0;
    size = [cell systemLayoutSizeFittingSize:CGSizeMake(CGFLOAT_MAX, height)];
    
    return size;
}

@end
