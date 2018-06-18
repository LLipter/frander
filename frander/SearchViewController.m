//
//  SearchViewController.m
//  frander
//
//  Created by irran on 2018/6/14.
//  Copyright © 2018 LLipter. All rights reserved.
//

#import "SearchViewController.h"
#import <WebKit/WebKit.h>

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webpage;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL* url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webpage loadRequest:request];
    //NSHTTPURLResponse *response;
    //[NSURLConnection sendSynchronousRequest: request returningResponse: &response error: nil];
    //NSLog(@"resp code %d",response.statusCode);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
