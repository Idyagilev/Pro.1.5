//
//  TESTViewController.m
//  Pro 1.5
//
//  Created by T on 25.02.16.
//  Copyright © 2016 Ilya. All rights reserved.
//

#import "TESTViewController.h"

@interface TESTViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation TESTViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//   2) Подписываемся на глобальную константу
    
    self.textField.font = [UIFont systemFontOfSize:MAIN_FONT_SIZE];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
