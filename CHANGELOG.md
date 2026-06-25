## 2.1.0

* **Feature**: Added animated glow radius. The glow now smoothly expands from 0 to the target radius.
* **Enhancement**: Added `glowDuration` parameter to `FancyLedCard` to allow custom control over the glow animation speed (defaults to 150ms).

## 2.0.0

* **Breaking Change**: Removed `LedMode` enum and unified the library to focus exclusively on the **Ambient (Ambilight)** effect.
* **Simplification**: Removed `GlowLayer` (static/rainbow) in favor of the more advanced `AmbientGlowLayer`.
* **Refactor**: Simplified `FancyLedCard` API by removing the `mode` parameter.
* **Enhancement**: Optimized the sweeping border animation to work seamlessly with sampled ambient colors.

## 1.1.0

* **Feature**: Added `LedMode.ambient` (Ambilight-style effect).
    * Content-aware background glow with boosted saturation.
    * Real-time pixel sampling for the LED border to match child content.
* **Architecture**: Refactored codebase following SOLID principles and Clean Architecture.
    * Introduced `IImageProcessor` for decoupled image analysis.
    * Improved performance with atomic widget rebuilds using `RepaintBoundary`.
* **Enhancement**: Added `FancyLedController` for manual refreshes and external color control.
* **Enhancement**: Added `staticColor` mode support.
* **Performance**: Optimized rendering with `AnimationController` and microtask-based image processing.

## 1.0.1

* **Maintenance**: Documentation and project structure updates.

## 1.0.0

* Initial release of `flutter_gn_fancyleds_card`.
* Implementation of `FancyLedCard` with animated border and glow effect.
* Added `LedMode` enum for future animation mode expansions.
* Support for custom border width, glow radius, and border radius.
