# syntax=docker/dockerfile:1
FROM golang:1.17
WORKDIR /go/src/github.com/bluestoneag/log4j-collector/
COPY . .
RUN CGO_ENABLED=1 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /go/src/github.com/bluestoneag/log4j-collector/app ./
EXPOSE 8080
CMD ["./app"]