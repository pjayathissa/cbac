import React from 'react';

import 'tachyons';

function Header() {
    return(
        <nav className="dt w-100 mw8 center bg-custom-teal white pv4 tc">
            <div className="row col-12 d-flex justify-content-center text-white">
            <span className="f3">Sign In</span>
            </div>
        </nav>
    )
}
export default Header;