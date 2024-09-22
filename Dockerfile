# using go as base image , as we must require go for running the app
FROM golang:1.22.5 as base

# creating dir inside the container
WORKDIR /app

# copying everything from current directary into container 
COPY . /app/

# installing dependcies from go mod file
RUN go mod download 

#building the binary for go app
RUN go build -o main

# stage 2 , reducing img size using docker multistage , using distroless image
FROM gcr.io/distroless/base
# copying the binary from previous stage
COPY --from=base /app/ .
#expose the port 
EXPOSE 8080
# run the binary
CMD ["./main"]



