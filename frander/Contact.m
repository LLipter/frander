//
//  Contact.m
//  frander
//
//  Created by irran on 2018/6/14.
//  Copyright © 2018 LLipter. All rights reserved.
//

#import "Contact.h"
#import "DatabaseUtility.h"

@implementation Contact

-(void)insert{
    //插入对象的SQL语句
    NSString *insertSQL = [NSString stringWithFormat:@"INSERT INTO contacts (name,phone,address) VALUES ('%@','%@','%@')",self.name,self.phone,self.address];
    NSLog(@"%@",insertSQL);
    printf("!!!!!!!!inserting\n");
    if ([[DatabaseUtility shareInstance] execSQL:insertSQL]) {
        NSLog(@"insert successfully");
    }
    
}

-(void)update{
    //更新对应的SQL语句
    NSString *SQL = [NSString stringWithFormat:@"UPDATE contacts SET name='%@',phone='%@',address='%@' WHERE contact_id = %d",self.name,self.phone,self.address,self.contact_id];
    NSLog(@"%@",SQL);
    if ([[DatabaseUtility shareInstance] execSQL:SQL]) {
        NSLog(@"对应数据修改成功");
    }
}

-(void)remove{
    NSString *SQL = [NSString stringWithFormat:@"DELETE FROM contacts WHERE contact_id = %d",self.contact_id];
    NSLog(@"%@",SQL);
    if ([[DatabaseUtility shareInstance] execSQL:SQL]) {
        NSLog(@"对应数据删除成功");
    }
}

+(instancetype)initWithDict:(NSDictionary*)dict{
    Contact* ret = [[Contact alloc] init];
    ret.contact_id = [[dict valueForKey:@"contact_id"]intValue];
    ret.name = [dict valueForKey:@"name"];
    ret.phone = [dict valueForKey:@"phone"];
    ret.address = [dict valueForKey:@"address"];
    return ret;
}

+(NSArray *)allContactFromDB{
    //查询表中所有数据的SQL语句
    NSString *SQL = @"SELECT * FROM contacts ORDER BY name";
    //取出数据库用户表中所有数据
    NSArray *allContactDictArr = [[DatabaseUtility shareInstance] querySQL:SQL];
    
    //将字典数组转化为模型数组
    NSMutableArray *modelArrM = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in allContactDictArr) {
        [modelArrM addObject:[Contact initWithDict:dict]];
    }
    return modelArrM;
}

-(NSString*) description{
    return [NSString stringWithFormat:@"id:%d,name:%@,phone:%@,address:%@",self.contact_id,self.name,self.phone,self.address];
}
@end
