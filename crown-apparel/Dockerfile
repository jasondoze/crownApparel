# Use the Ubuntu base image
FROM ubuntu

# Install required packages for the build
RUN apt-get update && apt-get install -y sudo curl unzip net-tools

# Set environment variables for Firebase, Stripe, and Ngrok API keys (these will be passed in as build arguments)
ARG REACT_APP_FIREBASE_API_KEY
ARG REACT_APP_STRIPE_API_KEY
ARG NGROK_AUTH_TOKEN

ENV FIREBASE_API_KEY=$REACT_APP_FIREBASE_API_KEY
ENV STRIPE_API_KEY=$REACT_APP_STRIPE_API_KEY
ENV NGROK_AUTH_TOKEN=$NGROK_AUTH_TOKEN

# Create a directory to store the application in the container
WORKDIR /crown-apparel

# Copy the local application directory to the container
COPY . /crown-apparel/

# Run script to install Node.js
RUN bash ./nodejs_install.sh

# Install ngrok
RUN curl https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o ngrok.zip && \
    unzip ngrok.zip && \
    rm ngrok.zip && \
    chmod +x ngrok && \
    mv ngrok /usr/local/bin/ngrok

# Expose port 3000 for the application to listen on
EXPOSE 3000

# Start ngrok and the application using npm start
# "sh -c" command to starts the "sh" shell in a mode that enables it to execute a single command, which is to run the "ngrok" command to create a tunnel and then start the application using "npm start".
CMD ["sh", "-c", "ngrok http 3000 & npm start"]
# CMD ["npm", "start"]