//
//  ViewController.h
//  Calc
//
//  Created by Владимир on 21.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    
}

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView * portretView;

-(IBAction)numberPressed:(UIButton *)sender;
-(IBAction)operatorPressed:(id)sender;



@end
