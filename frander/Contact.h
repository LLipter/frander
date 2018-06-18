//
//  Contact.h
//  frander
//
//  Created by irran on 2018/6/14.
//  Copyright © 2018 LLipter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property (nonatomic) int contact_id;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* phone;
@property (nonatomic,copy) NSString* address;

-(void)insert;
-(void)update;
-(void)remove;
+(instancetype)initWithDict:(NSDictionary*)dict;
+(NSArray *)allContactFromDB;
@end
