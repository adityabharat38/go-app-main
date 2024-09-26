# Use Go as the base image
FROM golang:1.22.5 AS base

# Set the working directory
WORKDIR /app

# Copy go.mod and go.sum files first (if present), then download dependencies
COPY go.mod  ./
RUN go mod download

# Now copy the remaining application code
COPY . .

# Build the Go binary
RUN go build -o main

# Stage 2 - Use a smaller distroless image for production
FROM gcr.io/distroless/base

# Copy the built binary from the first stage
COPY --from=base /app/main /app/

# Copy the static files from the previous stage
# COPY --from=base /app/static ./static

# Expose the port the app will run on
EXPOSE 8080

# Set the command to run the Go app
CMD ["/app/main"]

# # using go as base image , as we must require go for running the app
# FROM golang:1.22.5 AS base

# # creating dir inside the container
# WORKDIR /app

# # copying everything from current directary into container 
# COPY . /app/

# # installing dependcies from go mod file
# RUN go mod download 

# #building the binary for go app
# RUN go build -o main

# # stage 2 , reducing img size using docker multistage , using distroless image
# FROM gcr.io/distroless/base
# # copying the binary from previous stage
# COPY --from=base /app/ .
# #expose the port 
# EXPOSE 8080
# # run the binary
# CMD ["./main"]



