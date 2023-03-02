# Crown Apparel
Javascript e-commerce application using React and NodeJS

See a running demo here.

http.crownapparel.com

# Local Development

## For Mac users exclusively, after successfully cloning the application from its Github repository:


## Set firebase configuration
---

To replace the config variable in firebase.utils.js with your own configuration object, go to your Firebase project dashboard and select the gear icon for project settings. Scroll down to the config code section, copy the entire object and paste it in the corresponding variable in your code. This will allow you to use your own Firebase configuration in your application.

[firebase website](https://firebase.google.com/)

<br>

## Set stripe demo payment configuration
---

To set up the Stripe demo payment configuration in the crown-apparel directory, create a .env file and include two variables:

`REACT_APP_STRIPE_PUBLISHABLE_KEY=`

`STRIPE_SECRET_KEY=`

<br>

Obtain the publishable and secret keys from the developer test mode on the Stripe website and add them to the .env file in double quotes as strings, without any spaces. This will allow the application to use the Stripe test keys for demonstration purposes.

[stripe website](https://stripe.com/)

<br>

## To build and test locally
To test the app locally at http://localhost:3000

The crown app requires node version 19 and npm

```shell
npm install
npm run build
REACT_APP_FIREBASE_API_KEY=YOURFIREBASEAPIKEY npm start 
```

### Deploying the Crown App to a virtual machine has several advantages over running it locally. 
* Provides an isolated environment for the application, which helps ensure that it runs consistently across all computers. 
* The virtual machine has its own operating system and software dependencies, which are separate from the host computer's operating system.
* Deploying the app to a virtual machine makes it easier to manage and deploy updates. Instead of having to update the app on every local machine, updates can be made to the virtual machine and then deployed to all users at once.
* Deploying the app to a virtual machine allows for better resource management. The virtual machine can be configured to use only the resources needed for the application, which can help optimize performance and prevent conflicts with other software running on the host computer.

## To deploy the Crown App to a local VM
---

* Open the terminal and navigate to the crown-apparel directory.

* Open the cloud-init.yaml file and replace the hard-coded name with your own.

* In the terminal, run the command `bash vm_deploy.sh`

* When prompted, enter your computer password

* Wait for the multipass virtual machine to be created, the app to be configured, and deployed. Once completed, enter the IP address listed followed by localhost:3000 in a browser to view the application running.

* When you are finished using the app, type "exit" into the virtual machine command prompt.

<br>

## To delete the virtual machine and all its contents of the Crown App from localhost:

Run the command `bash vm_destroy.sh` in your local terminal.


![structure](./crown-apparel/DockerImg.png)