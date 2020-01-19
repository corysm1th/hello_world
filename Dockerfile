FROM golang AS builder

WORKDIR /go/src
RUN mkdir -p github.com/corysm1th/hello_world
WORKDIR /go/src/github.com/corysm1th/hello_world

# Grab build dependencies
COPY go.mod go.sum /
RUN go mod download

# Build the project
COPY . .
RUN make build

# Copy artifact to a new scratch container
FROM scratch
COPY --from=builder /go/src/github.com/corysm1th/hello_world/hello_world .
CMD ["/hello_world"]
EXPOSE 80/tcp