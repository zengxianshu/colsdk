//
//  RewardedVideoAdManager.m
//  novelReader
//
//  Created by Ink on 2019/7/31.
//  Copyright © 2019 dennis. All rights reserved.
//

#define kRewardedVideoAdSlot @"945710075"

#import "RewardedVideoAdManager.h"

@interface RewardedVideoAdManager()<BUNativeExpressRewardedVideoAdDelegate>

@property (nonatomic, strong) BUNativeExpressRewardedVideoAd *rewardedVideoAd;

@property (nonatomic, copy) VideoAdComplation videoAdComplation;
@property (nonatomic, weak) UIViewController *showAdViewController;

@property (nonatomic, copy) NSString *adVideoId;//视频广告id

@end

@implementation RewardedVideoAdManager

- (instancetype)init {
    return [self initWithAdSlot:nil];
}

- (instancetype)initWithAdSlot:(NSString *)adSlot {
    self = [super init];
    if (self) {
        BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
        BUNativeExpressRewardedVideoAd *rewardedVideoAd = [[BUNativeExpressRewardedVideoAd alloc] initWithSlotID:adSlot ?: kRewardedVideoAdSlot rewardedVideoModel:model];
        rewardedVideoAd.delegate = self;
        self.rewardedVideoAd = rewardedVideoAd;
    }
    return self;
}

+ (RewardedVideoAdManager *)showVideoAdWith:(UIViewController *)showAdViewController videoAdComplation:(VideoAdComplation)videoAdComplation {
    return [self showVideoAdWith:showAdViewController withAdSlot:kRewardedVideoAdSlot videoAdComplation:videoAdComplation];
}

+ (RewardedVideoAdManager *)showVideoAdWith:(UIViewController *)showAdViewController withAdSlot:(NSString *)adSlot videoAdComplation:(VideoAdComplation)videoAdComplation {
    RewardedVideoAdManager *rewardedVideoAdManager = [[RewardedVideoAdManager alloc] initWithAdSlot: adSlot];
    rewardedVideoAdManager.showAdViewController = showAdViewController;
    rewardedVideoAdManager.videoAdComplation    = videoAdComplation;
    [rewardedVideoAdManager loadAd];
 
    return rewardedVideoAdManager;
}

- (void)loadAd {
    [self.rewardedVideoAd loadAdData];
}

- (void)showAd {
    [self.rewardedVideoAd showAdFromRootViewController:self.showAdFromRootViewController];
}

- (UIViewController *)showAdFromRootViewController {
    return self.showAdViewController ? : UIApplication.sharedApplication.keyWindow.rootViewController;
}

- (void)adComplation:(BOOL)result{
    self.videoAdComplation ? self.videoAdComplation(result): nil;
    self.videoAdComplation = nil;
}

#pragma mark - BUNativeExpressRewardedVideoAdDelegate

- (void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    [self adComplation:false];
    NSLog(@"%@",error);
}

- (void)nativeExpressRewardedVideoAdViewRenderFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error {
    [self adComplation:false];
    NSLog(@"%@",error);
}

- (void)nativeExpressRewardedVideoAdDidClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self adComplation:true];
}

- (void)nativeExpressRewardedVideoAdDidClickSkip:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd {
    [self adComplation:false];
}

- (void)nativeExpressRewardedVideoAdDidPlayFinish:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error {
    if (error) {
        [self adComplation:false];
        NSLog(@"%@",error);
    }
}

- (void)nativeExpressRewardedVideoAdDidDownLoadVideo:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd{
    [self showAd];
}


@end


