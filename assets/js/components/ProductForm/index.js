import React from 'react';
import { Formik, FieldArray } from "formik";
import If from '../templates/If';

const initialValues = { images: [] };

function renderImages(images, arrayHelpers, setFieldValue) {
  return images.map((image, index) => (
    <input
      key={index}
      type="file"
      name={`images[${index}]`}
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
                {renderImages(values.images, arrayHelpers, setFieldValue)}
              </If>
              <button type="button" onClick={() => arrayHelpers.push("")}>Add a Image</button>
            </div>
          )}
        />
      </div>
    </div>
  );
}

export default () => (
  <Formik initialValues={initialValues}>
    {formContent}
  </Formik>
);
