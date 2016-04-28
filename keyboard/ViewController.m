//
//  ViewController.m
//  keyboard
//
//  Created by 实信腾 on 16/4/26.
//  Copyright © 2016年 实信腾. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化tableview的数据源
    NSArray *arr = @[@"你好",@"你好",@"我是iOS开发工程师，你呢",@"哈哈哈哈",@"你也是",@"嗯哼",@"好吧",@"好的",@"哈哈哈",@"哈哈哈"];
    self.messageArr = [NSMutableArray arrayWithArray:arr];
    
    //1.监听键盘高度变化
    //2.监听键盘消失
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //添加一个 tapGeguster  让点击一下 收起键盘
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideInput)];
    [self.chatView addGestureRecognizer:tap];

   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
     有待改进：对话框的label自适应宽高
     */
    NSInteger num = indexPath.row;
    NSString *identifier = num%2==0?@"MessageCellLeft":@"MessageCellRight";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    UILabel *contentLabel = (UILabel*)[cell viewWithTag:10001];
    [contentLabel setText:self.messageArr[indexPath.row]];
    return cell;
}
#pragma mark - 键盘的处理
//键盘的信息 在noti.userInfo里
-(void)keyboardChangeFrame:(NSNotification*)noti;
{
    //如没有使用autolayout  frame 高度-键盘的高度
    // self.view setFrame:<#(CGRect)#>
    
    //现在这个字典中找到 键盘高度
    CGRect rect= [noti.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    NSLog(@"%@", noti.userInfo);
    
    //CGFloat keyboardheight = rect.origin.y;
    CGFloat duration=[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGFloat curve=[noti.userInfo[UIKeyboardAnimationCurveUserInfoKey]doubleValue];
    
    [self.bottomLayout setConstant:rect.size.height];
    
    [UIView setAnimationCurve:curve];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
        [self tableScrollToBottom];
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void)keyboardHide:(NSNotification *)noti
{
    [self.bottomLayout setConstant:0];
    [self tableScrollToBottom];
    
    
}
#pragma mark =====私有方法=====
-(void)tableScrollToBottom{
    
    if (self.messageArr.count>1)
    {
        [self.chatView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messageArr.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
    }
    
}
-(void)hideInput
{
    [self.view endEditing:YES];
    
}
#pragma mark =====TextField Delegate=====


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    
    [self.messageArr addObject:textField.text];
    [self.chatView reloadData];
    
    [textField setText:@""];
    
    [self.view endEditing:YES];
    
   
    
    return YES;
}
/*
 注意发送button的实现方法应该是一样的
 */
@end























