//
//  ViewController.m
//  PSSTableViewNoneData
//
//  Created by 山和霞 on 17/4/26.
//  Copyright © 2017年 庞仕山. All rights reserved.
//

#import "ViewController.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenSize   [UIScreen mainScreen].bounds.size
#define kWindows [[UIApplication sharedApplication].delegate window]

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger numberOfSections;

@property (nonatomic, copy) NSArray *dataArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addTableViewInThis];
    [self dataArr];
}

#pragma mark - 添加tableView
- (void)addTableViewInThis
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
#pragma mark - tableView代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr ? _dataArr.count : 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = _dataArr ? _dataArr[section] : nil;
    return arr ? arr.count : 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"section=%ld row=%ld", indexPath.section, indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (IBAction)clickChangeData:(id)sender {
    UIButton *btn = (UIButton *)sender;
    NSString *title = _dataArr ? @"加载数据" : @"清空数据";
    [btn setTitle:title forState:UIControlStateNormal];
    if (_dataArr && _dataArr.count) {
        _dataArr = nil;
        [self.tableView reloadData];
    } else {
        [self dataArr];
        [self.tableView reloadData];
    }
}

- (NSArray *)dataArr
{
    if (_dataArr == nil) {
        NSInteger numberOfSections = arc4random() % 5 + 1;
        NSInteger numberOfRows = arc4random() % 8 + 2;
        NSMutableArray *mArr = [NSMutableArray array];
        for (int i = 0; i < numberOfSections; i++) {
            NSMutableArray *mSubArr = [NSMutableArray array];
            for (int j = 0; j < numberOfRows; j++) {
                [mSubArr addObject:@""];
            }
            [mArr addObject:mSubArr];
        }
        _dataArr = mArr;
    }
    return _dataArr;
}

@end
