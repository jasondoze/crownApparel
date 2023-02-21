# Use the Ubuntu base image
FROM ubuntu

# Install required packages for the build
RUN apt-get update && apt-get install -y sudo curl unzip net-tools

# Create a directory to store the application in the container
WORKDIR /crown-apparel

# Copy the local application directory to the container
COPY . /crown-apparel/

# Run script to install Node.js
RUN bash ./nodejs_install.sh

# Expose port 3000 for the application to listen on
EXPOSE 3000

CMD ["npm", "start"]