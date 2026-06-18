# flutter_gn_fancyleds_card

A customizable card widget featuring an animated LED border and a vibrant background glow effect for Flutter applications.

[![GitHub license](https://img.shields.io/github/license/GeorgeNady/flutter_gn_fancyleds_card)](https://github.com/GeorgeNady/flutter_gn_fancyleds_card/blob/main/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/GeorgeNady/flutter_gn_fancyleds_card)](https://github.com/GeorgeNady/flutter_gn_fancyleds_card/stargazers)

## Features

- **Animated LED Border**: A beautiful sweeping gradient border that rotates smoothly around the child widget.
- **Vibrant Glow Effect**: A soft background glow that shifts dynamically along with the border color.
- **Highly Customizable**: Easily adjust the border width, glow radius, border radius, and inner child content.
- **Multiple LED Modes**: Includes an enum with options for `staticColor`, `breathing`, `rainbow`, `rainbowWave`, `pulse`, and `chase`.

## Getting started

Since this package is hosted on GitHub, you can add it to your `pubspec.yaml` using:

```yaml
dependencies:
  flutter_gn_fancyleds_card:
    git:
      url: https://github.com/GeorgeNady/flutter_gn_fancyleds_card.git
      ref: main
```

## Usage

### Simple Example

```dart
FancyLedCard(
  child: Container(
    width: 300,
    height: 150,
    alignment: Alignment.center,
    child: const Text(
      'Hello LED!',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  ),
)
```

### Custom Configuration

```dart
FancyLedCard(
  mode: LedMode.rainbow,
  borderWidth: 4.0,
  glowRadius: 50.0,
  borderRadius: BorderRadius.circular(16),
  child: Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.bolt, size: 48, color: Colors.amber),
        SizedBox(height: 8),
        Text('Supercharged Content'),
      ],
    ),
  ),
)
```

## Parameters

### FancyLedCard

| Parameter | Type | Default | Description |
|---|---|---|---|
| `child` | `Widget` | **Required** | The widget to display inside the fancy card. |
| `mode` | `LedMode` | `LedMode.rainbow` | The operational mode for the LED animation effects. |
| `borderWidth` | `double` | `2.0` | The width of the sweeping animated border. |
| `glowRadius` | `double` | `40.0` | The blur radius and spread extent of the color glow layer. |
| `borderRadius` | `BorderRadius` | `BorderRadius.circular(24)` | The clip and decoration border radius for the card. |

## License

MIT
