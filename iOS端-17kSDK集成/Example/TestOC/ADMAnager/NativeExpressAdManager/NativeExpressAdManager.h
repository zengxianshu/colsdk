//
//  NativeExpressAdManager.h
//  novelReader
//
//  Created by Ink on 2020/3/3.
//  Copyright © 2020 ChineseAll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BUAdSDK/BUAdSDK.h>
NS_ASSUME_NONNULL_BEGIN

typedef void (^NativeExpressAdComplation)(BOOL result, NSArray<__kindof BUNativeExpressAdView *>* views);

@interface NativeExpressAdManager : NSObject

+ (NativeExpressAdManager *)getFeedAdWithComplation:(NativeExpressAdComplation)complation renderComplation:(NativeExpressAdComplation)complation;
- (void)ad_destruction;
@end

NS_ASSUME_NONNULL_END
