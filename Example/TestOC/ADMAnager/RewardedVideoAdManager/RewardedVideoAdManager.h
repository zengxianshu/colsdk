//
//  RewardedVideoAdManager.h
//  novelReader
//
//  Created by Ink on 2019/7/31.
//  Copyright © 2019 dennis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BUAdSDK/BUAdSDK.h>

NS_ASSUME_NONNULL_BEGIN

//typedef void (^VideoAdComplation)(BOOL, BUNativeExpressRewardedVideoAd *);
typedef void (^VideoAdComplation)(BOOL);

@interface RewardedVideoAdManager : NSObject

+ (RewardedVideoAdManager *)showVideoAdWith:(UIViewController *)showAdViewController videoAdComplation:(VideoAdComplation)videoAdComplation;

@end

NS_ASSUME_NONNULL_END
