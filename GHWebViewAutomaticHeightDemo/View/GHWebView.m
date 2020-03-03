//
//  GHWebView.m
//  GHWebViewAutomaticHeightDemo
//
//  Created by mac on 2020/2/27.
//  Copyright © 2020 GHome. All rights reserved.
//

#import "GHWebView.h"

@implementation GHWebView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self defaultConfiguration];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame configuration:(WKWebViewConfiguration *)configuration {
    if (self == [super initWithFrame:frame configuration:configuration
                 ]) {
        [self defaultConfiguration];
    }
    return self;
}

- (void)defaultConfiguration {
    self.scrollView.scrollEnabled = NO;
           self.userInteractionEnabled = NO;
           if (@available(iOS 11.0, *)) {
               self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
               self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
               self.scrollView.scrollIndicatorInsets = self.scrollView.contentInset;
           }
}
@end
