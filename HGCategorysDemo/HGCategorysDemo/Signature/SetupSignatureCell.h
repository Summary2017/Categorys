//
//  SetupSignatureCell.h
//  HGTextView
//
//  Created by  ZhuHong on 2017/6/1.
//  Copyright © 2017年 CoderHG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SetupSignatureCell;

@protocol SetupSignatureCellDelegate <NSObject>

// 代码
- (void)setupSignatureCell:(SetupSignatureCell*)cell didChangedValue:(NSString*)value;

@end

@interface SetupSignatureCell : UITableViewCell

@property (nonatomic, weak) id<SetupSignatureCellDelegate> delegate;
@property (nonatomic, copy) NSString* signatureTEXT;

@end
