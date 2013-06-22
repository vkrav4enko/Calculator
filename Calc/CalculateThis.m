//
//  CalculateThis.m
//  Calc
//
//  Created by Владимир on 21.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import "CalculateThis.h"

@interface CalculateThis ()

@property (nonatomic) NSNumber *tempValue;
@property (nonatomic) NSString *operation;

@end

@implementation CalculateThis

@synthesize result;
@synthesize accumulator;




- (void)input: (NSString *)value {
    if ([value isEqualToString:@"+"] || [value isEqualToString:@"-"] || [value isEqualToString:@"*"] || [value isEqualToString:@"/"]) {
        _operation = value;
    } else if  ([value isEqualToString:@"="]){
        
    } else {
        if (_tempValue) {
            if ([_operation isEqualToString:@"+"]) {
                result = [_tempValue doubleValue] + [value doubleValue];
            } else if ([_operation isEqualToString:@"-"]) {
                result = [_tempValue doubleValue] - [value doubleValue];
            } else if ([_operation isEqualToString:@"*"]) {
                result = [_tempValue doubleValue] * [value doubleValue];
            } else if ([_operation isEqualToString:@"/"]) {
                result = [_tempValue doubleValue] / [value doubleValue];
            }
            _tempValue = nil;
        } else {
            _tempValue = @([value doubleValue]);
        }
    }
}

@end
