import React, { useEffect, useState } from 'react'
import { Typography, Paper, Avatar, CircularProgress, Button } from '@material-ui/core'
import VerifiedUserOutlined from '@material-ui/icons/VerifiedUserOutlined'
import withStyles from '@material-ui/core/styles/withStyles'
import firebase from '../firebase'
import {Link, withRouter } from 'react-router-dom'

import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableCell from '@material-ui/core/TableCell';
import TableContainer from '@material-ui/core/TableContainer';
import TableHead from '@material-ui/core/TableHead';
import TableRow from '@material-ui/core/TableRow';

const styles = theme => ({
	main: {
		width: 'auto',
		display: 'block', // Fix IE 11 issue.
		marginLeft: theme.spacing(1),
		marginRight: theme.spacing(1),
		[theme.breakpoints.up(400 + theme.spacing(3) * 2)]: {
			width: 400,
			marginLeft: 'auto',
			marginRight: 'auto',
		},
	},
	paper: {
		marginTop: theme.spacing(1),
		display: 'flex',
		flexDirection: 'column',
		alignItems: 'center',
		padding: `${theme.spacing(1)}px ${theme.spacing(1)}px ${theme.spacing(1)}px`,
	},
	avatar: {
		margin: theme.spacing(1),
		backgroundColor: theme.palette.secondary.main,
	},
	submit: {
		marginTop: theme.spacing(3),
	},
})

function LabelOutput(props) {
	const { classes } = props

	if(!firebase.getCurrentUsername()) {
		// not logged in
		//alert('Please login first')
		props.history.replace('/')
		return null
	}

	var isData = false
	if (props.location.userData){
		isData = true
		console.log(props.location.userData.firstName)
		var userData = props.location.userData
	}

	const currentDate = new Date()


	return (
		<main className={classes.main}>
			    <TableContainer component={Paper}>
			      <Table className={classes.table} aria-label="simple table">
			        <TableBody>
			            <TableRow >
			              <TableCell component="th" scope="row">Patient Name</TableCell>
			              <TableCell align="right"> {isData ? userData.firstName : ""} </TableCell>
			             </TableRow>
			             <TableRow >
			              <TableCell component="th" scope="row"> NHI Number</TableCell>
			              <TableCell align="right">{isData ? userData.nhi : ""}</TableCell>
			            </TableRow>
			            <TableRow >
			              <TableCell component="th" scope="row">Date Taken</TableCell>
			              <TableCell align="right">{`${currentDate.getDate()} - ${currentDate.getMonth()} - ${currentDate.getFullYear()}`}</TableCell>
			            </TableRow>
			        </TableBody>
			      </Table>
			    </TableContainer>
		</main>
	)

	async function logout() {
		await firebase.logout()
		props.history.push('/')
	}
}

export default withRouter(withStyles(styles)(LabelOutput))