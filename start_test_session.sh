#!/bin/sh

source lib/.env
flutter run -d chrome --web-hostname localhost --web-port 5000 --dart-define=RECAPTCHA_SITE_KEY="${RECAPTCHA_SITE_KEY}"