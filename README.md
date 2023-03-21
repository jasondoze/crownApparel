# Crown Apparel

#### Javascript e-commerce application using React and NodeJS

See a running demo here http.crownapparel.com

#### If NodeJS is installed locally, automation will deploy locally on Darwin and Linux. 

#### If NodeJS is not installed locally, automation will deploy the application on Darwin and Linux via virtual machine.

* To deploy Crown App, run this command in your local terminal:
`bash crownapp_deploy.sh`

* When prompted, enter your computer password

* If VM was not instatiated and you are finished using the app, type `^c` into the terminal to exit.

Test the app locally: http://localhost:3000

* If VM was instatiated and you are finished using the app, type "exit" into the virtual machine command prompt.

* If VM was instantiated, you can delete it and all of its contents from localhost by running this command in your local terminal.
`bash crownapp_destroy.sh` 

#### Build and Deploy to Local VM

#### Build and Deploy to AWS or GCP

#### Build and Deploy using Netlify

#### Set firebase configuration

#### Set netlify serverless to enable stripe

To replace the config variable in firebase.utils.js with your own configuration object, go to your Firebase project dashboard and select the gear icon for project settings. Scroll down to the config code section, copy the entire object and paste it in the corresponding variable in your code. This will allow you to use your own Firebase configuration in your application.

[firebase website](https://firebase.google.com/)

### Set stripe demo payment configuration

To set up the Stripe demo payment configuration in the crown-apparel directory, create a .env file and include two variables:

`REACT_APP_STRIPE_PUBLISHABLE_KEY=`

`STRIPE_SECRET_KEY=`

Obtain the publishable and secret keys from the developer test mode on the Stripe website and add them to the .env file in double quotes as strings, without any spaces. This will allow the application to use the Stripe test keys for demonstration purposes.

[stripe website](https://stripe.com/)

### To build and test locally from the terminal without automation:

The crown app requires node version 19

```shell
npm install
npm run build
REACT_APP_FIREBASE_API_KEY=YOURFIREBASEAPIKEY 
npm start 
```
Test the app locally at http://localhost:3000


#### Deploying the Crown App to a virtual machine has several advantages over running it locally: 
* Provides an isolated environment for the application, which helps ensure that it runs consistently across all computers. 

* The virtual machine has its own operating system and software dependencies, which are separate from the host computer's operating system.

* Deploying the app to a virtual machine makes it easier to manage and deploy updates. Instead of having to update the app on every local machine, updates can be made to the virtual machine and then deployed to all users at once.

* Deploying the app to a virtual machine allows for better resource management. The virtual machine can be configured to use only the resources needed for the application, which can help optimize performance and prevent conflicts with other software running on the host computer.