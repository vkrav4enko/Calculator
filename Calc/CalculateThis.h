//
//  CalculateThis.h
//  Calc
//
//  Created by Владимир on 21.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//



#import <Foundation/Foundation.h>

@class CalculateThis;

@protocol CalcThisDelegate <NSObject>
@optional
- (void)calculator:(CalculateThis *)calculator
         putResult:(double) result;
- (void)calculatorClear: (CalculateThis *)calculator;
- (void)equalWasPressed: (CalculateThis *)calculator;
- (void)calculator:(CalculateThis *)calculator
         putText:(NSString*) text;

@end


@interface CalculateThis : NSObject

@property (nonatomic, weak) id<CalcThisDelegate> delegate;



- (void) input: (NSString *)value;
- (void) changeOperation: (NSString *) value;
- (void) calculateResult: (NSString *) value;
- (void) changeNumeralSystem: (NSString *) value;


@end
