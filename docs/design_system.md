# Ironit Design System

## 1. Brand Personality

### Ironit Identity

**Premium Service, Modern Convenience**

Ironit represents the future of on-demand ironing services - professional, reliable, and effortlessly integrated into daily life. The brand combines the trustworthiness of traditional services with the convenience of modern technology.

### Brand Attributes

1. **Professional** - Expert service with attention to detail
2. **Trustworthy** - Reliable, consistent, and dependable
3. **Modern** - Cutting-edge technology with clean aesthetics
4. **Efficient** - Fast, streamlined, time-saving
5. **Approachable** - Friendly, human, not corporate
6. **Premium** - High-quality without being ostentatious
7. **Minimal** - Clean, uncluttered, focused
8. **Warm** - Inviting, comfortable, human-centered

### Brand Promise

"Perfectly pressed clothes, delivered with precision and care, so you can focus on what matters most."

### Visual Tone

- **Clean**: Ample whitespace, uncluttered layouts
- **Precise**: Sharp typography, consistent spacing
- **Warm**: Friendly colors, soft shadows
- **Dynamic**: Subtle animations, smooth transitions
- **Confident**: Bold primary color, clear hierarchy

## 2. Visual Principles

### Core Design Rules

1. **Simplicity First**
   - Remove unnecessary elements
   - One primary action per screen
   - Clear visual hierarchy

2. **Consistent Spacing**
   - Use the 4dp spacing scale religiously
   - Maintain rhythm and balance
   - Group related elements closely

3. **Ample Whitespace**
   - Minimum 16dp padding around content
   - 24dp+ between major sections
   - Never crowd the interface

4. **Card-Based Layouts**
   - Cards as primary content containers
   - Consistent padding (16dp internal)
   - Subtle elevation for depth

5. **Minimal Color Palette**
   - Primary color for key actions
   - Neutral surfaces for content
   - Accents sparingly for emphasis

6. **Readable Typography**
   - Clear type hierarchy
   - Optimal line heights
   - Sufficient contrast

7. **Accessibility First**
   - WCAG AA compliance minimum
   - Large touch targets (48x48dp minimum)
   - Clear affordances

8. **Motion with Purpose**
   - Functional animations only
   - Consistent durations and curves
   - Never distract from content

9. **Dark Mode Parity**
   - Equal attention to both themes
   - Consistent experience
   - Optimized for OLED

10. **Responsive by Default**
    - Mobile-first approach
    - Graceful degradation
    - Adaptive layouts

## 3. Color System

### Primary Palette

**Light Mode**
- **Primary**: `#6200EE` (Purple 500) - Trust, professionalism
- **On Primary**: `#FFFFFF` - Maximum contrast
- **Primary Container**: `#EADDFF` - Subtle highlight
- **On Primary Container**: `#21005D` - Readable text

**Dark Mode**
- **Primary**: `#BB86FC` (Purple 200) - Vibrant but not harsh
- **On Primary**: `#000000` - Maximum contrast
- **Primary Container**: `#371E73` - Deep surface
- **On Primary Container**: `#EADDFF` - Readable text

### Secondary Palette

**Light & Dark Mode**
- **Secondary**: `#03DAC6` (Teal A400) - Freshness, cleanliness
- **On Secondary**: `#000000` (Light) / `#000000` (Dark)
- **Secondary Container**: `#80CBC4` (Light) / `#004D40` (Dark)

### Neutral Palette

**Surfaces**
- **Background**: `#FFFFFBFE` (Light) / `#1C1B1F` (Dark)
- **Surface**: `#FFFFFBFE` (Light) / `#1C1B1F` (Dark)
- **Surface Variant**: `#F5F3F7` (Light) / `#49454F` (Dark)

**Content**
- **On Surface**: `#1C1B1F` (Light) / `#E6E1E5` (Dark)
- **On Surface Variant**: `#49454F` (Light) / `#CAC4D0` (Dark)

### Semantic Colors

**Success**
- **Success**: `#006D3A` (Green 800)
- **On Success**: `#FFFFFF`
- **Success Container**: `#85F884` (Light) / `#00391A` (Dark)

**Warning**
- **Warning**: `#6D3D00` (Amber 800)
- **On Warning**: `#FFFFFF`
- **Warning Container**: `#FFD24C` (Light) / `#4E3400` (Dark)

**Error**
- **Error**: `#B3261E` (Red 700)
- **On Error**: `#FFFFFF`
- **Error Container**: `#F9DEDC` (Light) / `#93000A` (Dark)

**Information**
- **Info**: `#0061A4` (Blue 800)
- **On Info**: `#FFFFFF`
- **Info Container**: `#B3E5FC` (Light) / `#003558` (Dark)

### Usage Guidelines

**Primary Color**
- Primary buttons
- Key actions
- Active states
- Accent elements
- Never overuse (max 10% of screen)

**Secondary Color**
- Secondary actions
- Highlight elements
- Success states
- Call-to-action accents
- Use sparingly (max 5% of screen)

**Neutral Colors**
- Backgrounds and surfaces
- Text and content
- Dividers and borders
- Disabled states
- 80%+ of interface

**Semantic Colors**
- Status indicators only
- Error messages
- Success confirmations
- Warning states
- Never for decorative purposes

### Color Tokens

```dart
// Extended color palette
class AppColors {
  // Primary
  static const Color primary = Color(0xFF6200EE);
  static const Color primaryLight = Color(0xFFBB86FC);
  static const Color primaryDark = Color(0xFF371E73);
  static const Color primaryContainer = Color(0xFFEADDFF);

  // Secondary
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryLight = Color(0xFF80CBC4);
  static const Color secondaryDark = Color(0xFF004D40);

  // Neutrals
  static const Color backgroundLight = Color(0xFFFFFBFE);
  static const Color backgroundDark = Color(0xFF1C1B1F);
  static const Color surfaceLight = Color(0xFFFFFBFE);
  static const Color surfaceDark = Color(0xFF1C1B1F);
  static const Color surfaceVariantLight = Color(0xFFF5F3F7);
  static const Color surfaceVariantDark = Color(0xFF49454F);

  // Semantic
  static const Color success = Color(0xFF006D3A);
  static const Color warning = Color(0xFF6D3D00);
  static const Color error = Color(0xFFB3261E);
  static const Color info = Color(0xFF0061A4);

  // Gradients
  static const Gradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6200EE), Color(0xFFBB86FC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
```

## 4. Typography

### Type Scale

| Role | Light Mode | Dark Mode | Weight | Spacing | Line Height |
|------|-----------|-----------|--------|---------|-------------|
| Display Large | 57sp | 57sp | Light (300) | -0.25 | 64px |
| Display Medium | 45sp | 45sp | Light (300) | 0.0 | 52px |
| Display Small | 36sp | 36sp | Regular (400) | 0.0 | 44px |
| Headline Large | 32sp | 32sp | Regular (400) | 0.0 | 40px |
| Headline Medium | 28sp | 28sp | Regular (400) | 0.0 | 36px |
| Headline Small | 24sp | 24sp | Medium (500) | 0.0 | 32px |
| Title Large | 22sp | 22sp | Medium (500) | 0.0 | 28px |
| Title Medium | 16sp | 16sp | Medium (500) | 0.15 | 24px |
| Title Small | 14sp | 14sp | Medium (500) | 0.1 | 20px |
| Body Large | 16sp | 16sp | Regular (400) | 0.5 | 24px |
| Body Medium | 14sp | 14sp | Regular (400) | 0.25 | 20px |
| Body Small | 12sp | 12sp | Regular (400) | 0.4 | 16px |
| Label Large | 14sp | 14sp | Medium (500) | 1.25 | 20px |
| Label Medium | 12sp | 12sp | Medium (500) | 0.5 | 16px |
| Label Small | 11sp | 11sp | Medium (500) | 1.5 | 16px |

### Font Family

**Primary Font**: `Roboto` (Material 3 default)
- Clean, modern, highly readable
- Excellent multilingual support
- Optimized for UI

**Fallback Fonts**:
- `Noto Sans` (extended character support)
- System default sans-serif

### Usage Guidelines

**Display Styles (Large/Medium/Small)**
- App name in splash screen
- Hero sections (rarely)
- Major headings only

**Headline Styles**
- Screen titles
- Section headers
- Card titles
- Maximum 1 per screen section

**Title Styles**
- Subsection headers
- Form labels
- Dialog titles
- Navigation items

**Body Styles**
- Paragraph text
- Descriptions
- List items
- 80% of all text content

**Label Styles**
- Button text
- Input labels
- Chip text
- Tab labels

### Typography Best Practices

1. **Hierarchy**: Maximum 3 type styles per screen section
2. **Contrast**: Minimum 4.5:1 for body text, 3:1 for large text
3. **Line Length**: 40-60 characters for body text
4. **Alignment**: Left-aligned by default, center for hero sections
5. **Color**: Use `onSurface` for body, `primary` for links
6. **Weight**: Avoid bold for body text, use medium for emphasis

### Code Implementation

```dart
class AppTypography {
  // Display
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.25, height: 64/57,
  );

  // Headline
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.0, height: 40/32,
  );

  // Title
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22, fontWeight: FontWeight.w500, letterSpacing: 0.0, height: 28/22,
  );

  // Body
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5, height: 24/16,
  );

  // Label
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25, height: 20/14,
  );

  static const TextTheme textTheme = TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );
}
```

## 5. Spacing System

### 4dp Base Scale

| Size | Value | Usage |
|------|-------|-------|
| 2xSmall | 2dp | Micro adjustments |
| xSmall | 4dp | Tightest spacing |
| Small | 8dp | Compact elements |
| Medium | 16dp | Standard padding |
| Large | 24dp | Section separation |
| xLarge | 32dp | Major divisions |
| xxLarge | 48dp | Page sections |
| xxxLarge | 64dp | Hero areas |

### Spacing Guidelines

**Padding**
- **Containers**: 16dp (medium) default
- **Cards**: 16dp internal, 8dp between elements
- **Buttons**: 16dp horizontal, 12dp vertical
- **Text Fields**: 16dp horizontal, 12dp vertical

**Margins**
- **Between elements**: 16dp (medium) default
- **Sections**: 24dp (large) minimum
- **Screen edges**: 16dp (medium) default
- **Bottom navigation**: 8dp (small) above

**Layout**
- **Grid gutters**: 16dp
- **Column gaps**: 16dp
- **Row gaps**: 12dp
- **List item spacing**: 8dp

### Visual Spacing Rules

1. **Group Related Elements**: 8dp between related items
2. **Separate Groups**: 16-24dp between different groups
3. **Section Divisions**: 24-32dp between major sections
4. **Edge Insets**: 16dp from screen edges (24dp for hero sections)
5. **Touch Targets**: Minimum 48x48dp (use padding to achieve)

### Implementation

```dart
class AppSpacing {
  // Base spacing
  static const double x2Small = 2.0;
  static const double xSmall = 4.0;
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double xLarge = 32.0;
  static const double xxLarge = 48.0;
  static const double xxxLarge = 64.0;

  // Component-specific
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: medium, vertical: 12.0,
  );
  static const EdgeInsets cardPadding = EdgeInsets.all(medium);
  static const EdgeInsets screenPadding = EdgeInsets.all(medium);
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(vertical: small);
}
```

## 6. Radius System

### Corner Radius Guidelines

| Component | Radius | Usage |
|-----------|--------|------|
| Buttons | 8dp | Primary, Secondary, Text buttons |
| Cards | 12dp | All card components |
| Dialogs | 16dp | Alerts, bottom sheets |
| Text Fields | 8dp | Input fields, dropdowns |
| Images | 12dp | Service images, avatars |
| Chips | 16dp | Filter chips, tags |
| Badges | 8dp | Notification badges |
| Bottom Sheets | 16dp (top) | Modal bottom sheets |
| App Bars | 0dp | Flat app bars |
| Floating Action Buttons | 16dp | Circular FABs |

### Implementation

```dart
class AppRadius {
  static const double button = 8.0;
  static const double card = 12.0;
  static const double dialog = 16.0;
  static const double textField = 8.0;
  static const double image = 12.0;
  static const double chip = 16.0;
  static const double badge = 8.0;
  static const double fab = 16.0;
  static const double bottomSheet = 16.0;

  static BorderRadius buttonRadius = BorderRadius.circular(button);
  static BorderRadius cardRadius = BorderRadius.circular(card);
  static BorderRadius dialogRadius = BorderRadius.circular(dialog);
  static BorderRadius textFieldRadius = BorderRadius.circular(textField);
  static BorderRadius imageRadius = BorderRadius.circular(image);
}
```

## 7. Elevation & Shadows

### Elevation System

| Level | Value | Usage |
|-------|-------|-------|
| 0 | 0dp | Surface elements, cards in lists |
| 1 | 1dp | Hover states, subtle depth |
| 2 | 3dp | Active cards, selected items |
| 3 | 6dp | Dialogs, bottom sheets |
| 4 | 8dp | Modal dialogs, popups |
| 5 | 12dp | Floating action buttons |

### Shadow Guidelines

1. **Use Sparingly**: Only for interactive elements
2. **Subtle Depth**: Levels 0-2 for most cases
3. **Dark Mode**: Reduce opacity by 50%
4. **Performance**: Avoid complex shadows on lists

### Implementation

```dart
class AppElevation {
  static const double none = 0;
  static const double hover = 1;
  static const double active = 3;
  static const double dialog = 6;
  static const double modal = 8;
  static const double fab = 12;

  static List<BoxShadow> get shadow1 => [
    BoxShadow(
      color: Color(0x0D000000),
      blurRadius: 1, spreadRadius: 0, offset: Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get shadow2 => [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 3, spreadRadius: 0, offset: Offset(0, 1),
    ),
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 2, spreadRadius: 0, offset: Offset(0, 1),
    ),
  ];

  static List<BoxShadow> get shadow3 => [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 6, spreadRadius: 0, offset: Offset(0, 2),
    ),
    BoxShadow(
      color: Color(0x0F000000),
      blurRadius: 3, spreadRadius: 0, offset: Offset(0, 1),
    ),
  ];
}
```

## 8. Iconography

### Icon System

**Library**: Material Symbols (Rounded)
- Consistent with Material 3
- Extensive coverage
- Optimized for UI

**Sizes**
- Small: 16dp (buttons, labels)
- Medium: 24dp (primary icons)
- Large: 32dp (hero icons)

**Styles**
- **Filled**: Primary actions, active states
- **Outlined**: Secondary actions, inactive states
- **Rounded**: Default for all icons

### Usage Guidelines

1. **Consistency**: Same style throughout app
2. **Alignment**: Center with text baseline
3. **Spacing**: 8dp between icon and text
4. **Color**: Inherit from text color
5. **Size**: Match text size (24dp with body text)

### Common Icons

| Context | Icon | Size |
|---------|------|------|
| Navigation | home, search, person, shopping_bag | 24dp |
| Actions | add, edit, delete, share, favorite | 24dp |
| Status | check_circle, error, warning, info | 20dp |
| Services | local_laundry_service, iron, shirt | 24dp |
| Time | schedule, calendar_today, access_time | 24dp |
| Location | location_on, pin_drop, my_location | 24dp |

## 9. Components

### Button System

**Primary Button**
- Fill: Primary color
- Text: OnPrimary (white)
- Radius: 8dp
- Padding: 16h × 12v
- States: Enabled, Disabled, Loading
- Usage: Main call-to-action

**Secondary Button**
- Border: Outline variant
- Text: Primary color
- Radius: 8dp
- Padding: 16h × 12v
- States: Enabled, Disabled, Loading
- Usage: Secondary actions

**Text Button**
- Text: Primary color
- Padding: 8h × 8v
- States: Enabled, Disabled
- Usage: Tertiary actions

**Icon Button**
- Size: 48×48dp
- Icon: 24dp
- States: Enabled, Disabled
- Usage: App bars, toolbars

### App Bar

- Height: 64dp (56dp + 8dp status bar)
- Background: Surface color
- Elevation: 0 (flat design)
- Title: HeadlineSmall
- Actions: Icon buttons (48×48dp)
- Leading: Back button or menu

### Bottom Navigation

- Height: 80dp (56dp + 24dp padding)
- Items: 3-5 maximum
- Active: Primary color
- Inactive: OnSurfaceVariant
- Icons: 24dp + labels
- Shape: Slightly rounded (12dp)

### Cards

- Background: Surface color
- Radius: 12dp
- Padding: 16dp internal
- Elevation: 0 (flat), 1 on hover
- Shadow: Subtle (level 1)
- Usage: Service cards, order cards

### Text Fields

- Height: 56dp
- Radius: 8dp
- Label: Floating when active
- Border: Outline variant
- Padding: 16h × 12v
- States: Normal, Focused, Error
- Helper text: Always visible

### Service Card

- Image: 120×120dp, radius 12dp
- Title: TitleLarge
- Price: TitleMedium (primary color)
- Rating: 5-star display
- Padding: 16dp
- Action: "Book Now" button
- Elevation: 0

### Category Chip

- Height: 32dp
- Padding: 12h × 8v
- Radius: 16dp
- Selected: Primary container
- Unselected: Surface variant
- Icon: 16dp leading
- Text: LabelMedium

### Order Card

- Status: Chip (top-right)
- Service: TitleMedium + image
- Date: BodyMedium
- Price: TitleMedium (bold)
- Actions: "Track" + "Reorder"
- Divider: 1dp between items

### Loading States

- **Full Screen**: Centered circular progress
- **Partial**: Shimmer effect (skeleton)
- **Button**: Circular progress (24dp)
- **List**: 3-5 skeleton items
- **Image**: Fade-in placeholder

### Empty States

- Icon: 48dp (contextual)
- Title: "No [items] found"
- Subtitle: Helpful suggestion
- Action: Primary button (if applicable)
- Layout: Centered, max 60% width

### Error States

- Icon: 48dp (error outline)
- Title: "Something went wrong"
- Subtitle: Specific error message
- Action: "Retry" button
- Layout: Centered, max 60% width

## 10. Motion System

### Animation Principles

1. **Purposeful**: Every animation serves a function
2. **Subtle**: Never distract from content
3. **Consistent**: Same durations and curves
4. **Performant**: 60fps on target devices
5. **Accessible**: Respect motion preferences

### Durations

| Animation Type | Duration | Curve |
|---------------|----------|-------|
| Quick | 150ms | FastOutSlowIn |
| Standard | 300ms | Standard |
| Slow | 500ms | SlowMiddle |
| Enter | 225ms | Decelerate |
| Exit | 195ms | Accelerate |
| Shared Axis | 300ms | Standard |

### Screen Transitions

- **Push/Pop**: Horizontal slide (300ms)
- **Fade**: Cross-fade (225ms)
- **Scale**: Zoom in/out (250ms)
- **Shared Axis**: Vertical/horizontal (300ms)

### Component Animations

**Buttons**
- Press: Scale 0.95 (100ms)
- Release: Scale 1.0 (150ms)
- Loading: Fade to progress (200ms)

**Cards**
- Appear: Fade + slight scale (250ms)
- Hover: Lift (elevation 1→3, 150ms)
- Press: Scale 0.98 (100ms)

**Lists**
- Item appear: Fade + slide up (200ms staggered)
- Reorder: Smooth follow (0ms delay)
- Swipe: Dismiss with stretch (300ms)

**Modals**
- Enter: Fade + scale up (225ms)
- Exit: Fade + scale down (195ms)
- Background: Fade (150ms)

### Micro Interactions

**Loading Indicators**
- Circular: Continuous rotation
- Linear: Left-to-right progress
- Shimmer: 1000ms cycle, 50% opacity

**Pull to Refresh**
- Threshold: 80dp
- Animation: Smooth bounce (300ms)
- Indicator: Circular progress

**Scroll Effects**
- Overscroll: Subtle glow
- App bar: Collapse/expand (200ms)
- FAB: Hide/show (150ms)

### Implementation Rules

1. **Disable on Low Power**: Respect battery saver
2. **Reduce Motion**: Honor user preferences
3. **Stagger Lists**: 50ms delay between items
4. **Hero Animations**: Match aspect ratios
5. **Avoid Overlap**: Sequential animations

```dart
class AppMotion {
  // Durations
  static const Duration quick = Duration(milliseconds: 150);
  static const Duration standard = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration enter = Duration(milliseconds: 225);
  static const Duration exit = Duration(milliseconds: 195);

  // Curves
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;
  static const Curve standardCurve = Curves.easeInOut;
  static const Curve decelerate = Curves.decelerate;
  static const Curve accelerate = Curves.easeIn;

  // Page transitions
  static PageTransitionsTheme pageTransitions = const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );

  // Shared axis transitions
  static PageTransitionsBuilder sharedAxis(
    AxisDirection direction, {
    bool reverse = false,
  }) {
    return SharedAxisPageTransitionsBuilder(
      transitionType: SharedAxisTransitionType.scaled,
      fillColor: Colors.transparent,
    );
  }
}
```

## 11. Responsive Rules

### Breakpoints

| Device | Width Range | Layout |
|--------|-------------|--------|
| Mobile (Portrait) | 0-600dp | Single column |
| Mobile (Landscape) | 600-840dp | Dual pane (optional) |
| Tablet | 840-1280dp | Master-detail |
| Desktop | 1280dp+ | Full adaptive |

### Adaptive Patterns

**Mobile (0-600dp)**
- Single column layouts
- Bottom navigation
- Full-screen modals
- Stacked sections

**Tablet (600-1280dp)**
- Side-by-side layouts
- Navigation rail option
- Dialogs instead of bottom sheets
- Expanded content areas

**Desktop (1280dp+)**
- Multi-column grids
- Permanent navigation
- Hover states
- Dense information

### Implementation

```dart
class AppResponsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1280;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1280;

  static double contentWidth(BuildContext context) {
    if (isDesktop(context)) return 1200;
    if (isTablet(context)) return 800;
    return double.infinity;
  }
}
```

### Touch Targets

- **Minimum**: 48×48dp
- **Preferred**: 56×56dp
- **Icons**: 24dp + 32dp padding
- **Buttons**: Minimum 48dp height
- **List Items**: Minimum 56dp height

## 12. Accessibility

### Color Contrast

- **Text**: Minimum 4.5:1 (body), 3:1 (large)
- **Icons**: Minimum 3:1
- **Interactive**: Minimum 3:1
- **Disabled**: Minimum 2:1

### Typography

- **Scaling**: Support up to 200%
- **Line Height**: Minimum 1.5 for body text
- **Letter Spacing**: Slightly increased for readability

### Navigation

- **Focus Indicators**: Visible on all platforms
- **Keyboard Navigation**: Full support
- **Screen Readers**: Semantic widgets, proper labels

### Motion

- **Reduce Motion**: Honor system setting
- **Seizure Safe**: No flashing >3x/sec
- **Smooth Transitions**: No abrupt changes

### Implementation Checklist

```dart
// Accessibility utilities
class AppAccessibility {
  static bool hasSufficientContrast(Color fg, Color bg) {
    final contrast = _calculateContrast(fg, bg);
    return contrast >= 4.5;
  }

  static TextStyle accessibleTextStyle({
    required Color color,
    required Color background,
    double fontSize = 16,
  }) {
    final contrast = _calculateContrast(color, background);
    if (contrast < 4.5) {
      // Adjust color to meet contrast requirements
      final hsl = HSLColor.fromColor(color);
      final adjusted = hsl.withLightness(
        hsl.lightness < 0.5 ? hsl.lightness - 0.1 : hsl.lightness + 0.1,
      );
      return TextStyle(
        fontSize: fontSize,
        color: adjusted.toColor(),
        height: 1.5,
      );
    }
    return TextStyle(
      fontSize: fontSize,
      color: color,
      height: 1.5,
    );
  }

  static double _calculateContrast(Color a, Color b) {
    // WCAG contrast ratio calculation
    final l1 = a.computeLuminance();
    final l2 = b.computeLuminance();
    return (l1 > l2) ? (l1 + 0.05) / (l2 + 0.05) : (l2 + 0.05) / (l1 + 0.05);
  }
}
```

## 13. Images

### Illustration Style

**Clean & Modern**
- Flat design with subtle depth
- Limited color palette (primary + neutrals)
- Simple shapes, no gradients
- Consistent line weights
- Friendly, approachable characters

### Photography Style

**Lifestyle Focus**
- Natural lighting
- Real people (diverse, authentic)
- Clothing focus (before/after ironing)
- Warm, inviting tones
- Minimal staging

### Image Guidelines

**Service Images**
- 500×500px minimum
- White background
- Consistent lighting
- Multiple angles
- Before/after pairs

**Hero Images**
- 1200×800px minimum
- Lifestyle scenes
- Brand colors dominant
- Minimal text overlay
- Focal point centered

**Avatars**
- Circular crop
- 1:1 aspect ratio
- 100×100px minimum
- Fallback initials
- Consistent styling

### Placeholders

- **Service**: Solid color with icon
- **User**: Initials on colored background
- **Error**: Broken image icon
- **Loading**: Shimmer effect

## 14. Mock Data Rules

### Data Standards

**Text Content**
- Realistic but generic names
- Professional service descriptions
- Authentic addresses (Hyderabad focus)
- Realistic pricing (market-appropriate)

**Images**
- Placeholder service images
- Avatar initials for users
- Solid color placeholders
- Consistent aspect ratios

**Pricing**
- Round numbers (₹299, ₹499, etc.)
- Realistic ranges (₹99-₹999)
- Volume discounts visible
- Taxes included

**Dates/Times**
- Current ±30 days
- Business hours (8AM-8PM)
- 30-minute time slots
- Realistic delivery windows

### Mock Data Examples

```dart
class MockDataRules {
  // Names
  static final names = [
    'Sarah Johnson', 'Michael Chen', 'Priya Patel',
    'Aarav Kumar', 'Emily Wilson', 'Rahul Sharma'
  ];

  // Services
  static final services = [
    {
      'name': 'Premium Shirt Ironing',
      'price': 299,
      'duration': 24,
      'description': 'Expert ironing for dress shirts with collar and cuff detailing',
      'image': 'assets/mock/shirt_ironing.jpg',
    },
    // More services...
  ];

  // Addresses (Hyderabad)
  static final addresses = [
    '12-3-456, Begumpet, Hyderabad',
    'Plot No. 78, Jubilee Hills, Hyderabad',
    'Flat 302, Rainbow Towers, Gachibowli',
  ];

  // Dates
  static DateTime mockDate() {
    final now = DateTime.now();
    return now.add(Duration(days: Random().nextInt(30) - 15));
  }

  // Times (business hours)
  static String mockTime() {
    final hour = 8 + Random().nextInt(12);
    final minute = Random().nextBool() ? 0 : 30;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}
```

## 15. UI Quality Checklist

### Mandatory Requirements

**Every Screen Must Satisfy:**

✅ **Visual Consistency**
- [ ] Follows established spacing system
- [ ] Uses approved color palette
- [ ] Applies correct typography hierarchy
- [ ] Maintains consistent corner radii
- [ ] Uses proper elevation levels

✅ **Responsive Design**
- [ ] Mobile layout (360-480px)
- [ ] Tablet layout (600-840px)
- [ ] Portrait and landscape support
- [ ] No horizontal overflow
- [ ] Touch targets ≥48×48dp

✅ **Accessibility**
- [ ] Minimum 4.5:1 text contrast
- [ ] Semantic widget structure
- [ ] Screen reader support
- [ ] Keyboard navigation
- [ ] Motion reduction support

✅ **State Handling**
- [ ] Loading state implemented
- [ ] Empty state designed
- [ ] Error state handled
- [ ] Success state visible
- [ ] Disabled states clear

✅ **Navigation**
- [ ] Proper route configuration
- [ ] Back button functionality
- [ ] Deep linking support
- [ ] Error handling for invalid routes
- [ ] Loading indicators during transitions

✅ **Performance**
- [ ] 60fps animations
- [ ] No janky scrolling
- [ ] Efficient image loading
- [ ] Minimal rebuilds
- [ ] No memory leaks

✅ **Material 3 Compliance**
- [ ] Uses Material 3 components
- [ ] Follows M3 guidelines
- [ ] Proper theming
- [ ] Consistent with design system
- [ ] No custom non-M3 widgets

✅ **Dark Mode Support**
- [ ] Light theme implemented
- [ ] Dark theme implemented
- [ ] Automatic switching
- [ ] Equal attention to both
- [ ] No hardcoded colors

✅ **Animation Quality**
- [ ] Smooth transitions (60fps)
- [ ] Appropriate durations
- [ ] Consistent curves
- [ ] Purposeful motion
- [ ] Respects motion preferences

✅ **Content Quality**
- [ ] Realistic mock data
- [ ] Proper text capitalization
- [ ] Correct grammar/spelling
- [ ] Appropriate imagery
- [ ] Cultural sensitivity

### Review Process

1. **Self-Check**: Developer verifies all checklist items
2. **Peer Review**: Another developer validates implementation
3. **Design Review**: UI/UX team approves visuals
4. **QA Testing**: Functional and visual testing
5. **Accessibility Audit**: Automated + manual testing

### Common Pitfalls

❌ **Inconsistent Spacing**: Mixing different padding values
❌ **Color Overuse**: Too many accent colors
❌ **Typography Chaos**: Mixing too many font styles
❌ **Animation Overload**: Distracting transitions
❌ **Ignoring States**: Missing loading/error states
❌ **Hardcoded Values**: Magic numbers in layouts
❌ **Overflow Issues**: Text or widgets exceeding bounds
❌ **Performance Issues**: Janky animations or scrolling

## Implementation Guidelines

### For Developers

1. **Start with Existing Components**
   - Reuse PrimaryButton, SecondaryButton, etc.
   - Follow established patterns
   - Extend rather than recreate

2. **Use the Design System**
   - Import AppColors, AppTypography, AppSpacing
   - Never hardcode values
   - Follow the spacing scale religiously

3. **Implement States First**
   - Loading → Empty → Error → Success
   - Test all states before adding content
   - Use LoadingWidget, EmptyStateWidget, ErrorStateWidget

4. **Responsive from Start**
   - Use LayoutBuilder for adaptive layouts
   - Test on multiple screen sizes
   - Consider orientation changes

5. **Accessibility First**
   - Check contrast ratios
   - Add semantic labels
   - Test with screen readers
   - Support font scaling

### For Designers

1. **Stick to the System**
   - Use defined colors and typography
   - Follow spacing guidelines
   - Maintain component consistency

2. **Design for States**
   - Create all states for every component
   - Specify loading and error conditions
   - Define empty state illustrations

3. **Consider Motion**
   - Specify animation types
   - Define durations and curves
   - Indicate trigger points

4. **Responsive Thinking**
   - Design for mobile first
   - Plan tablet adaptations
   - Consider landscape modes

5. **Document Decisions**
   - Explain design choices
   - Specify edge cases
   - Provide usage examples

## Future Evolution

### Versioning

**v1.0** - Current foundation
**v1.1** - Add illustration system
**v1.2** - Motion enhancements
**v1.3** - Dark mode refinements
**v2.0** - Component library expansion

### Maintenance

- Quarterly design reviews
- Bi-annual accessibility audits
- Continuous developer feedback
- Usage analytics monitoring
- Competitive analysis

### Governance

- Design system owner
- Contribution guidelines
- Change request process
- Version deprecation policy
- Breaking change communication

## Conclusion

This design system establishes Ironit's premium visual identity while maintaining flexibility for future growth. By adhering to these guidelines, we ensure a consistent, high-quality user experience across all platforms and screen sizes.

**Key Principles:**
1. **Consistency**: Unified experience across all touchpoints
2. **Quality**: Premium feel without unnecessary complexity
3. **Accessibility**: Inclusive design for all users
4. **Performance**: Smooth 60fps interactions
5. **Maintainability**: Easy to update and extend

Every screen, component, and interaction should reflect Ironit's brand values: professional, trustworthy, modern, and efficient. This system provides the foundation for building a world-class mobile application that users will love to use daily.