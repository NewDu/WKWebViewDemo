//
//  DJWebKitViewController.m
//  WKWebViewDemo
//
//  Created by world on 16/10/11.
//  Copyright © 2016年 Dujiao. All rights reserved.
//

#import "DJWebKitViewController.h"
#import <WebKit/WebKit.h>


#define WindowWidth MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define WindowHeight MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define WebViewContext @"WebViewContext"

@interface DJWebKitViewController () <WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign) CGFloat webViewContentHeight;
@end

@implementation DJWebKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNavigationView];
    [self initWebView];
}

- (void)createNavigationView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindowWidth, 64)];
    headerView.backgroundColor = [UIColor colorWithRed:0.18f green:0.18f blue:0.19f alpha:1.00f];
    [self.view addSubview:headerView];
    
    CGRect leftItemRect = CGRectMake(0, 20, 44, 44);
    UIButton* leftItem = [[UIButton alloc]  initWithFrame:leftItemRect];
    [leftItem setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
    [leftItem addTarget:self action:@selector(leftButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:leftItem];
    
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(60, 20, WindowWidth-120, 44)];
    title.text = @"WKWebView简单使用";
    title.font = [UIFont systemFontOfSize:16];
    title.textColor = [UIColor whiteColor];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:title];
}


- (void)initWebView {
    
    NSString *htmlString = @"<body topmargin=2 leftmargin=2 bgcolor=#ffffff><base target=_blank><div>  <p>每个人都曾有过英勇的姿势，或许是进球的瞬间、或许是霸气的灌篮、或许帅气的投篮，</br>秀出你珍藏的照片，让更多人#看我英勇的姿势#</P><p>活动时间：10月15日~10月20日</p><p>开奖时间：10月21日</p><p>活动奖品</p><img src='http://cloud-images.oss-cn-hangzhou.aliyuncs.com/card_img/activity-rules/ruels1.jpg'  border='0'><p>评选标准：评审团将根据图片质量和内容进行考核，评选出三名“最帅姿势奖”</br>我们会在活动结束后10月21日在本活动中进行结果公示，并通过站内消息通知中奖用户，</br>欢迎届关注哦~</P></div></body>";
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(5, 64+10, WindowWidth-10, 150)];
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.layer.borderWidth = 0.5;
    self.webView.layer.borderColor = [UIColor grayColor].CGColor;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.directionalLockEnabled = NO;
    self.webView.scrollView.scrollsToTop = NO;
    self.webView.scrollView.userInteractionEnabled = NO;
    self.webView.navigationDelegate = self;
    [self.webView loadHTMLString:htmlString baseURL:nil];
    [self.webView addObserver:self forKeyPath:@"scrollView.contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"DJWebKitContext"];
    [self.view addSubview:self.webView];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSString *contextString = (__bridge NSString *)context;
    if (!self.webView.isLoading && [contextString isEqualToString:@"DJWebKitContext"]) {
        if([keyPath isEqualToString:@"scrollView.contentSize"])
        {
            self.webViewContentHeight = self.webView.scrollView.contentSize.height;
            CGRect frame = self.webView.frame;
            frame.size.height = self.webViewContentHeight;
            self.webView.frame = frame;
            [self.webView sizeToFit];
        }
    }
}


#pragma mark - UI事件
- (void)leftButtonPressed:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    //self.webViewContentHeight = self.webView.scrollView.contentSize.height; //获取不到contentSize, 使用KVO
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"scrollView.contentSize" context:@"DJWebKitContext"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
