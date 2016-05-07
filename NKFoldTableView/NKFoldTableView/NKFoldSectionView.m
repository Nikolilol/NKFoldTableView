//
//  NKFoldSectionView.m
//  NKFoldTableView
//
//  Created by Niko on 16/5/7.
//  Copyright © 2016年 niko. All rights reserved.
//

#import "NKFoldSectionView.h"

@interface NKFoldSectionView ()
@property(nonatomic, weak)   UILabel *titleLabel;/** title */
@property(nonatomic, weak)   UIButton *coverBtn;
@end

@implementation NKFoldSectionView{
    BOOL _created;
}

- (void)setSectionViewWithModel:(CellModel *)model section:(NSInteger)section{
    //1.init UI
    if (!_created) {
        [self creatUI];
    }
    //2.setup data to UI
    _titleLabel.text = [NSString stringWithFormat:@"%d", model.classNo];
    
    _section = section;
}

- (void)creatUI {
    _created = YES;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    UIButton *coverBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [coverBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:coverBtn];
    _coverBtn = coverBtn;
    
    //Creat your UI in here...
}

- (void)btnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(foldHeaderInSection:)]) {
        [self.delegate foldHeaderInSection:_section];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(5, 0, self.contentView.frame.size.width, 60);
    _coverBtn.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
}
@end
