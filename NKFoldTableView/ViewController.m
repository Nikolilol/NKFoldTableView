//
//  ViewController.m
//  NKFoldTableView
//
//  Created by Niko on 16/5/7.
//  Copyright © 2016年 niko. All rights reserved.
//

#import "ViewController.h"
#import "NKFoldTableView.h"
#import "CellModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (NSMutableArray *)setupData{
    NSMutableArray *dataArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i ++) {
        CellModel *model = [[CellModel alloc] init];
        model.classNo = i;
        model.className = @"showDetail";
        model.title = [NSString stringWithFormat:@"%d",i];
        for (int j = 0 ; j < i; j ++) {
            [dataArr addObject:model];
        }
    }
    return dataArr;
}

- (void)setupView{
    NKFoldTableView *tbView = [[NKFoldTableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped dataSource:[self setupData]];
    [self.view addSubview:tbView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
