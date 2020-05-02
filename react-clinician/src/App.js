import React, { Component } from 'react';
import {
  BrowserRouter as Router,
  Route,
} from 'react-router-dom';
import { withFirebase } from './components/Firebase';

import logo from './logo.svg';
import './App.css';

import Header from './components/Header/Header';
import Navigation from './components/Navigation/Navigation';
import SignInPage from './components/SignIn/index.js';
import HomePage from './components/Home/Home';
import * as ROUTES from './constants/routes';

import { AuthUserContext } from './components/Session';

import 'tachyons';

class App extends Component {
  constructor(props) {
    super(props);
 
    this.state = {
      authUser: null,
    };
  }

  componentDidMount() {
    this.listener = this.props.firebase.auth.onAuthStateChanged(
      authUser => {
      authUser
        ? this.setState({ authUser })
        : this.setState({ authUser: null });
    });
  }

  // to prevent memory leaks if the component unmounts
  componentWillUnmount() {
    this.listener();
  }
 
  render() {
    console.log(this.state.authUser);
    return (
       <AuthUserContext.Provider value={this.state.authUser}>
      <Router>
      {authUser =>
        authUser ? <HomePage /> : <SignInPage />
      }
        <div>
          <Navigation />
 
          <hr/>
 
          <Route path={ROUTES.SIGN_IN} component={SignInPage} />
          <Route path={ROUTES.HOME} component={HomePage} />
        </div>
      </Router>
      </AuthUserContext.Provider>
    );
  }

}
 
export default withFirebase(App);
