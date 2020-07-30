import React from 'react';
import { Formik, FieldArray } from "formik";
import If from '../templates/If';

function renderImages(images, setFieldValue) {
  return images.map((image, index) => (
    <input
      key={index}
      type="file"
      name={`product[images][${index}]`}
      onChange={(event) => {
        setFieldValue(`images[${index}]`, event.currentTarget.files[0]);
      }} />
  ));
}

function formContent({ values, setFieldValue }) {
  return (
    <div className='form-row'>
      <div className='form-group col-12'>
        <FieldArray name="images"
          render={(arrayHelpers) => (
            <div>
              <If test={values.images.length > 0}>
                {renderImages(values.images, setFieldValue)}
              </If>
              <button type="button" onClick={() => arrayHelpers.push("")}>Add a Image</button>
            </div>
          )}
        />
      </div>
    </div>
  );
}

export default (props) => (
  <Formik initialValues={{ images: [] }}>
    {formContent}
  </Formik>
);
