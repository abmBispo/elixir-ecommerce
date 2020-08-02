import '../css/app.scss';
import 'phoenix_html';
import 'bootstrap';
import React from 'react';
import ReactDOM from 'react-dom';
import ImagesArray from './components/productForm/imagesArray';
import AttributesArray from './components/productForm/attributesArray';

const images_array = document.querySelector('[data-target="images"]');
const attributes_array = document.querySelector('[data-target="attributes"]');

if (images_array) {
  ReactDOM.render(<ImagesArray {...images_array.dataset} />, images_array);
}

if (attributes_array) {
  ReactDOM.render(<AttributesArray {...attributes_array.dataset} />, attributes_array);
}
