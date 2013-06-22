//
//  ViewController.m
//  Calc
//
//  Created by Владимир on 21.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//


#import "CalculateThis.h"
#import "ViewController.h"

@interface ViewController () <CalcThisDelegate>

@property (nonatomic, strong) CalculateThis *calculateThis;
@property (nonatomic) BOOL afterEqualWasPressed;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _textField.text = @"0";
	// Do any additional setup after loading the view, typically from a nib.
    
    _calculateThis = [[CalculateThis alloc] init];
    _calculateThis.delegate = self; 
  
 
  

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)numberPressed:(UIButton *)sender {
    if(_afterEqualWasPressed)
    {
        _textField.text = @"";
        [_calculateThis input:@"CE"];
    }
    _afterEqualWasPressed = NO;
       
    if ( [_textField.text rangeOfString:@"."].location !=NSNotFound && [sender.titleLabel.text isEqualToString:@"."])
    {
                return;
         
    }
    
    if([sender.titleLabel.text isEqualToString:@"+/-"]){
        if([_textField.text rangeOfString:@"-"].location != NSNotFound)
            _textField.text = [_textField.text substringFromIndex:1];
        else
            _textField.text = [@"-" stringByAppendingString:_textField.text];
        return;
    }
    
    if ([_textField.text isEqualToString:@"0"]) {
        if(![sender.titleLabel.text isEqualToString:@"."]){
            _textField.text = @"";
        }
    }
    
    _textField.text = [_textField.text stringByAppendingString: sender.titleLabel.text];
    
}
    
- (IBAction)operatorPressed:(UIButton *)sender
{
    _afterEqualWasPressed = NO;
    [_calculateThis input:_textField.text];
    [_calculateThis input:sender.titleLabel.text];
    
}

#pragma mark - CalcDelegate

- (void)calculator:(CalculateThis *)calculator
         putResult:(double)result {
        
    _textField.text = [@(result) stringValue];
}

-(void) calculatorClear:(CalculateThis *)calculator {
    _textField.text = @"";
}

-(void) equalWasPressed:(CalculateThis *)calculator {
    _afterEqualWasPressed = YES;
}
@end
