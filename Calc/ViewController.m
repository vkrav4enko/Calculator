//
//  ViewController.m
//  Calc
//
//  Created by Владимир on 21.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import "stdio.h"
#import "CalculateThis.h"
#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) CalculateThis *calculateThis;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _textField.text = @"0";
	// Do any additional setup after loading the view, typically from a nib.
    
    _calculateThis = [[CalculateThis alloc] init];
    
    [_calculateThis input:@"2"];
    [_calculateThis input:@"+"];
    [_calculateThis input:@"10"];
    if (_calculateThis.result == 12) {
        NSLog(@"Ok!");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)numberPressed:(UIButton *)sender {
    if (![_textField.text integerValue]) {
        _textField.text = @"";
    }
    
    _textField.text = [_textField.text stringByAppendingString: sender.titleLabel.text];
    
    //    NSString *digit = sender.titleLabel.text;
//    if (_userIsInTheMiddleOfTypingANumber) {
//        _textField.text = [_textField.text stringByAppendingString:digit];
//    }
//    else
//    {
//        _textField.text = digit;
//        _userIsInTheMiddleOfTypingANumber = YES;
//    }
//    _number = [_textField.text doubleValue];
}

/*
-(IBAction)numberPressed:(id)sender
{
    _number = _number*10 + (float)[sender tag];
    
    _textField.text = [NSString stringWithFormat:@"%2f",_number];
}
*/

-(IBAction)operatorPressed:(UIButton *)sender
{
    if ([sender tag])
    
    [_calculateThis input:_textField.text];
    [_calculateThis input:sender.titleLabel.text];

    if ([sender.titleLabel.text isEqualToString:@"="]) {
        _textField.text = [NSString stringWithFormat:@"%f", _calculateThis.result];
    } else {
        _textField.text = @"";
    }
    
}
/*
    _userIsInTheMiddleOfTypingANumber = NO;
    CalculateThis *calculateThis = [[CalculateThis alloc]init];
    [calculateThis setResult:_result];
    [calculateThis setAccumulator:_number];
    _result = [calculateThis calculateResult: _operation];
    _textField.text = [NSString stringWithFormat:@"%2f", _result];
    _number = 0;
    if ([sender tag] == 0) {
        _result = 0;
    }
    _operation = [sender tag];

}

-(IBAction)numberDelete:(id)sender
{
    _number = 0;
    _textField.text = @"0";
}

- (IBAction) operationCancel:(id)sender
{
    _number = 0;
    _textField.text = @"0";
    _operation = 0;
}
 */
@end
