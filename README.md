# After cloning application

## Set firebase configuration
Replace the config variable in firebase.utils.js with your own config object from the firebase dashboard. Navigate to the project settings gear icon project settings and scroll down to the config code. Copy the object in the code and replace the variable in your code.

https://firebase.google.com/

## Set stripe demo payment configuration
In the crown-apparel directory, create a .env file with 2 variables:
`REACT_APP_STRIPE_PUBLISHABLE_KEY=`
`STRIPE_SECRET_KEY=`

On the stripe website, get the publishable and secret key from the developers test mode and add the keys without spaces as a string in double quotes.

https://stripe.com/ 

## Deploy Crown App from localhost
1. Navigate to crown-apparel directory

2. Enter name into cloud-config.yaml (my name is hard-coded in, this is a conflict for the subshell commands)

3. From the command line, run `bash deploy.sh`

4. Enter your computer password when prompted.
   
5. Wait for the multipass virtual machine to be created and the app to be configured and deployed. When it has completed, type the IP address listed followed by :3000 in a browser to view the application running.

6. When finished with the app, type `exit` into the virtual machine command prompt.

7. Back in your local terminal, run the command `bash destroy.sh` to delete the virtual machine and all contents.

