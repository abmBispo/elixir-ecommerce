import '../css/app.scss';
import 'phoenix_html';
import 'bootstrap';
import React from 'react';
import ReactDOM from 'react-dom';
import ProductForm from './components/ProductForm';

const images_array = document.querySelector('[data-target="images"]');
const attributes_array = document.querySelector('[data-target="attributes"]');

if (images_array) {
  ReactDOM.render(<ProductForm {...images_array.dataset} />, images_array);
}

if (attributes_array) {
  ReactDOM.render(<ProductForm {...attributes_array.dataset} />, attributes_array);
}
