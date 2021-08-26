//
//  ViewController.m
//  TestOC
//
//  Created by Ink on 2021/2/25.
//

#import "ViewController.h"

#import "RewardedVideoAdManager.h"
#import <Masonry/Masonry.h>

#import <Reader17kSDK/Reader17kSDK.h>

typedef void (^VideoAdComplation)(BOOL);


@interface ViewController ()<ReaderAdDelegate>
@property (nonatomic,strong) RewardedVideoAdManager *rewardedVideoAdManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIViewController *vc = [ReaderColSDK.shared getHomePageVc];
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    vc.view.frame = self.view.bounds;
    ReaderColSDK.shared.readerAdDelegate = self;
}

// MARK: - ReaderAdDelegate
// 激励视频广告 可选 未实现该代理则不会展示激励视频广告相关
-(void)showRewardAdFrom:(UIViewController *)viewController parameter:(NSDictionary *)parameter completion:(void (^)(BOOL))completion {
    
    self.rewardedVideoAdManager = [RewardedVideoAdManager showVideoAdWith:viewController videoAdComplation:^(BOOL result) {
        completion(result);
    }];
}

// 每日首次打开阅读器弹窗广告 可选 未实现该代理则不会展示每日首次打开阅读器弹窗广告相关
- (UIView *)newDayFirstOpenReaderAdViewFrom:(UIViewController *)viewController parameter:(NSDictionary *)parameter renderSuccess:(void (^ _Nonnull)(CGSize))renderSuccess{
    
    return [self cellAdViewFrom:viewController parameter:parameter renderSuccess:renderSuccess];
}

// 内容中插播广告 可选 未实现该代理则不会展示章节内容间的广告相关
- (UIView *)readerContentAdViewFrom:(UIViewController *)viewController parameter:(NSDictionary *)parameter {
    
    NativeExpressAdCarrierView *adCarrierView = [[NativeExpressAdCarrierView alloc] init];
    adCarrierView.clipsToBounds = true;
    // 阅读页背面判断
    if ([parameter[@"isBackSide"] boolValue] == true) {
        return adCarrierView;
    }
    [adCarrierView loadAD:viewController withNeedPlaceHolder:false withCenterShow:true renderSuccess:nil];
    return adCarrierView;
}

// 阅读末页广告 可选 未实现该代理则不会展示阅读末页广告相关
- (UIView *)readerEndAdViewFrom:(UIViewController *)viewController parameter:(NSDictionary *)parameter renderSuccess:(void (^ _Nonnull)(CGSize))renderSuccess{
    
    return [self cellAdViewFrom:viewController parameter:parameter renderSuccess:renderSuccess];
}

// 阅读末页广告 可选 未实现该代理则不会展示阅读末页广告相关
-(UIView *)cellAdViewFrom:(UIViewController *)viewController parameter:(NSDictionary *)parameter renderSuccess:(void (^)(CGSize))renderSuccess{
    
    NativeExpressAdCarrierView *adCarrierView = [[NativeExpressAdCarrierView alloc] init];
    [adCarrierView loadAD:viewController withNeedPlaceHolder:false withCenterShow:false renderSuccess:renderSuccess];
    return adCarrierView;
}

@end

@implementation NativeExpressAdCarrierView

-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup {
    self.clipsToBounds = true;
}

-(void)loadAD:(UIViewController *)controller withNeedPlaceHolder:(BOOL)needPlaceHolder withCenterShow:(BOOL)centerShow  renderSuccess:(void (^)(CGSize))renderSuccess{
    
    
    typeof(self) __weak weakSelf = self;
    
    if (needPlaceHolder) {
        UIImageView *placeHolder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"adPlaceholder"]];
        [self addSubview:placeHolder];
        [placeHolder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf);
            make.leading.trailing.equalTo(weakSelf);
            if (centerShow == false) {
                make.height.equalTo(self.mas_height).multipliedBy(0.75).priorityMedium();
            }
        }];
        _placeHolderImageView = placeHolder;
    }

    self.nativeExpressAdManager = [NativeExpressAdManager getFeedAdWithComplation:^(BOOL result, NSArray<__kindof BUNativeExpressAdView *> * _Nonnull views) {
        

        BUNativeExpressAdView *adView = views.firstObject;
        if (weakSelf.window != nil && adView != nil) {
            adView.rootViewController = controller;
            [weakSelf addSubview:adView];
            if (centerShow == false) {
                [adView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.leading.top.trailing.equalTo(weakSelf);
                }];
            }
            [adView render];
            weakSelf.placeHolderImageView.hidden = true;
        }
    } renderComplation:^(BOOL result, NSArray<__kindof BUNativeExpressAdView *> * _Nonnull views) {
        
        BUNativeExpressAdView *adView = views.firstObject;
        if (centerShow) {
            [adView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(weakSelf);
                make.centerX.equalTo(weakSelf);
                make.center.equalTo(weakSelf);
                make.leading.equalTo(weakSelf);
                make.height.mas_equalTo(adView.bounds.size.height);
            }];
        }else{
            [adView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(adView.bounds.size.height);
            }];
            renderSuccess(adView.bounds.size);
        }
        [weakSelf removeADManager];
    }];
  
}

-(void)removeADManager{
   
    [_nativeExpressAdManager ad_destruction];
    _nativeExpressAdManager = nil;
}

    
- (void)dealloc {
    [self removeADManager];
}
    
@end
