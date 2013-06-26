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
@property (nonatomic) NSString * numeralSystem;
@property (nonatomic) NSString *tempStr;


@end

@implementation CalculateThis


- (void)input: (NSString *)value {
    
    NSNumberFormatter * isNumberInValue = [[NSNumberFormatter alloc]init];
    [isNumberInValue setLocale: [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"]];
    if([isNumberInValue numberFromString:value] == nil && ![value isEqualToString:@""])
    {
        [self changeOperation:value];
    }
    else if (_tempValue)
    {
        [self calculateResult:value];
    }
    else
    {
        _tempValue = @([value doubleValue]);
    }
}

-(void)changeOperation:(NSString *)value {
    
    if ([value isEqualToString:@"="])
    {
        if (_delegate && [_delegate respondsToSelector:@selector(equalWasPressed:)]) {
            [_delegate equalWasPressed:self];
        }
    }
    else if ([value isEqualToString:@"CE"])
    {
        if (_delegate && [_delegate respondsToSelector:@selector(calculatorClear:)]) {
            [_delegate calculatorClear:self];
        }
        _operation = @"";
        _tempValue = nil;
        result = 0;
        _triger = NO;
        _tempStr = @"";
        _numeralSystem = @"";
    }
    else if ([value isEqualToString:@"sqrt"])
    {
        if (_delegate && [_delegate respondsToSelector:@selector(calculator:putResult:)]) {
            [_delegate calculator:self putResult:sqrt([_tempValue doubleValue])];
            if (_delegate && [_delegate respondsToSelector:@selector(equalWasPressed:)]) {
                [_delegate equalWasPressed:self];
            }
            _tempValue = nil;
            
        }
        

    }
    else if([value isEqualToString:@"log"])
    {
        if (_delegate && [_delegate respondsToSelector:@selector(calculator:putResult:)]) {
            [_delegate calculator:self putResult:log([_tempValue doubleValue])];
            if (_delegate && [_delegate respondsToSelector:@selector(equalWasPressed:)]) {
                [_delegate equalWasPressed:self];
            }            
        }
        _tempValue = nil;
        

    }
    else
    {
        if (_triger){
            if ([_operation isEqualToString:@"+"])
                _tempValue = @(result - [_tempValue doubleValue]);
            if ([_operation isEqualToString:@"-"])
                _tempValue = @(result + [_tempValue doubleValue]);
            if ([_operation isEqualToString:@"*"])
                _tempValue = @(result / [_tempValue doubleValue]);
            if ([_operation isEqualToString:@"/"])
                _tempValue = @(result * [_tempValue doubleValue]);
            if([_operation isEqualToString:@"x^y"])
                _tempValue = @(sqrt(result));
            if([_operation isEqualToString:@"yrt"])
                _tempValue = @(pow(result,2));
        }
        _operation = value;
        _triger = NO;
        if (_delegate && [_delegate respondsToSelector:@selector(calculatorClear:)]) {
            [_delegate calculatorClear: self];
        }

        
    }
}

- (void)calculateResult:(NSString *)value {
    
    if (![value isEqualToString:@""])
    {
        if ([_operation isEqualToString:@"x^y"]) {
            if(!_triger)
                result = pow( [_tempValue doubleValue], [value doubleValue]);
            else
                result = pow([value doubleValue], 2);
        } else if ([_operation isEqualToString:@"yrt"]) {
            if(!_triger)
                result = pow([_tempValue doubleValue] , ( 1/[value doubleValue]));
            else
                result = sqrt([value doubleValue]);
        } else if ([_operation isEqualToString:@"+"]) {
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
        if ([_operation isEqualToString:@"x^y"]) {
            result = pow([_tempValue doubleValue] , 2);
        } else if ([_operation isEqualToString:@"yrt"]) {
            result = sqrt([_tempValue doubleValue]);
        } else if ([_operation isEqualToString:@"+"]) {
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

    
}

- (void)changeNumeralSystem:(NSString *)value
{
    if([value isEqualToString:@"bin"])
    {
        if([_numeralSystem isEqualToString:@"bin"])
            return;
        
        if ([_numeralSystem isEqualToString:@"oct"])
        {
            _tempStr = [NSString stringWithFormat:@"%ld", strtol(_tempStr.UTF8String, NULL, 8)];
        }
        
        if ([_numeralSystem isEqualToString:@"hex"])
        {
            _tempStr = [NSString stringWithFormat:@"%ld", strtol(_tempStr.UTF8String, NULL, 16)];
        }
        
        NSMutableString *str =[[NSMutableString alloc] init];
        for(NSInteger numberCopy = [_tempStr integerValue]; numberCopy > 0; numberCopy >>= 1)
        {
            // Prepend "0" or "1", depending on the bit
            [str insertString:((numberCopy & 1) ? @"1" : @"0") atIndex:0];
        }
        _tempStr = str;
        
        _numeralSystem = @"bin";
               
        
    } else if([value isEqualToString:@"oct"])
    {
        if([_numeralSystem isEqualToString:@"oct"])
            return;
        
        if([_numeralSystem isEqualToString:@"bin"])
        {
            _tempStr = [NSString stringWithFormat:@"%ld", strtol(_tempStr.UTF8String, NULL, 2)];
        }
        
        if ([_numeralSystem isEqualToString:@"hex"])
        {
            _tempStr = [NSString stringWithFormat:@"%ld", strtol(_tempStr.UTF8String, NULL, 16)];
        }
        
        _tempStr = [NSString stringWithFormat:@"%o", [_tempStr integerValue]];
        _numeralSystem = @"oct";
        
        
    } else if([value isEqualToString:@"hex"])
    {
        if([_numeralSystem isEqualToString:@"hex"])
            return;
        
        if([_numeralSystem isEqualToString:@"bin"])
        {
            _tempStr = [NSString stringWithFormat:@"%ld", strtol(_tempStr.UTF8String, NULL, 2)];
        }
        
        if ([_numeralSystem isEqualToString:@"oct"])
        {
            _tempStr = [NSString stringWithFormat:@"%ld", strtol(_tempStr.UTF8String, NULL, 8)];
        }
        
        _tempStr = [NSString stringWithFormat:@"%x", [_tempStr integerValue]];
        _numeralSystem = @"hex";
        
        
    }else if([value isEqualToString:@"dec"])
    {
        if ([_numeralSystem isEqualToString:@"dec"])
            return;
        
        if([_numeralSystem isEqualToString:@"bin"])
        {
            _tempStr = [NSString stringWithFormat:@"%ld", strtol(_tempStr.UTF8String, NULL, 2)];
        }
        
        if ([_numeralSystem isEqualToString:@"oct"])
        {
            _tempStr = [NSString stringWithFormat:@"%ld", strtol(_tempStr.UTF8String, NULL, 8)];
        }
        
        if ([_numeralSystem isEqualToString:@"hex"])
        {
            _tempStr = [NSString stringWithFormat:@"%ld", strtol(_tempStr.UTF8String, NULL, 16)];
        }
        _numeralSystem = @"dec";
        
    }       
    else
    {
        _tempStr = value;
    }
   
    if (_delegate && [_delegate respondsToSelector:@selector(calculator:putText:)])
    {
        [_delegate calculator:self putText:_tempStr];
    }


    
}


    


@end
