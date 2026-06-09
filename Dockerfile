# Build the web app with the pinned Flutter SDK, then serve it with nginx.
FROM ghcr.io/cirruslabs/flutter:3.44.0 AS build
WORKDIR /app
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get --enforce-lockfile
COPY . .
RUN flutter analyze --no-pub \
 && flutter test --no-pub \
 && flutter build web --no-pub --release --no-web-resources-cdn

FROM nginx:1.30-alpine
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 80
