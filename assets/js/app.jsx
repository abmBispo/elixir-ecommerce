import '../css/app.scss'

import 'phoenix_html'
import 'bootstrap'
import * as React from 'react'
import * as ReactDOM from 'react-dom'
import AppTitle from './src/AppTitle'

// This code starts up the React app when it runs in a browser. It sets up the routing
// configuration and injects the app into a DOM element.
ReactDOM.render(<AppTitle />, document.getElementById('app-title'))
