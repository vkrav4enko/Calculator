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

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _textField.text = @"0";
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

 /*
-(IBAction)numberPressed:(id)sender
{

    if([sender tag] != 11){
    _textField.text = [NSString stringWithFormat:@"%@%d", _textField.text.lowercaseString, (int)[sender tag]];
        
        
    }
    else {
        _textField.text = [NSString stringWithFormat:@"%@%@", _textField.text, @"."];
    }
    
    
    
    _number = [_textField.text doubleValue];
    
    _textField.text = [NSString stringWithFormat:@"%2f",_number];
}
*/


-(IBAction)numberPressed:(id)sender
{
    _number = _number*10 + (float)[sender tag];
    
    _textField.text = [NSString stringWithFormat:@"%2f",_number];
}

-(IBAction)operatorPressed:(id)sender
{
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

@end
