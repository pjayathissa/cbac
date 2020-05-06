import React, { Component } from 'react'
import QrReader from 'react-qr-reader'
import withStyles from '@material-ui/core/styles/withStyles'
import { Typography, Paper, Avatar, Button, FormControl, Input, InputLabel } from '@material-ui/core'
import {Link, withRouter } from 'react-router-dom'
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
    //display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    padding: `${theme.spacing(2)}px ${theme.spacing(3)}px ${theme.spacing(3)}px`,
  },
  avatar: {
    margin: theme.spacing(1),
    backgroundColor: theme.palette.primary.main,
  },
  form: {
    width: '100%', // Fix IE 11 issue.
    marginTop: theme.spacing(1),
  },
  submit: {
    marginTop: theme.spacing(3),
  },
});

// TODO: maybe consider using a funcitonal component in the future
class QRCode extends Component {
  constructor(props) {
    super(props);
  }

  componentDidMount(){
    if(!firebase.getCurrentUsername()) {
      // not logged in
      //alert('Please login first')
      this.props.history.replace('/')
      return null
    }
  }

  //const [email, setEmail] = useState('')

  state = {
    result: 'No result'
  }
 
  handleScan = data => {
    if (data) {
      console.log(data)
      this.props.history.push({
        pathname: '/register',
        customNameData: data,
      });
      this.setState({
        result: data
      })
    }
  }
  handleError = err => {
    console.error(err)
  }

  componentWillUnmount() {
    //TODO: Unmount the QR reaer to precent memory leak
  //console.log("unmounting qr reader");
  }

  render() {
    const { classes } = this.props;
    return (
      <main className={classes.main}>
        <Paper className={classes.paper}>
          <div>
            <QrReader
              delay={300}
              onError={this.handleError}
              onScan={this.handleScan}
              style={{ width: '100%' }}
            />
            {/*<p>{this.state.result}</p>*/}
          </div>
          <Button
            type="submit"
            fullWidth
            variant="contained"
            color="secondary"
            component={Link}
            to="/register"
            className={classes.submit}>
            Manual Input
                </Button>
        </Paper>
      </main>
    )
  }
}

export default withRouter(withStyles(styles)(QRCode))