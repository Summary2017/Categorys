//
//  HGController.m
//  HGTextView
//
//  Created by  ZhuHong on 2017/6/1.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import "HGController.h"
#import "SetupSignatureCell.h"

@interface HGController () <SetupSignatureCellDelegate>

@property (nonatomic, copy) NSString* signatureTEXT;

@end

@implementation HGController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 默认的签名
    self.signatureTEXT = @"在通往大神的道上，多看书、多运动，然后升值再加薪，感谢自己！";
}

#pragma mark - 
#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SetupSignatureCell* cell = [tableView dequeueReusableCellWithIdentifier:@"SetupSignatureCell"];
    
    cell.delegate = self;
    cell.signatureTEXT = self.signatureTEXT;
    
    return cell;
}

#pragma mark -
#pragma mark - SetupSignatureCellDelegate
- (void)setupSignatureCell:(SetupSignatureCell *)cell didChangedValue:(NSString *)value {
    NSLog(@"你输入的个性签名是: %@", value);
}

@end
