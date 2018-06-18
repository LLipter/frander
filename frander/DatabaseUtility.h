//
//  DatabaseUtility.h
//  frander
//
//  Created by irran on 2018/6/14.
//  Copyright © 2018 LLipter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Contact.h"

@interface DatabaseUtility : NSObject

@property (nonatomic) sqlite3* db;

+(instancetype)shareInstance;
-(BOOL)openDB;
-(BOOL)creatTable;
-(BOOL)execSQL:(NSString *)SQL;
-(NSArray *)querySQL:(NSString *)SQL;
-(BOOL)insertInitContact;

@end
