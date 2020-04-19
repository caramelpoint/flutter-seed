build-dev-apk:
	flutter build apk -t lib/main.dev.dart

build-model:
	flutter pub run build_runner build --verbose --delete-conflicting-outputs
