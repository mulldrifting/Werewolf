//
//  AlphaView.h
//  Werewolf
//
//  Created by Lauren Lee on 5/2/14.
//  Copyright (c) 2014 Lauren Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlphaView : UIView

- (void)reset;
- (void)addBigText:(NSString *)bigText;
- (void)addBoxView;
- (void)addExplanationViewWithMessage:(NSString*)message;

@end
