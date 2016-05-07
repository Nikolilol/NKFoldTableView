//
//  NKFoldTableView.h
//  NKFoldTableView
//
//  Created by Niko on 16/5/7.
//  Copyright © 2016年 niko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NKFoldTableView : UITableView
@property(nonatomic, strong) NSMutableArray *dataArr;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style dataSource:(NSMutableArray *)dataArr;
@end
