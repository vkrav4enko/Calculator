//
//  ViewController.h
//  Calc
//
//  Created by Владимир on 21.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic) double result;
@property (nonatomic) double number;
@property (nonatomic) double operation;

@property (weak, nonatomic) IBOutlet UITextField *textField;

-(IBAction)numberPressed:(id)sender;
-(IBAction)operatorPressed:(id)sender;
-(IBAction)operationCancel:(id)sender;
-(IBAction)numberDelete:(id)sender;

@end
