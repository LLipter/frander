//
//  DialViewController.m
//  frander
//
//  Created by irran on 2018/6/14.
//  Copyright © 2018 LLipter. All rights reserved.
//

#import "DialViewController.h"
#import "NavigationViewControl.h"
#import "Contact.h"

@interface DialViewController ()
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UIButton *addContact;

@end

@implementation DialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btnBack setHidden:true];
    [self.addContact setHidden:true];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)digitPressed:(UIButton *)sender {
    [self.btnBack setHidden:false];
    [self.addContact setHidden:false];
    NSString* digit = [sender currentTitle];
    self.display.text = [self.display.text stringByAppendingString:digit];
}
- (IBAction)backPressed:(UIButton *)sender {
    if(self.display.text.length > 0)
        self.display.text = [self.display.text substringToIndex:self.display.text.length-1];
    if(self.display.text.length == 0){
        [self.addContact setHidden:true];
        [self.btnBack setHidden:true];
    }
    
}
- (IBAction)dialPressed:(UIButton *)sender {
    self.display.text = @"";
    [self.btnBack setHidden:true];
    [self.addContact setHidden:true];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"AddContact"]){
        NavigationViewControl* contactController = segue.destinationViewController;
        NSLog(@"%@",[segue.destinationViewController class]);
        contactController.isOld = NO;
        contactController.phone = self.display.text;
    }
}


@end
