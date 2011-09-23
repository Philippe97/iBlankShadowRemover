#import <Foundation/Foundation.h>
#import <SpringBoard/SpringBoard.h>
#import <SpringBoard/SBIcon.h>
#import <UIKit/UIKit.h>
#include <substrate.h>

MSHook(id, SBIcon$createShadowImageView, SBIcon *self, SEL sel) {
	return ([self isBookmarkIcon] && [[[self webClip] identifier] hasSuffix:@" ib"]) ? nil : _SBIcon$createShadowImageView(self, sel);
}

MSHook(void, SBIcon$setHighlighted$, SBIcon *self, SEL sel, BOOL origBool) {
	if ([self isBookmarkIcon] && [[[self webClip] identifier] hasSuffix:@" ib"]) {
		_SBIcon$setHighlighted$(self, sel, NO);
	} else {
		_SBIcon$setHighlighted$(self, sel, origBool);
	}
}

extern "C" void TweakInitialize() {
	_SBIcon$createShadowImageView = MSHookMessage(objc_getClass("SBIcon"), @selector(createShadowImageView), &$SBIcon$createShadowImageView);
	_SBIcon$setHighlighted$ = MSHookMessage(objc_getClass("SBIcon"), @selector(setHighlighted:), &$SBIcon$setHighlighted$);
}