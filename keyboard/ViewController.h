//
//  ViewController.h
//  keyboard
//
//  Created by 实信腾 on 16/4/26.
//  Copyright © 2016年 实信腾. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *chatView;

//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayout;

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@property (weak, nonatomic) IBOutlet UIButton *sendBtn;

@property(nonatomic,strong)NSMutableArray *messageArr;
@end

