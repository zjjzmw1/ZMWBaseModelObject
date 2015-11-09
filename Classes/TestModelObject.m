//
//  TestModelObject.m
//  Demo
//
//  Created by xiaoming on 15/11/9.
//  Copyright © 2015年 dandanshan. All rights reserved.
//

#import "TestModelObject.h"
#import <objc/runtime.h>

@implementation TestModelObject

#pragma mark - 归档、解档。----子类要想 可以缓存，必须重写 这两个方法。
- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([TestModelObject class], &count);
    for (int i = 0; i < count; ++i) {
        //取出i位置对应的成员变量。
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        //归档。
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(ivars);
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([TestModelObject class], &count);
        for (int i = 0; i<count; i++) {
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            // 归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            // 设置到成员变量身上
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}


#pragma 返回属性和字典key的映射关系 如果 属性跟返回的不同的话，，必须保证一一对应了就。    keyBoy1为后台返回的。 boy1 为自己的属性。
//-(NSDictionary *) propertyMapDic{
//    return @{@"keyBoy1":@"boy1",
//             @"keyBoy2":@"boy2",
//             @"keyBoy3":@"boy3",
//             @"keyBoy4":@"boy4",
////             @"keyAge":@"ageString"
//             };
//}

@end
