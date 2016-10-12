//
//  ViewController.m
//  WKWebViewDemo
//
//  Created by world on 16/10/11.
//  Copyright © 2016年 EllaDu. All rights reserved.
//

#import "ViewController.h"
#import "DJWebKitViewController.h"


@interface ViewController () 

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 100, 200, 50);
    [button setTitle:@"进入WKWebView页面" forState:UIControlStateNormal];
    [button setTintColor:[UIColor whiteColor]];
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(navigateToWebKitViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)navigateToWebKitViewController:(UIButton *)sender {
    DJWebKitViewController *webKitVC = [[DJWebKitViewController alloc] init];
    [self.navigationController pushViewController:webKitVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
