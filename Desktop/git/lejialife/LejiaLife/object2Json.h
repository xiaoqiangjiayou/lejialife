//
//  object2Json.h
//  LejiaLife
//
//  Created by 张强 on 16/5/19.
//  Copyright © 2016年 张强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h> 
@interface object2Json : NSObject
+ (NSDictionary*)getObjectData:(id)obj;
+ (NSData*)getJSON:(id)obj options:(NSJSONWritingOptions)options error:(NSError**)error;
+ (id)getObjectInternal:(id)obj ;
@end
