import React, { useState, useEffect} from 'react';
import './styles.css';
//import HomePage from '../HomePage';
import Login from '../Login';
//import Register from '../Register';
import Dashboard from '../Dashboard';
import { MuiThemeProvider, createMuiTheme } from '@material-ui/core/styles';
import { CssBaseline, CircularProgress } from '@material-ui/core';
import { BrowserRouter as Router, Switch, Route } from 'react-router-dom';
import firebase from '../firebase';

const theme = createMuiTheme({
  palette: {
    primary: {
      // light: will be calculated from palette.primary.main,
      main: '#15c3a5',
      // dark: will be calculated from palette.primary.main,
      // contrastText: will be calculated to contrast with palette.primary.main
      contrastText: '#fff'
    },
    secondary: {
      light: '#0066ff',
      main: '#4974a5',
      // dark: will be calculated from palette.secondary.main,
      //contrastText: '#ffcc00',
    },
    // Used by `getContrastText()` to maximize the contrast between
    // the background and the text.
    contrastThreshold: 3,
    // Used by the functions below to shift a color's luminance by approximately
    // two indexes within its tonal palette.
    // E.g., shift from Red 500 to Red 300 or Red 700.
    tonalOffset: 0.2,
  },
});

export default function App() {

	const [firebaseInitialized, setFirebaseInitialized] = useState(false)


	useEffect(() => {
		firebase.isInitialized().then(val =>{
			setFirebaseInitialized(val)
		})
	})

	return firebaseInitialized !== false ? (
		<MuiThemeProvider theme={theme}>
			<CssBaseline />
			<div> som text </div>
			<Router>
				<Switch>
					{/*<Route exact path="/" component={HomePage} /> */}
					<Route exact path="/" component={Login} />
					{/* /<Route exact path="/register" component={Register} /> */}
					<Route exact path="/dashboard" component={Dashboard} />
				</Switch>
			</Router>
		</MuiThemeProvider>
	) : <div id = 'loader'> <CircularProgress /> </div>
}