//
//  BaseModelObject.m
//  Demo
//
//  Created by xiaoming on 15/11/9.
//  Copyright © 2015年 dandanshan. All rights reserved.
//  使用方法在TestModelObject里面

#import "BaseModelObject.h"
#import <objc/runtime.h>    //归档、解档 需要。

@implementation BaseModelObject

#pragma mark - 初始化 model
+ (instancetype)modelWithDictionary: (NSDictionary *) data{
    
    return [[self alloc] initWithDictionary:data];
    
}

- (instancetype)initWithDictionary: (NSDictionary *) data{
    {
        self = [super init];
        if (self) {
            if ([self propertyMapDic] == nil) {
                [self assginToPropertyWithDictionary:data];
            } else {
                [self assginToPropertyWithNoMapDictionary:data];
            }
        }
        return self;
    }
}

#pragma 返回属性和字典key的映射关系---如果后台返回的和自己的属性不同的话，需要在自己的model 里面 加入这个方法。返回字典。
-(NSDictionary *) propertyMapDic{
    return nil;
}

#pragma mark -- 通过字符串来创建该字符串的Setter方法，并返回
- (SEL) creatSetterWithPropertyName: (NSString *) propertyName {
    //1.首字母大写
    if (!propertyName || [propertyName isEqualToString:@""]) {
        return nil;
    }
    //直接用 capitalizedString  的话，会把后面所有的都变成小写。
    NSString *firstStirng = [propertyName substringToIndex:1];
    NSString *lastString = [propertyName substringFromIndex:1];
    propertyName = [NSString stringWithFormat:@"%@%@",firstStirng.capitalizedString,lastString];
    //2.拼接上set关键字
    propertyName = [NSString stringWithFormat:@"set%@:", propertyName];
    //3.返回set方法
    return NSSelectorFromString(propertyName);
}

/************************************************************************
 *把字典赋值给当前实体类的属性
 *参数：字典
 *适用情况：当网络请求的数据的key与实体类的属性相同时可以通过此方法吧字典的Value
 *        赋值给实体类的属性
 ************************************************************************/

-(void) assginToPropertyWithDictionary: (NSDictionary *) data{
    if (data == nil) {
        return;
    }
    ///1.获取字典的key
    NSArray *dicKey = [data allKeys];
    
    ///2.循环遍历字典key, 并且动态生成实体类的setter方法，把字典的Value通过setter方法
    ///赋值给实体类的属性
    for (int i = 0; i < dicKey.count; i ++) {
        
        ///2.1 通过getSetterSelWithAttibuteName 方法来获取实体类的set方法
        SEL setSel = [self creatSetterWithPropertyName:dicKey[i]];
        
        if ([self respondsToSelector:setSel]) {
            ///2.2 获取字典中key对应的value
            NSString  *value = [NSString stringWithFormat:@"%@", data[dicKey[i]]];
            ///2.3 把值通过setter方法赋值给实体类的属性
            [self performSelectorOnMainThread:setSel
                                   withObject:value
                                waitUntilDone:[NSThread isMainThread]];
        }
    }
}

#pragma 根据映射关系来给Model的属性赋值
-(void) assginToPropertyWithNoMapDictionary: (NSDictionary *) data{
    ///获取字典和Model属性的映射关系
    NSDictionary *propertyMapDic = [self propertyMapDic];
    ///转化成key和property一样的字典，然后调用assginToPropertyWithDictionary方法
    NSArray *dicKey = [data allKeys];
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithCapacity:dicKey.count];
    for (int i = 0; i < dicKey.count; i ++) {
        NSString *key = dicKey[i];
        [tempDic setObject:data[key] forKey:propertyMapDic[key]];
    }
    [self assginToPropertyWithDictionary:tempDic];
}

#pragma mark - 归档、解档。----子类要想 可以缓存，必须重写 这两个方法。

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([BaseModelObject class], &count);
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
        Ivar *ivars = class_copyIvarList([BaseModelObject class], &count);
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
@end
