import React, { useState, useEffect } from 'react'
import { Typography, Paper, Avatar, Button, FormControl, Input, InputLabel } from '@material-ui/core'
import LockOutlinedIcon from '@material-ui/icons/LockOutlined'
import withStyles from '@material-ui/core/styles/withStyles'
import Checkbox from '@material-ui/core/Checkbox';
import FormGroup from '@material-ui/core/FormGroup';
import FormControlLabel from '@material-ui/core/FormControlLabel';
import { Link, withRouter } from 'react-router-dom'
import firebase from '../firebase'

const styles = theme => ({
	main: {
		width: 'auto',
		display: 'block', // Fix IE 11 issue.
		marginLeft: theme.spacing(3),
		marginRight: theme.spacing(3),
		[theme.breakpoints.up(400 + theme.spacing(3) * 2)]: {
			width: 400,
			marginLeft: 'auto',
			marginRight: 'auto',
		},
	},
	paper: {
		marginTop: theme.spacing(8),
		display: 'flex',
		flexDirection: 'column',
		alignItems: 'center',
		padding: `${theme.spacing(2)}px ${theme.spacing(3)}px ${theme.spacing(3)}px`,
	},
	avatar: {
		margin: theme.spacing(1),
		backgroundColor: theme.palette.secondary.main,
	},
	form: {
		width: '100%', // Fix IE 11 issue.
		marginTop: theme.spacing(1),
	},
	submit: {
		marginTop: theme.spacing(3),
	},
})

function Register(props) {
	const { classes } = props


	// TODO Change to User Object
	const [user, setUser] = useState({
		firstName: '',
		lastName: '',
		street: '',
		city: '',
		postcode: '',
		email: '',
		phone: '',
		nhi: '',
	})

	const [symptoms, setSymptoms] = useState({"cough": false,
											    "fever": false,
											    "soreThroat": false,
											    "breath": false,
											    "coryza": false,
											    "anosmia":false,
											    "diarrhoea":false,
											    "headache":false,
											    "myalgia":false,
											    "nausea":false,
											    "confusion":false,
											    "other": false,
												})

	const symptomLabels = {"cough": "Cough",
							"fever": "Fever",
							"soreThroat": "Sore Throat",
							"breath": "Shortness of Breath",
							"coryza": "Coryza",
							"anosmia": "Anosmia",
							"other": "other",
							"diarrhoea": "Diarrhoea",
							"headache": "Headache",
							"myalgia": "Myalgia",
							"nausea": "Nausea",
							"confusion": "Confusion",
												}


	const [fever, setFever] = useState(false)

	const [password, setPassword] = useState('')

	// // Similar to componentDidMount and componentDidUpdate:
	// useEffect(() => {
	// 	console.log("effect launched")
		
	
 //  });

 	// need to pass props into useEffect to prevent an infinite loop.
 	// https://stackoverflow.com/questions/53715465/can-i-set-state-inside-a-useeffect-hook
	useEffect(() => {
			if (props.location.customNameData){
				//TODO> This is terribly hacky
				const firstSplit = props.location.customNameData.split('{');
				var patientData = firstSplit[0].split(',');
				const patientSymptomsString =  firstSplit[1].split('}')[0].split(',')
				
				patientSymptomsString.map(symptom => {
					//const symptomString = symptom.split(':')
					let key = symptom.split(':')[0].trim()
					let val = (symptom.split(':')[1].trim() == 'true')
					patientSymptoms[key] = val
				})

				// This syntax is required to prevent an infiite loop
				setUser(state => ({ ...state, 
									firstName: patientData[0],
									lastName: patientData[1],
									street: patientData[2],
									city: patientData[3], 
									postcode: patientData[4],
									email: patientData[5],
									phone: patientData[6] 
								}));
			}
	}, [props]);

	console.log(user)

	if(!firebase.getCurrentUsername()) {
		// not logged in
		//alert('Please login first')
		props.history.replace('/')
		return null
	}



	//JSON.parse('{["name", "Skip", "age":2,"favoriteFood":"Steak"]}')

	var patientData = false
	var patientSymptoms = symptoms
	if (props.location.customNameData){
		//TODO> This is terribly hacky
		const firstSplit = props.location.customNameData.split('{');
		var patientData = firstSplit[0].split(',');
		const patientSymptomsString =  firstSplit[1].split('}')[0].split(',')
		
		patientSymptomsString.map(symptom => {
			//const symptomString = symptom.split(':')
			let key = symptom.split(':')[0].trim()
			let val = (symptom.split(':')[1].trim() == 'true')
			patientSymptoms[key] = val
		})
	}

	const handleSubmit = (event) => {
        const formData = new FormData(event.target);
        event.preventDefault()
        //console.log(user)
        onRegister()

    }
   // patientData ? setName("test") : null}

	//console.log(array)

	return (
		<main className={classes.main} >
			<Paper className={classes.paper}>
				<Avatar className={classes.avatar}>
					<LockOutlinedIcon />
				</Avatar>
				<Typography component="h1" variant="h5">
					Register Patient
       			</Typography>
				<form className={classes.form} onSubmit={handleSubmit}> 
					<FormControl margin="normal" required fullWidth>
						<InputLabel htmlFor="firstName">First Name</InputLabel>
						<Input id="firstName" name="firstName" autoComplete="off" autoFocus value={user.firstName} onChange={e => {
							const val = e.target.value; 
							setUser(state => ({ ...state, firstName: val}))}} />
					</FormControl>
					<FormControl margin="normal" required fullWidth>
						<InputLabel htmlFor="lastName">Last Name</InputLabel>
						<Input id="lastName" name="lastName" autoComplete="off" autoFocus value={user.lastName} onChange={e => {
							const val = e.target.value; 
							setUser(state => ({ ...state, lastName: val}))}} />
					</FormControl>
					<FormControl margin="normal" required fullWidth>
						<InputLabel htmlFor="street">Street</InputLabel>
						<Input id="street" name="street" autoComplete="off" autoFocus value={user.street} onChange={e => {
							const val = e.target.value; 
							setUser(state => ({ ...state, street: val}))}} />
					</FormControl>
					<FormControl margin="normal" required fullWidth>
						<InputLabel htmlFor="city">Town/City</InputLabel>
						<Input id="city" name="city" autoComplete="off" autoFocus value={user.city} onChange={e => {
							const val = e.target.value; 
							setUser(state => ({ ...state, city: val}))}} />
					</FormControl>
					<FormControl margin="normal" required fullWidth>
						<InputLabel htmlFor="postcode">Post Code</InputLabel>
						<Input id="postcode" name="postcode" autoComplete="off" autoFocus value={user.postcode} onChange={e => {
							const val = e.target.value; 
							setUser(state => ({ ...state, postcode: val}))}} />
					</FormControl>
					<FormControl margin="normal" required fullWidth>
						<InputLabel htmlFor="email">Email Address</InputLabel>
						<Input id="email" name="email" autoComplete="off" value={user.email} onChange={e => {
							const val = e.target.value; 
							setUser(state => ({ ...state, email: val}))}} />
					</FormControl>
					<FormControl margin="normal" required fullWidth>
						<InputLabel htmlFor="phone">Phone Number</InputLabel>
						<Input id="phone" name="phone" autoComplete="off" value={user.phone} onChange={e => {
							const val = e.target.value; 
							setUser(state => ({ ...state, phone: val}))}} />
					</FormControl>
					<FormControl margin="normal" required fullWidth>
						<InputLabel htmlFor="nhi">NHI Number</InputLabel>
						<Input id="nhi" name="nhi" autoComplete="off" value={user.nhi} onChange={e => {
							const val = e.target.value; 
							setUser(state => ({ ...state, nhi: val}))}} />
						<Button
						fullWidth
						variant="contained"
						color="primary"
						className={classes.submit}>
						TODO: Look Up NHI
          			</Button>
					</FormControl>

					<FormGroup row>
					{Object.entries(symptoms).map( symptom =>(

				      <FormControlLabel
				        control={<Checkbox checked={patientSymptoms[symptom[0]]} onChange={e=> {
				        	const val = e.target.checked
				        	setSymptoms(prevState => {
				        		return {...prevState, [symptom[0]] : val}
				        	})
				        }}  
				        name={symptom[0]} />}
				        label={symptomLabels[symptom[0]]}
				        key = {symptom[0]}
				      />
					))}

				      </FormGroup>

					{/*
					<FormControl margin="normal" required fullWidth>
						<InputLabel htmlFor="password">Password</InputLabel>
						<Input name="password" type="password" id="password" autoComplete="off" value={password} onChange={e => setPassword(e.target.value)}  />
					</FormControl>
					<FormControl margin="normal" required fullWidth>
						<InputLabel htmlFor="quote">Your Favorite Quote</InputLabel>
						<Input name="quote" type="text" id="quote" autoComplete="off" value={quote} onChange={e => setQuote(e.target.value)}  />
					</FormControl>
				*/}

					<Button
						type="submit"
						fullWidth
						variant="contained"
						color="primary"
						className={classes.submit}>
						Register
          			</Button>

					<Button
						//type="submit"
						fullWidth
						variant="contained"
						color="secondary"
						component={Link}
						to="/qrcode"
						className={classes.submit}>
						Go back to Scan
          			</Button>
				</form>
			</Paper>
		</main>
	)

	

	async function onRegister() {

		// setFirstName(document.getElementById('firstName').value)
		// setLastName(document.getElementById('lastName').value)
		// setStreet(document.getElementById('street').value)
		// setCity(document.getElementById('city').value)
		// setPostcode(document.getElementById('postcode').value)
		// setEmail(document.getElementById('email').value)
		// setPhone(document.getElementById('phone').value)


		try {
			console.log(user)
			await firebase.registerPatient(user)
			props.history.push({
		        pathname: '/dashboard',
		        userData: user,
		      });
			//props.history.replace('/dashboard')
		} catch(error) {
			alert(error.message)
		}
	}
}

// {symptoms.map( symptom =>(
// 				      <FormControlLabel
// 				        control={<Checkbox checked={false} onChange={e=> {
// 				        	const val = e.target.checked;
// 				        	//symptom.value = val
// 				        	console.log(symptom)
// 				        	setSymptoms([...symptoms].map(object => {
// 				        		if (object.name === symptom.name) {
// 				        			console.log(object.name)
// 				        			return {...object,
// 				        					value: val}
// 				        		} else return object
				        		
// 				        		}))
				        	
// 				        	// 	prevState => {
// 				        	// 	return {...prevState, symptom.value : val}
// 				        	// })
// 				        }}  
// 				        name={symptom.name}/>}
// 				        label={symptom.display}
// 				      />
// 					))}

export default withRouter(withStyles(styles)(Register))