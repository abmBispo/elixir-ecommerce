import '../css/app.scss';
import 'phoenix_html';
import 'bootstrap';
import React from 'react';
import ReactDOM from 'react-dom';
import ProductForm from './components/ProductForm';

const new_product = document.getElementById('react-new-product-form');

if (new_product) {
  ReactDOM.render(<ProductForm />, new_product);
}
