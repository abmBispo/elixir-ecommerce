import React, { useState } from 'react';
import If from '../templates/If';

export default () => {
  const [show, setShow] = useState(false);

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
          <div class="wrap">
            <div class="search">
                <input type="text" class="searchTerm" placeholder="What are you looking for?" />
                <button type="submit" class="searchButton">
                  <i class="fa fa-search"></i>
              </button>
            </div>
          </div>
        </div>
      </If>
    </>
  );
}
