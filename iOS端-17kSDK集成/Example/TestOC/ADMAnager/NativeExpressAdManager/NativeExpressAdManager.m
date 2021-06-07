//
//  NativeExpressAdManager.m
//  novelReader
//
//  Created by Ink on 2020/3/3.
//  Copyright © 2020 ChineseAll. All rights reserved.
//

#import "NativeExpressAdManager.h"

#define kAdSlotForNativeExpress  @"945710074"

@interface NativeExpressAdManager()<BUNativeExpressAdViewDelegate>

@property (strong, nonatomic) BUNativeExpressAdManager *nativeExpressAdManager;
@property (nonatomic, copy) NativeExpressAdComplation nativeExpressAdComplation;
@property (nonatomic, copy) NativeExpressAdComplation nativeExpressAdRenderComplation;

@end

@implementation NativeExpressAdManager

- (instancetype)init {
    return [self initWithAdSlot:nil adType:BUAdSlotAdTypeUnknown];
}

- (void)ad_destruction {
    NSLog(@"NativeExpressAdCarrierView => NativeExpressAdManager deinit");
    self.nativeExpressAdManager = nil;
    self.nativeExpressAdManager.adslot = nil;
    self.nativeExpressAdManager.delegate = nil;
    self.nativeExpressAdComplation = nil;
    self.nativeExpressAdRenderComplation = nil;
}

- (instancetype)initWithAdSlot:(NSString *)adSlot adType:(BUAdSlotAdType)adType{
    self = [super init];
    if (self) {
        BUAdSlot *slot1 = [[BUAdSlot alloc] init];
        slot1.ID = adSlot;
        slot1.AdType = adType;
        BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Feed228_150];
        slot1.imgSize = imgSize;
        slot1.position = BUAdSlotPositionFeed;
        slot1.isSupportDeepLink = YES;
        CGFloat width = UIScreen.mainScreen.bounds.size.width - 40.0;
        self.nativeExpressAdManager = [[BUNativeExpressAdManager alloc] initWithSlot:slot1 adSize:CGSizeMake(width, 0)];
        self.nativeExpressAdManager.delegate = self;
    }
    return self;
}



+ (NativeExpressAdManager *)getFeedAdWithComplation:(NativeExpressAdComplation)complation renderComplation:(NativeExpressAdComplation)renderComplation{
    return [self getAdWithAdSlot:kAdSlotForNativeExpress complation:complation renderComplation:renderComplation];
}

+ (NativeExpressAdManager *)getAdWithAdSlot:(NSString *)adSlot complation:(NativeExpressAdComplation)complation renderComplation:(NativeExpressAdComplation)renderComplation{
    NativeExpressAdManager *adManager = [[NativeExpressAdManager alloc]initWithAdSlot:adSlot adType:BUAdSlotAdTypeFeed];
    adManager.nativeExpressAdComplation = complation;
    adManager.nativeExpressAdRenderComplation = renderComplation;
    [adManager.nativeExpressAdManager loadAd:1];
    return adManager;
}

- (void)loadData:(NSInteger)count {
    [self.nativeExpressAdManager loadAd:count];
}

- (void)adComplation:(BOOL)result views:(NSArray *)views {
    self.nativeExpressAdComplation ? self.nativeExpressAdComplation(result,views): nil;
    self.nativeExpressAdComplation = nil;
}

#pragma mark - BUNativeExpressAdViewDelegate

- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAd views:(NSArray<__kindof BUNativeExpressAdView *> *)views {
    [self adComplation:true views:views];
}

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *)error {
    [self adComplation:false views:nil];
    self.nativeExpressAdRenderComplation = nil;
    self.nativeExpressAdManager = nil;
    NSLog(@"%@",error);
}

- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
    self.nativeExpressAdRenderComplation ? self.nativeExpressAdRenderComplation(true,@[nativeExpressAdView]): nil;
    self.nativeExpressAdRenderComplation = nil;
    self.nativeExpressAdManager = nil;
}

- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *_Nullable)error {
    self.nativeExpressAdRenderComplation ? self.nativeExpressAdRenderComplation(false,@[nativeExpressAdView]): nil;
    self.nativeExpressAdRenderComplation = nil;
    self.nativeExpressAdManager = nil;
}
@end
