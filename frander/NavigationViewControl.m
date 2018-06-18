//
//  NavigationViewControl.m
//  frander
//
//  Created by irran on 2018/6/15.
//  Copyright © 2018 LLipter. All rights reserved.
//

#import "NavigationViewControl.h"
#import "NewContactsViewController.h"

@interface NavigationViewControl ()

@end

@implementation NavigationViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NewContactsViewController* controller = [self.viewControllers objectAtIndex:0];
    controller.currentContact = self.currentContact;
    controller.isOld = self.isOld;
    controller.phoneStr = self.phone;
    NSLog(@"navigation : %@ ",self.isOld?@"old":@"new");
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
