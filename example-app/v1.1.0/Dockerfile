FROM golang:1.11.0
ENV CGO_ENABLED=0
COPY server.go .
RUN go build -o bin/server .

FROM scratch
COPY --from=0 /go/bin/server /app/server
CMD ["/app/server"]
EXPOSE 8080
