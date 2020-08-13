import React, { useState } from 'react';
import If from '../templates/If';
import axios from 'axios';

export default () => {
  const [show, setShow] = useState(false);
  const [typingTimeout, setTypingTimeout] = useState(0);
  const [inputText, setInputText] = useState("");
  const [suggestions, setSuggestions] = useState([]);

  return (
    <>
      <a className='nav-link'
        data-toggle="tooltip"
        data-placement="bottom"
        title="Search for products"
        onClick={() => setShow(!show)}>
        <i className="fas fa-2x fa-search"></i>
      </a>
      <If test={show}>
        <div className='search-box'>
          <div className="wrap">
            <div className="search">
              <h4>Search products by name, description...</h4>
              <input
                type="text"
                className="searchTerm"
                placeholder="What are you looking for?"
                value={inputText}
                onChange={(e) => {
                  const newValue = e.target.value;

                  if (typingTimeout) {
                    clearTimeout(typingTimeout);
                  }

                  setInputText(newValue);

                  setTypingTimeout(setTimeout(() => {
                    axios.get('/text-search', { params: { value: newValue } })
                      .then((res) => setSuggestions(suggestions.concat(res.data)))
                  }, 500));
                }} />
            </div>
            <div className="suggestions" style={{ height: `${suggestions.length * 25}px` }}>
                {console.log(suggestions.length)}
              {
                suggestions.map((suggestion, index) => {
                  return (
                    <div>
                      <a href={`/products/${suggestion.id}`}>
                        <span key={index}>{suggestion.name}</span>
                        <span key={1000 - index}>{suggestion.department}</span>
                      </a>
                    </div>
                  );
                })
              }
            </div>
          </div>
        </div>
      </If>
    </>
  );
}
