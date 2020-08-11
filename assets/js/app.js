import '../css/app.scss';
import 'phoenix_html';
import 'bootstrap';
import * as SimpleMaskMoney from '../../node_modules/simple-mask-money/lib/simple-mask-money.js';
import React from 'react';
import ReactDOM from 'react-dom';
import ImagesArray from './components/productForm/imagesArray';
import AttributesArray from './components/productForm/attributesArray';
import $ from 'jquery';
import ProductSearch from './components/ProductSearch';

const images_array = document.querySelector('[data-target="images"]');
const attributes_array = document.querySelector('[data-target="attributes"]');
const product_search = document.getElementById('product-search');


if (images_array) {
  ReactDOM.render(<ImagesArray {...images_array.dataset} />, images_array);
}

if (attributes_array) {
  ReactDOM.render(<AttributesArray {...attributes_array.dataset} />, attributes_array);
}

if (product_search) {
  ReactDOM.render(<ProductSearch />, product_search);
}

if (document.getElementById('#product_price')) {
  // Default configuration
  const options = {
    allowNegative: false,
    negativeSignAfter: false,
    prefix: 'R$ ',
    suffix: '',
    fixed: true,
    fractionDigits: 2,
    decimalSeparator: ',',
    thousandsSeparator: '.',
    cursor: 'move'
  };

  // set mask on your input you can pass a querySelector or your input element and options
  let input = SimpleMaskMoney.setMask('#product_price', options);
}

$(function () {
  $('[data-toggle="tooltip"]').tooltip();
})
