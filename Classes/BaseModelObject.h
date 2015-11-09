//
//  BaseModelObject.h
//  Demo
//
//  Created by xiaoming on 15/11/9.
//  Copyright © 2015年 dandanshan. All rights reserved.
//  利用Runtime给Model赋值、归档、解档

#import <Foundation/Foundation.h>

@interface BaseModelObject : NSObject<NSCoding>

///传入字典，返回model
+ (instancetype)modelWithDictionary: (NSDictionary *) data;

@end
