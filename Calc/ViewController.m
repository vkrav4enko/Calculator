//
//  ViewController.m
//  Calc
//
//  Created by Владимир on 21.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//


#import "CalculateThis.h"
#import "ViewController.h"
#import "AppDelegate.h"
#define DegreesToRadians(x) ((x) * M_PI / 180.0)
NSUInteger const BinButtonTag = 100;

@interface ViewController () <CalcThisDelegate>

@property (nonatomic, strong) CalculateThis *calculateThis;
@property (nonatomic) BOOL afterEqualWasPressed;
@property (nonatomic, strong) ViewController *lController;
@property (nonatomic) UIButton * buttonSelect;

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
    
    if([sender.titleLabel.text isEqualToString:@"bin"] || [sender.titleLabel.text isEqualToString:@"dec"] ||[sender.titleLabel.text isEqualToString:@"oct"] ||[sender.titleLabel.text isEqualToString:@"hex"])
    {
        _buttonSelect.selected = NO;
        _buttonSelect = sender;
        _buttonSelect.selected = YES;
        
        [_calculateThis changeNumeralSystem:_textField.text];
        [_calculateThis changeNumeralSystem:sender.titleLabel.text];
        _afterEqualWasPressed = YES;
        return;
    }
   
    
    if(_afterEqualWasPressed)
    {
        _buttonSelect.selected = NO;
        _textField.text = @"";
        [_calculateThis input:@"CE"];
    }
    _afterEqualWasPressed = NO;
    
    if([sender.titleLabel.text isEqualToString:@"C"])
    {
        _textField.text = @"";
        return;
    }
    

    
    
    
       
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
    
    _buttonSelect.selected = NO;
    _afterEqualWasPressed = NO;
    [_calculateThis input:_textField.text];
    [_calculateThis input:sender.titleLabel.text];
    
    
}

#pragma mark - CalcDelegate

- (void)calculator:(CalculateThis *)calculator
         putResult:(double)result {
        
    _textField.text = [@(result) stringValue];
}

-(void) calculator: (CalculateThis *) calculator
           putText: (NSString *) text {
    
    _textField.text = text;
}

-(void) calculatorClear:(CalculateThis *)calculator {
    _textField.text = @"";
}

-(void) equalWasPressed:(CalculateThis *)calculator {
    _afterEqualWasPressed = YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait ||
        toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
    
        CGAffineTransform transform = CGAffineTransformMakeScale(1, 1.8);
        [_portretView setTransform:transform];              
       
    }
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        CGAffineTransform transform = CGAffineTransformMakeScale(1, 1);
        [_portretView setTransform:transform];
    }
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft |
            UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortraitUpsideDown);
}
    




    
    




@end
