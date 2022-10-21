Scaffolding the project
npx create-react-app
remove unused code from app.css
change app.js to const App arrow function
create containers for the home page

add Sass for reacte CSS rendering
npm add sass
download and add fonts

npm npm add react-router-dom@6
import browser router from react router dom
import Link, and Outlet

setup firebase to spin up a database 
install firebase library in the project
npm add firebase

set up a signin in crown apparel

CRUD
create
read- fetch
update- change the data
delete

Optional: How to fix 403: restricted_client error
It's possible you may encounter a google Authorization error that says 403:restricted_client. If you do, here are the instructions to fix it!

There should be a Learn More link in the popup, clicking that should take you to the Google APIs console that has three tabs under the header named Credentials, OAuth Consent Screen, and Domain Verification. Go to the OAuth Consent Screen tab and update the Application Name to "crwn-clothing" or any other name you're comfortable with (i.e. the name of your project). Click on save at the bottom, then try logging into your verified Google account thereafter.

# Firebase Config
set up a utils directory for firebase
create a firebase directory in utils
create a firebase.utils.js file in firebase3
set up firebase
authenticate firebase
enable firebase

create a button to sigin to google auth in sign in page
creates an access token to create CRUD requests

# Firestore Database
after a user is authenticated we will also store a record of them in firestore
collection contains the document with data
document contains the data // pretty much JSON objects
data actual user information

-collection would be multiples of the data below

NikeAirMax -document
  -data
  name: "Air Max"
  brand: "Nike"
  imageURL: 'wwww....."
  cost: 
    price: 150
    currency: "USD"

# Setting up user documents
go into firestore database
create database
start in production mode
click next
click closest us central
click enable
we now have an emtpy database
click edit rules
change read, write: if true; // defines who can modify docs
click publish

in the app- firebase.utils.js
import { getFirestore, doc, getDoc, setDoc } from 'firebase/firestore';


# Create a new provider for email/password
in Firebase, add new provider- email/password


# Getting Started with Create React App

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

## Available Scripts

In the project directory, you can run:

### `npm start`

Runs the app in the development mode.\
Open [http://localhost:3000](http://localhost:3000) to view it in your browser.

The page will reload when you make changes.\
You may also see any lint errors in the console.

### `npm test`

Launches the test runner in the interactive watch mode.\
See the section about [running tests](https://facebook.github.io/create-react-app/docs/running-tests) for more information.

### `npm run build`

Builds the app for production to the `build` folder.\
It correctly bundles React in production mode and optimizes the build for the best performance.

The build is minified and the filenames include the hashes.\
Your app is ready to be deployed!

See the section about [deployment](https://facebook.github.io/create-react-app/docs/deployment) for more information.

### `npm run eject`

**Note: this is a one-way operation. Once you `eject`, you can't go back!**

If you aren't satisfied with the build tool and configuration choices, you can `eject` at any time. This command will remove the single build dependency from your project.

Instead, it will copy all the configuration files and the transitive dependencies (webpack, Babel, ESLint, etc) right into your project so you have full control over them. All of the commands except `eject` will still work, but they will point to the copied scripts so you can tweak them. At this point you're on your own.

You don't have to ever use `eject`. The curated feature set is suitable for small and middle deployments, and you shouldn't feel obligated to use this feature. However we understand that this tool wouldn't be useful if you couldn't customize it when you are ready for it.

## Learn More

You can learn more in the [Create React App documentation](https://facebook.github.io/create-react-app/docs/getting-started).

To learn React, check out the [React documentation](https://reactjs.org/).

### Code Splitting

This section has moved here: [https://facebook.github.io/create-react-app/docs/code-splitting](https://facebook.github.io/create-react-app/docs/code-splitting)

### Analyzing the Bundle Size

This section has moved here: [https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size](https://facebook.github.io/create-react-app/docs/analyzing-the-bundle-size)

### Making a Progressive Web App

This section has moved here: [https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app](https://facebook.github.io/create-react-app/docs/making-a-progressive-web-app)

### Advanced Configuration

This section has moved here: [https://facebook.github.io/create-react-app/docs/advanced-configuration](https://facebook.github.io/create-react-app/docs/advanced-configuration)

### Deployment

This section has moved here: [https://facebook.github.io/create-react-app/docs/deployment](https://facebook.github.io/create-react-app/docs/deployment)

### `npm run build` fails to minify

This section has moved here: [https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify](https://facebook.github.io/create-react-app/docs/troubleshooting#npm-run-build-fails-to-minify)
