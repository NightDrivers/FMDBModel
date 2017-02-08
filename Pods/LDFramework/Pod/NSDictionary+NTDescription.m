//
//  NSDictionary+NTDescription.m
//  netTaxi_dirver
//
//  Created by lindechun on 16/10/18.
//  Copyright © 2016年 lindechun. All rights reserved.
//

#import "NSDictionary+NTDescription.h"

@implementation NSDictionary (NTDescription)

- (NSString *)NTDescription {
    
    NSMutableString *mStr = [[NSMutableString alloc] init];
    for (NSString *key in self) {
        [mStr appendString:[NSString stringWithFormat:@"-键:%@-类:%@-值:%@-\n",key,[self[key] class],self[key]]];
    }
    return mStr;
}

- (NSString *)urlDataString {
    
    NSMutableArray<NSString *> *mArray = [[NSMutableArray alloc] init];
    for (NSString *key in self) {
        [mArray addObject:[NSString stringWithFormat:@"%@=%@",key,self[key]]];
    }
    NSString *tempString = [mArray componentsJoinedByString:@"&"];
    return [tempString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

@end
