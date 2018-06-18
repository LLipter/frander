//
//  NavigationViewControl.h
//  frander
//
//  Created by irran on 2018/6/15.
//  Copyright © 2018 LLipter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"

@interface NavigationViewControl : UINavigationController

@property(nonatomic,strong)Contact* currentContact;
@property(nonatomic) BOOL isOld;
@property(nonatomic,strong) NSString* phone;
@end
