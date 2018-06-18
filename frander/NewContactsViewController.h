//
//  NewContactsViewController.h
//  frander
//
//  Created by irran on 2018/6/14.
//  Copyright © 2018 LLipter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface NewContactsViewController : UIViewController
@property (nonatomic,strong)Contact* currentContact;
@property (nonatomic) BOOL isOld;
@property (nonatomic,strong) NSString* phoneStr;

@end
