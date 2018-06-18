//
//  DetailContactsViewController.m
//  frander
//
//  Created by irran on 2018/6/14.
//  Copyright © 2018 LLipter. All rights reserved.
//

#import "DetailContactsViewController.h"
#import "NewContactsViewController.h"
#import "NavigationViewControl.h"

@interface DetailContactsViewController ()

@end

@implementation DetailContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    self.name.text = self.currentContact.name;
    self.phone.text = self.currentContact.phone;
    self.address.text = self.currentContact.address;
}
- (IBAction)deletePressed:(UIButton *)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Delete this contact"message:@"Are you sure you're going to delete this contact?"preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self.currentContact remove];
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"action = %@", action);
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        // do nothing
        NSLog(@"action = %@", action);
        
    }];
    
    [alert addAction:confirmAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];  
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"ModifyContact"]){
        NavigationViewControl* contactController = segue.destinationViewController;
        contactController.currentContact = self.currentContact;
        contactController.isOld = YES;
    }
}

- (IBAction)sharePressed:(UIButton *)sender {
    NSString *title = @"Contact";
    NSString *name = self.currentContact.name;
    NSString *phone = self.currentContact.phone;
    NSString *address = self.currentContact.address;
    //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
    NSArray *activityItems = @[title,name,phone,address];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
    // 分享之后的回调
    activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
        if (completed) {
            NSLog(@"completed");
            //分享 成功
        } else  {
            NSLog(@"cancled");
            //分享 取消
        }
    };
}


@end
