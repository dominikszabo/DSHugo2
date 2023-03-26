# First stage: Build the Hugo static website
FROM alpine:latest AS builder
RUN apk add --no-cache hugo
WORKDIR /app
COPY . .
RUN hugo --minify

# Second stage: Serve the Hugo static website using Nginx
FROM nginx:alpine
COPY --from=builder /app/public /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
