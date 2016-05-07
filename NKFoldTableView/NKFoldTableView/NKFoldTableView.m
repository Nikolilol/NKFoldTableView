//
//  NKFoldTableView.m
//  NKFoldTableView
//
//  Created by Niko on 16/5/7.
//  Copyright © 2016年 niko. All rights reserved.
//

#import "NKFoldTableView.h"
#import "CellModel.h"
#import "NKFoldSectionView.h"

@interface NKFoldTableView ()<UITableViewDataSource, UITableViewDelegate, NKFoldSectionViewDelegate>{
    
}
@property(nonatomic, strong) NSMutableArray *classArr;
@property(nonatomic, strong) NSMutableDictionary *switchDict;
@end

@implementation NKFoldTableView

# pragma mark - Lazy Load
- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (NSMutableArray *)classArr{
    if (!_classArr) {
        _classArr = [[NSMutableArray alloc] init];
    }
    return _classArr;
}

- (NSMutableDictionary *)switchDict{
    if (!_switchDict) {
        _switchDict = [[NSMutableDictionary alloc] init];
    }
    return _switchDict;
}

# pragma mark - Setup All
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style dataSource:(NSMutableArray *)dataArr{
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        [self setData:dataArr];
    }
    
    return self;
}

- (void)processData{
    //1.clear arr
    [[self classArr] removeAllObjects];
    
    //2.filter arr
    for (int i = 0; i < [[self dataArr] count]; i ++) {
        CellModel *model = [[self dataArr] objectAtIndex:i];
        if (![[self classArr] containsObject:model]){
            [[self classArr] addObject:model];
        }
    }
    
    //3.define switch for section
    for (int t = 0 ; t < [[self classArr] count]; t ++) {
        // object 1 means open 0 means closed
        [[self switchDict] setObject:@"0" forKey:[NSString stringWithFormat:@"%d",t]];
    }
    
    //4.refresh tableview
    [self reloadData];
}

- (void)setData:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    [self processData];
}

# pragma mark - LXSectionViewDelegate
- (void)foldHeaderInSection:(NSInteger)SectionHeader{
    NSString *key = [NSString stringWithFormat:@"%d",(int)SectionHeader];
    BOOL folded = [[[self switchDict] objectForKey:key] boolValue];
    NSString *fold = folded ? @"0" : @"1";
    [[self switchDict] setValue:fold forKey:key];
    NSMutableIndexSet *set = [[NSMutableIndexSet alloc] initWithIndex:SectionHeader];
    //    [self reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    [self reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

# pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self classArr] count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{//根据表头,到总数组中,筛选出临时数组,确定数量
    [[self classArr] objectAtIndex:section];
    int rowCount = 0;
    for (int i = 0; i < [[self dataArr] count]; i ++) {
        CellModel *model = [[self dataArr] objectAtIndex:i];
        if (model == [[self classArr] objectAtIndex:section]) {
            rowCount ++;
        }
    }
    NSString *key = [NSString stringWithFormat:@"%d", (int)section];
    BOOL folded = [[[self switchDict] objectForKey:key] boolValue];
    return folded?rowCount:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if ([[self classArr] count] >= indexPath.section) {
        NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < [[self dataArr] count]; i ++) {
            CellModel *model = [[self dataArr] objectAtIndex:i];
            if (model == [[self classArr] objectAtIndex:indexPath.section]) {
                [tmpArr addObject:model];
            }
        }
        CellModel *model = [tmpArr objectAtIndex:indexPath.row];
        cell.textLabel.text = model.title;
    }
    
    cell.contentView.backgroundColor = [UIColor redColor];
    
    return cell;
}

//custom header view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *headerID = @"header";
    NKFoldSectionView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    if (!headerView) {
        headerView = [[NKFoldSectionView alloc] initWithReuseIdentifier:headerID];
    }
    
    [headerView setSectionViewWithModel:[[self classArr] objectAtIndex:section] section:section];
    headerView.delegate = self;
    headerView.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:243/255.0 blue:246/255.0 alpha:1.0];
    return headerView;
}

# pragma mark - UITableViewDelegate
//Section Height
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
