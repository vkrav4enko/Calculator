//
//  CalculateThis.m
//  Calc
//
//  Created by Владимир on 21.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import "CalculateThis.h"

@implementation CalculateThis

@synthesize result;
@synthesize accumulator;

-(double)calculateResult:(int)operation
{
    if (operation == 0)
        result = accumulator;
    else{
        switch (operation) {
            case 1:
                result += accumulator;
                break;
            case 2:
                result -= accumulator;
                break;
            case 3:
                result *= accumulator;
                break;
            case 4:
                result /= accumulator;
                break;
            case 5:
                result = -result;
                break;
            default:
                break;
        }
    }
    return result;
}

@end
