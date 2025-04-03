# Hong Kong Arcade Info

A simple app to show arcade information in Hong Kong.

> [!NOTE]
> This `README` is still under construction. Sorry for the mess!

Tree
```
hkarcadequeue
├── android // Android related files - not used at this stage
├── ios     // iOS related files - not used at this stage
├── lib     // Main source code
│  ├── src
│  │  ├── constant // Constants used in the app
│  │  ├── controller
│  │  │  ├── delegate
│  │  │  └── provider
│  │  │     ├── arcade_provider
│  │  │     └── theme_provider
│  │  ├── model
│  │  │  ├── auth
│  │  │  ├── queries
│  │  │  ├── type
│  │  │  └── utility
│  │  ├── view                          // These are the full-page widgets you see in the app
│  │  │  ├── screen
│  │  │  │  ├── arcade_queue_status     // widget list of all arcades
│  │  │  │  │  ├── arcade_details       // widget of an arcade's details
│  │  │  │  │  └── arcade_queue_screen.dart
│  │  │  │  ├── landing_screen          // widget of the landing page. i.e. the initial page
│  │  │  │  │  └── landing_screen.dart
│  │  │  │  └── settings_screen
│  │  │  │     ├── dialogs              // possible popups, aka dialogs
│  │  │  │     └── settings_page.dart
│  │  │  ├── theme                      // Theme related files 
│  │  │  └── widget                     // Some complicated widgets extracted out from view
│  │  │     ├── arcade_details_button   // used in arcade_details
│  │  │     │  ├── dialogs
│  │  │     │  │  └── report_dialog.dart
│  │  │     │  ├── arcade_list_builder.dart
│  │  │     │  ├── report_button.dart
│  │  │     │  └── star_button.dart
│  │  │     ├── landing_page_button     // used in landing_page to construct buttons in that view
│  │  │     │  └── landing_page_button.dart
│  │  │     ├── settings_sign_in_button // Sign in button in settings page
│  │  │     │  └── sign_in_button.dart
│  │  │     ├── app_bar.dart            // App bar used in all pages
│  │  │     └── crowdness_visualizer.dart
│  ├── firebase_options.dart            // NOT INCLUDED IN VERSION CONTROL
│  └── main.dart
├── web
│  ├── _next                            // Next.js caches
│  ├── icons
│  │  ├── Icon-192.png
│  │  ├── Icon-512.png
│  │  ├── Icon-maskable-192.png
│  │  └── Icon-maskable-512.png
│  ├── 404.html                         // 404 page
│  ├── favicon.ico
│  ├── index.html                       // Main page with flutter bootstrap
│  ├── manifest.json
│  └── privacy.html                     // privacy policy page
├── .gitignore
├── .metadata
├── COPYING
├── LICENSE
├── README.md
├── analysis_options.yaml
├── devtools_options.yaml
├── pubspec.lock
└── pubspec.yaml
```