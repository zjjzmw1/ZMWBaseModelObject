//
//  TestModelObject.h
//  Demo
//
//  Created by xiaoming on 15/11/9.
//  strongright © 2015年 dandanshan. All rights reserved.
//

#import "BaseModelObject.h"

@interface TestModelObject : BaseModelObject

@property (nonatomic, strong) NSString *boy1;
@property (nonatomic, strong) NSString *boy2;
@property (nonatomic, strong) NSString *boy3;
@property (nonatomic, strong) NSString *boy4;
@property (nonatomic, strong) NSString *ageString;      ///其实从后台返回的都是字符串，用的时候，自己再转回int ，或者 float

@end

/**
    下面是用法。
 */
//NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:11];
//
////创建测试适用的字典
//for(int i = 1; i <= 2; i ++){
//    NSString *key = [NSString stringWithFormat:@"boy%d", i];
//    NSString *value = [NSString stringWithFormat:@"boyValue%d", i];
//    [dict setObject:value forKey:key];
//}
//[dict setObject:@"20" forKey:@"ageString"];
//NSLog(@"dict====%@",dict);
//TestModelObject *testModel0 = [TestModelObject modelWithDictionary:dict];
//NSLog(@"====%@,%@",testModel0.boy1,testModel0.ageString);


/**
 *  缓存model 的方法 。
 */
//    TestModelObject *testModel = [TestModelObject modelWithDictionary:dict];
//    NSMutableArray * dataArray = [NSMutableArray arrayWithCapacity:50];
//    //将testModel类型变为NSData类型
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:testModel];
//    //存放数据的数组将data加入进去
//    [dataArray addObject:data];
//    //记住要转换成不可变数组类型
//    NSArray * array = [NSArray arrayWithArray:dataArray];
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    [user setObject:array forKey:@"testModelArray"];
//    NSArray *resultArray = [user objectForKey:@"testModelArray"];
//    TestModelObject *resultModel = [NSKeyedUnarchiver unarchiveObjectWithData:[resultArray objectAtIndex:0]];
//    NSLog(@"====%@,%@",resultModel.boy1,resultModel.boy4);