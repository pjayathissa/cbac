import React from 'react';
 
import  { FirebaseContext } from '../Firebase';
 
const HomePage = () => (
  <div className="flex items-center justify-center pa4">
  <a href="#0" className="f5 no-underline black bg-animate hover-bg-black hover-white inline-flex items-center pa3 ba border-box mr4">

    <span className="pl1">Scan QR Code</span>
  </a>
  <a href="#0" className="f5 no-underline black bg-animate hover-bg-black hover-white inline-flex items-center pa3 ba border-box">
    <span className="pr1">Enter Manual</span>

  </a>
</div>
);
 
export default HomePage;