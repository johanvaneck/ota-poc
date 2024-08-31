FROM golang:1.22-alpine as builder

ARG CGO_ENABLED=0

WORKDIR /app

COPY go.mod go.sum ./

# Needed to add GOPROXY to make go mod download work on the coolify server
RUN GOPROXY=https://goproxy.cn go mod download

COPY . .

RUN go build

FROM scratch
COPY --from=builder /app/ota-poc /ota-poc

EXPOSE 8080

ENTRYPOINT ["/ota-poc"]
