//
//  CalculateThis.h
//  Calc
//
//  Created by Владимир on 21.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculateThis : NSObject

@property(nonatomic) double result;
@property(nonatomic) double accumulator;
-(double) calculateResult: (int) operation;


@end
