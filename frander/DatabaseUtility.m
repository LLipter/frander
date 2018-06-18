//
//  DatabaseUtility.m
//  frander
//
//  Created by irran on 2018/6/14.
//  Copyright © 2018 LLipter. All rights reserved.
//

#import "DatabaseUtility.h"


@implementation DatabaseUtility

static DatabaseUtility *instance = nil;

+(instancetype)shareInstance{
    if(instance != nil)
        return instance;
    return instance = [[self alloc] init];
}

-(BOOL)openDB{
    //app内数据库文件存放路径-一般存放在沙盒中
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *DBPath = [documentPath stringByAppendingPathComponent:@"db.sqlite"];
    NSLog(@"%@",DBPath);
    //创建(指定路径不存在数据库文件)/打开(已存在数据库文件) 数据库文件
    if (sqlite3_open(DBPath.UTF8String, &_db) != SQLITE_OK) {
        //数据库打开失败
        return NO;
    }else{
        //打开成功创建表
        return [self creatTable];
    }
}

-(BOOL)creatTable{
    //创建表的SQL语句
    NSString *creatContactsTable = @"CREATE TABLE IF NOT EXISTS contacts ( contact_id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,phone TEXT,address TEXT);";
    return [self execSQL:creatContactsTable];
}

-(BOOL)insertInitContact{
    NSString *contact1 = @"INSERT INTO contacts(name,phone,address) VALUES('LLipter','18210197614','c4-611');";
    NSString *contact2 = @"INSERT INTO contacts(name,phone,address) VALUES('menhera','1212521','Tokyo');";
    return [self execSQL:contact1] && [self execSQL:contact2];
}

-(BOOL)execSQL:(NSString *)SQL{
    return sqlite3_exec(self.db, SQL.UTF8String, nil, nil, nil) == SQLITE_OK;
}


-(NSArray *)querySQL:(NSString *)SQL{
    //准备查询
    // 1> 参数一:数据库对象
    // 2> 参数二:查询语句
    // 3> 参数三:查询语句的长度:-1
    // 4> 参数四:句柄(游标对象)
    //    sqlite3_prepare_v2(<#sqlite3 *db#>, <#const char *zSql#>, <#int nByte#>, <#sqlite3_stmt **ppStmt#>, <#const char **pzTail#>)
    sqlite3_stmt *stmt = nil;
    if (sqlite3_prepare_v2(self.db, SQL.UTF8String, -1, &stmt, nil) != SQLITE_OK) {
        NSLog(@"准备查询失败!");
        NSLog(@"%@",SQL);
        return NULL;
    }
    //准备成功,开始查询数据
    //定义一个存放数据字典的可变数组
    NSMutableArray *dictArrM = [[NSMutableArray alloc] init];
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        //一共获取表中所有列数(字段数)
        int columnCount = sqlite3_column_count(stmt);
        //定义存放字段数据的字典
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        for (int i = 0; i < columnCount; i++) {
            // 取出i位置列的字段名,作为字典的键key
            const char *cKey = sqlite3_column_name(stmt, i);
            NSString *key = [NSString stringWithUTF8String:cKey];
            
            //取出i位置存储的值,作为字典的值value
            const char *cValue = (const char *)sqlite3_column_text(stmt, i);
            NSString *value = [NSString stringWithUTF8String:cValue];
            
            //将此行数据 中此字段中key和value包装成 字典
            [dict setObject:value forKey:key];
        }
        [dictArrM addObject:dict];
    }
    return dictArrM;
}



@end
