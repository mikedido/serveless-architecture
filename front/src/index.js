import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import Put from './pages/Put/index';
import Get from './pages/Get/index';
import Error from './pages/Error/index';
import Home from './pages/Home/index';
import Header from './components/Header/index';
import Footer from './components/Footer/index';
import reportWebVitals from './reportWebVitals';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';


ReactDOM.render(
  <React.StrictMode>
    <Router>  
      <Header />
      <Routes>
        <Route exact path='/' element={<Home />} />
        <Route path='/get' element={<Get />} />
        <Route path='/put' element={<Put />} />
        <Route path='*' element={<Error />} />
      </Routes>
      <Footer />
    </Router>
  </React.StrictMode>,
  document.getElementById('root')
);


// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();
