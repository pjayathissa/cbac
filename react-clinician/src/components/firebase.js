import app from 'firebase/app';
import 'firebase/auth';
import 'firebase/firebase-firestore';


const firebaseConfig = {
  apiKey: process.env.REACT_APP_API_KEY,
  authDomain: process.env.REACT_APP_AUTH_DOMAIN,
  databaseURL: process.env.REACT_APP_DATABASE_URL,
  projectId: process.env.REACT_APP_PROJECT_ID,
  storageBucket: process.env.REACT_APP_STORAGE_BUCKET,
  messagingSenderId: process.env.REACT_APP_MESSAGING_SENDER_ID,
  appId: process.env.REACT_APP_APP_ID,
};


class Firebase {
	constructor() {
		app.initializeApp(firebaseConfig);
		this.auth = app.auth();
		this.db = app.firestore();
	}

	async login(email, password) {
		await this.auth.signInWithEmailAndPassword(email, password)
		// console.log("do firebase function now")
		// await this.auth.currentUser.updateProfile({
		// 	phoneNumber: 1
		// })
		// console.log(this.auth.currentUser)
		return this.auth.currentUser;
		
	}


	//TODO: pipe data to secure database
	registerPatient(user) {
		if(!this.auth.currentUser) {
			return alert('Not authorized')
		}
		let autoID = this.db.collection('someplace').doc().id;
		let docRef = this.db.collection('patients').doc(autoID)

		let setUser = docRef.set(user)
		return setUser
	}

	logout() {
		return this.auth.signOut();
	}

	isInitialized() {
		return new Promise(resolve =>{
			this.auth.onAuthStateChanged(resolve)
		})
	}

	getCurrentUsername() {
		return this.auth.currentUser
	}
}

export default new Firebase()