//
//  ViewController.m
//  GHWebViewAutomaticHeightDemo
//
//  Created by mac on 2020/2/27.
//  Copyright © 2020 GHome. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import "UIView+Extension.h"
#import "GHWebView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource> 

@property (nonatomic , strong) UITableView *tableView;
//@property (nonatomic , strong) GHWebView *footer;
@property (nonatomic , strong) WKWebView *header;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    self.navigationItem.title = @"完美实现WKWebView动态高度";
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
//    self.tableView.tableFooterView = self.footer;
    self.tableView.tableHeaderView = self.header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID"];
    cell.backgroundColor = [UIColor blackColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"请注意header的博客内容是错误示范";
        cell.textLabel.font = [UIFont systemFontOfSize:20 weight:1];
    } else {
        cell.textLabel.text = @"正确示范请查看footer";
        cell.textLabel.font = [UIFont systemFontOfSize:30 weight:1];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - WKNavigationDelegate
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
//    if (object == self.footer.scrollView && [keyPath isEqual:@"contentSize"]) {
//        self.footer.height = self.footer.scrollView.contentSize.height;
//        self.tableView.tableFooterView = self.footer;
//    } else
        if (object == self.header.scrollView && [keyPath isEqual:@"contentSize"]) {
        self.header.height = self.header.scrollView.contentSize.height;
            self.tableView.tableHeaderView = self.header;
    }
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kSafeAreaTopHeight, kScreenWidth, kScreenHeight - kSafeAreaBottomHeight - kSafeAreaTopHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellID"];
    }
    return _tableView;
}

- (WKWebView *)header {
    if (_header == nil) {
        _header = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        [_header.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        _header.scrollView.scrollEnabled = NO;
        _header.userInteractionEnabled = NO;
        [_header loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://t2.fsyuncai.com/h5/orderlist/integralproduct.html?skucode=7100008"]]];
    }
    return _header;
}

//- (GHWebView *)footer {
//    if (_footer == nil) {
//        _footer = [[GHWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
//        [_footer.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
//        [_footer loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jianshu.com/p/3e641cfaf5f1"]]];
//    }
//    return _footer;
//}

@end
