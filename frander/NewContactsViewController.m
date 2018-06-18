//
//  NewContactsViewController.m
//  frander
//
//  Created by irran on 2018/6/14.
//  Copyright © 2018 LLipter. All rights reserved.
//

#import "NewContactsViewController.h"

@interface NewContactsViewController ()


@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigation;

@end

@implementation NewContactsViewController

- (Contact*) currentContact{
    if(_currentContact == nil)
        _currentContact = [[Contact alloc]init];
    return _currentContact;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.isOld?@"old":@"new");
    if(self.isOld == YES){
        self.name.text = self.currentContact.name;
        self.phone.text = self.currentContact.phone;
        self.address.text = self.currentContact.address;
        self.navigation.title = @"Modify Contact";
    }else if(self.phone != nil)
        self.phone.text = self.phoneStr;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)savePressed:(UIBarButtonItem *)sender {
    if([self.name.text isEqual:@""]){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Name can't be empty."message:@""preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [self.currentContact remove];
            [self.navigationController popViewControllerAnimated:YES];
            NSLog(@"action = %@", action);
        }];
        
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        self.currentContact.name = self.name.text;
        self.currentContact.phone = self.phone.text;
        self.currentContact.address = self.address.text;
        if(self.isOld == NO){
            printf("start insert!!!!!\n");
            NSLog(@"%@",self.currentContact);
            [self.currentContact insert];
        }
        
        else
            [self.currentContact update];
        [self dismissViewControllerAnimated:YES completion:nil];
    }

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
