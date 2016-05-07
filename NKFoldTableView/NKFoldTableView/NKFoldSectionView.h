//
//  NKFoldSectionView.h
//  NKFoldTableView
//
//  Created by Niko on 16/5/7.
//  Copyright © 2016年 niko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellModel.h"

@class NKFoldSectionView;

@protocol NKFoldSectionViewDelegate <NSObject>
- (void)foldHeaderInSection:(NSInteger)SectionHeader;
@end

@interface NKFoldSectionView : UITableViewHeaderFooterView
@property(nonatomic, assign) NSInteger section;/** selected section */
@property(nonatomic, weak) id<NKFoldSectionViewDelegate> delegate;/** delegate */
- (void)setSectionViewWithModel:(CellModel *)model section:(NSInteger)section;
@end
