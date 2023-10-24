# Use the Alpine Linux base image
FROM alpine:latest

# Do stuff using a secret passed in as a build argument
ARG MY_SECRET
RUN echo $MY_SECRET > /tmp/secret.txt
RUN cat /tmp/secret.txt
RUN rm /tmp/secret.txt

# Run the `date` command to print the current time and date
CMD ["date"]