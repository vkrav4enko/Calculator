//
//  CalculateThis.m
//  Calc
//
//  Created by Владимир on 21.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import "CalculateThis.h"



@interface CalculateThis ()
{
    double result;
}

@property (nonatomic) NSNumber *tempValue;
@property (nonatomic) NSString *operation;
@property (nonatomic) BOOL triger;


@end

@implementation CalculateThis


- (void)input: (NSString *)value {
    
    
    
    if ([value isEqualToString:@"+"] || [value isEqualToString:@"-"] || [value isEqualToString:@"*"] || [value isEqualToString:@"/"]) {
        
        if (_triger){
            if ([_operation isEqualToString:@"+"])
            _tempValue = @(result - [_tempValue doubleValue]);
            if ([_operation isEqualToString:@"-"])
                _tempValue = @(result + [_tempValue doubleValue]);
            if ([_operation isEqualToString:@"*"])
                _tempValue = @(result / [_tempValue doubleValue]);
            if ([_operation isEqualToString:@"/"])
                _tempValue = @(result * [_tempValue doubleValue]);
        }
        _operation = value;
        _triger = NO;
        if (_delegate && [_delegate respondsToSelector:@selector(calculatorClear:)]) {
            [_delegate calculatorClear:self];
        }
    } else if  ([value isEqualToString:@"="]){
        if (_delegate && [_delegate respondsToSelector:@selector(equalWasPressed:)]) {
            [_delegate equalWasPressed:self];
        }

    } else if([value isEqualToString:@"C"]){
        if (_delegate && [_delegate respondsToSelector:@selector(calculatorClear:)]) {
            [_delegate calculatorClear:self];
        }
        }else if ([value isEqualToString:@"CE"]){
            if (_delegate && [_delegate respondsToSelector:@selector(calculatorClear:)]) {
                [_delegate calculatorClear:self];
            }
            _operation = @"";
            _tempValue = nil;
            result = 0;
            _triger = NO;
        }else
            
        {
            if (_tempValue) {
                if (![value isEqualToString:@""])
                {
                    if ([_operation isEqualToString:@"+"]) {
                        result = [_tempValue doubleValue] + [value doubleValue];
                    } else if ([_operation isEqualToString:@"-"]) {
                        if(!_triger)
                            result = [_tempValue doubleValue] - [value doubleValue];
                        else
                            result = [value doubleValue] - [_tempValue doubleValue];
                    } else if ([_operation isEqualToString:@"*"]) {
                        result = [_tempValue doubleValue] * [value doubleValue];
                    } else if ([_operation isEqualToString:@"/"]) {
                        if(!_triger)
                            result = [_tempValue doubleValue] / [value doubleValue];
                        else
                            result = [value doubleValue] / [_tempValue doubleValue];
                    }
                    
                    if (!_triger)
                        _tempValue = nil;
                    
                    if (_delegate && [_delegate respondsToSelector:@selector(calculator:putResult:)]) {
                        [_delegate calculator:self putResult:result];
                    }
                }
                else
                {
                    _triger = YES;
                    if ([_operation isEqualToString:@"+"]) {
                        result = [_tempValue doubleValue] + [_tempValue doubleValue];
                    } else if ([_operation isEqualToString:@"-"]) {
                        result = [_tempValue doubleValue] - [_tempValue doubleValue];
                    } else if ([_operation isEqualToString:@"*"]) {
                        result = [_tempValue doubleValue] * [_tempValue doubleValue];
                    } else if ([_operation isEqualToString:@"/"]) {
                        result = [_tempValue doubleValue] / [_tempValue doubleValue];
                    }
                    
                    
                    if (_delegate && [_delegate respondsToSelector:@selector(calculator:putResult:)]) {
                        [_delegate calculator:self putResult:result];
                    }
                    
                }
                
            } else {
                _tempValue = @([value doubleValue]);
            }
        }



    
}

@end
