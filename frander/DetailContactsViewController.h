//
//  DetailContactsViewController.h
//  frander
//
//  Created by irran on 2018/6/14.
//  Copyright © 2018 LLipter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface DetailContactsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *address;

@property (strong,nonatomic) Contact* currentContact;

@end
