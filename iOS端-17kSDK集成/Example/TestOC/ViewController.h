//
//  ViewController.h
//  TestOC
//
//  Created by Ink on 2021/2/25.
//

#import <UIKit/UIKit.h>
#import "NativeExpressAdManager.h"

@interface ViewController : UIViewController

@end

/// 广告承载视图
@interface NativeExpressAdCarrierView : UIView

@property (nonatomic,strong) NativeExpressAdManager *nativeExpressAdManager;
@property (nonatomic,strong) UIImageView *placeHolderImageView;
@property (nonatomic,weak) UIViewController *rootViewController;

-(void)loadAD:(UIViewController *)controller withNeedPlaceHolder:(BOOL)needPlaceHolder withCenterShow:(BOOL)centerShow  renderSuccess:(void (^)(CGSize))renderSuccess;
@end
